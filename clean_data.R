#!/usr/bin/env Rscript

library(hash)
con<-file('SINAC_2013.csv')
open(con)
read.table(con,skip=0,sep=",",nrow=2)
readsizeof <- 1
numberoflines <- 0
entidades<-hash()
while((linesread <- length(line <- readLines(con,readsizeof))) >0 ) {
#print(numberoflines)
line<-gsub(',\\"(.*\\w+),( \\"),',',\\1_\\2,',line)
line<-gsub(',(\\".*\\w+),(\\"),',',\\1_\\2,',line)
line<-gsub(',(\\".*\\w+),(\\w+.*\\"),',',\\1_\\2,',line)
line<-gsub(',(\\".*\\w+),(\\w+.*\\"),',',\\1_\\2,',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',(\\".*\\w+),(\\w+.*\\"),',',\\1_\\2,',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',(\\".*\\w+),( \\w+.*\\"),',',\\1_\\2,',line)
line<-gsub('\\"_\\"','\\",\\"',line)
line<-gsub(',([0-9]+)_([0-9]+),',",\\1,\\2,",line)
line<-gsub(',([0-9]+)_([0-9]+)_([0-9]+),',",\\1,\\2,\\3,",line)
line<-gsub(',([0-9]+)_([0-9]+)_([0-9]+)_([0-9]+),',",\\1,\\2,\\3,\\4,",line)
line<-gsub('([[:alpha:]]+),([[:alpha:]]+)','\\1_\\2',line)
line<-gsub('([[:alpha:]]+),( [[:alpha:]]+)','\\1_\\2',line)
line<-gsub('([[:alpha:]]+),( [[:alpha:]]+)','\\1_\\2',line)
line<-gsub('([[:alpha:]]+ ),([[:alpha:]]+)','\\1_\\2',line)
line<-gsub('([[:alpha:]]\\.),( [[:alpha:]])','\\1_\\2',line)
line<-gsub('([[:alpha:]] ),( [[:alpha:]])','\\1_\\2',line)
line<-gsub('\\), ','\\)_ ',line)
line<-gsub('\\"',"",line)
myvector<-unlist(strsplit(line,','))
if (length(myvector)==59){
write(myvector, file = "sinac2013_clean.csv", ncolumns = 59,append = TRUE, sep = ",")
} else {
write(line, file = "sinac2013_bkg.csv",ncolumns = 1,append = TRUE, sep =)
}
}
