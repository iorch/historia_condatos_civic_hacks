#!/usr/bin/env Rscript
library(hash)
setwd('~/civic_nights')
args <- commandArgs(TRUE)
filename<-args[1]
my_csv<-paste(filename, "csv", sep=".")
my_rda<-paste(filename, "Rda", sep=".")
con<-file(my_csv)
open(con)
read.table(con,skip=0,sep=",",nrow=2)
readsizeof <- 1
numberoflines <- 0
entidades<-hash()
while((linesread <- length(line <- readLines(con,readsizeof))) >0 ) {
#print(numberoflines)
line<-gsub("\"","",line)
myvector<-unlist(strsplit(line,','))
if (is.null(myvector[47]) || is.na(myvector[47]) || myvector[47]==''){
    entidad="unknown"
    institucion="unknown"
} else {
    entidad=substr(myvector[47],1,2)
    institucion=substr(myvector[47],3,5)
}
#if ( is.null(myvector[19]) || is.na(myvector[19]) || myvector[19]==''){
#    institucion="unknown"
#} else {
#    institucion=myvector[19]
#}
if ( is.null(myvector[18]) || is.na(myvector[18]) || myvector[18]=='' || !(myvector[18]=='SI' || myvector[18]=='NO')){
    sobrevivio_madre="unknown"
} else {
    sobrevivio_madre=myvector[18]
}
if ( is.null(myvector[31]) || is.na(myvector[31]) || myvector[31]=='' || as.numeric(myvector[31])>10 || as.numeric(myvector[31])<0){
    apgarh="apgar_unknown"
} else {
    apgarh=myvector[31]
}
if (has.key( entidad, entidades )){
    if (has.key( institucion, entidades[[entidad]] )){
        if (has.key( sobrevivio_madre, entidades[[entidad]][[institucion]])){
            entidades[[entidad]][[institucion]][sobrevivio_madre]<-as.numeric(entidades[[entidad]][[institucion]][[sobrevivio_madre]])+1
        } else {
            entidades[[entidad]][[institucion]][sobrevivio_madre]<-1
        }
        if (has.key( apgarh, entidades[[entidad]][[institucion]])){
            entidades[[entidad]][[institucion]][apgarh]<-as.numeric(entidades[[entidad]][[institucion]][[apgarh]])+1
        } else {
            entidades[[entidad]][[institucion]][apgarh]<-1
        }
    } else {
        entidades[[entidad]][institucion]<-hash()
        entidades[[entidad]][[institucion]][sobrevivio_madre]<-1
        entidades[[entidad]][[institucion]][apgarh]<-1
    }
} else {
    entidades[[entidad]]<-hash()
    entidades[[entidad]][institucion]<-hash()
    entidades[[entidad]][[institucion]][sobrevivio_madre]<-1
    entidades[[entidad]][[institucion]][apgarh]<-1
}
#if (has.key( mykey,instituciones)) {
#    if (has.key( mykey2,instituciones[[mykey]])) {
#    instituciones[[mykey]][mykey2]<-as.numeric(instituciones[[mykey]][[mykey2]])+1
#    } else {
#    instituciones[[mykey]][mykey2]<-1
#    }
#} else {
#instituciones[mykey]<-hash()
#    instituciones[[mykey]][mykey2]<-1
#}
numberoflines <- numberoflines+linesread 
if (numberoflines%%500000 == 10) {
print(numberoflines)
print(entidades)
}
}
close(con)
numberoflines
df <- data.frame(entidad=character(34),sobvv=numeric(34), nsobvv=numeric(34),unknown=numeric(34),apgarh0=numeric(34),
imss_sbvv=numeric(34), imss_nsbvv=numeric(34), imss_u=numeric(34), imss_a0=numeric(34),
ssa_sbvv=numeric(34), ssa_nsbvv=numeric(34), ssa_u=numeric(34), ssa_a0=numeric(34),
smp_sbvv=numeric(34), smp_nsbvv=numeric(34), smp_u=numeric(34), smp_a0=numeric(34),
stringsAsFactors=FALSE);
en<-1
for (e in keys(entidades)){
    sobvv<-0.0
    nsobvv<-0.0
    unknown<-0.0
    apgarh0<-0.0
    for ( i in keys(entidades[[e]]) ){
        i<-iconv(i, "latin1", "ASCII", sub="")
        if (is.null(entidades[[e]][[i]][["SI"]])){
            s<-0.0
        } else {
            s<-as.numeric(entidades[[e]][[i]][["SI"]])
        }

        sobvv<-sobvv+s
        if (is.null(entidades[[e]][[i]][["NO"]])){
            ns<-0.0
        } else {
            ns<-as.numeric(entidades[[e]][[i]][["NO"]])
        }
        nsobvv<-nsobvv+ns
        if (is.null(entidades[[e]][[i]][["unknown"]])){
            u<-0.0
        } else {
            u<-as.numeric(entidades[[e]][[i]][["unknown"]])
        }
        unknown<-unknown+u
         if (is.null(entidades[[e]][[i]][["0"]])){
            a0<-0.0
        } else {
            a0<-as.numeric(entidades[[e]][[i]][["0"]])
        }
        apgarh0<-apgarh0+a0
        if (i=="IMS"){
        df$imss_sbvv[en]<-s
        df$imss_nsbvv[en]<-ns
        df$imss_u[en]<-u
        df$imss_a0[en]<-a0
        } else if(i=="SSA"){
        df$ssa_sbvv[en]<-s
        df$ssa_nsbvv[en]<-ns
        df$ssa_u[en]<-u
        df$ssa_a0[en]<-a0      
        } else if(i=="SMP"){
        df$smp_sbvv[en]<-s
        df$smp_nsbvv[en]<-ns
        df$smp_u[en]<-u
        df$smp_a0[en]<-a0       
        }
    }
    df$entidad[en]<-as.character(e)
    df$sobvv[en]=sobvv
    df$nsobvv[en]=nsobvv
    df$unknown[en]=unknown
    df$apgarh0[en]=apgarh0
    en<-en+1
}
print(sobvv)
print(nsobvv)

print(df)
save(df,file=my_rda)
#print(entidades)
#print(sobrevivio)

