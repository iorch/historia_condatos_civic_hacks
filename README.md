---
title: "Érase una vez una historia con Datos Abiertos"
author: "Jorge Martínez Ortega"
date: "27 de mayo 2015"
output:
  ioslides_presentation: default
  beamer_presentation:
    fig_height: 6
    fig_width: 8
    keep_tex: yes
#logo: r_logo.png
self_contained: no
fontsize: 9pt
---

## De que trata la plática?
 
- Uno de nuestros insumos principales deben ser los Datos Abiertos.
- ¿Qué son los Datos Abiertos?
- ¿Dónde consigo Datos Abiertos?
 
```{r,echo=FALSE,message=FALSE}
options("digits"=5)
options("digits.secs"=3)
 
```

##Lo primero, descargar los datos.
Existen diversas fuentes de datos publicos abiertos. Entre ellas:

*[http://catalogo.datos.gob.mx/dataset](http://catalogo.datos.gob.mx/dataset)

*[http://datamx.io/dataset](http://datamx.io/dataset)

En particular, este historia usará datos del Subsistema de Información sobre Nacimientos SINAC.

[http://catalogo.datos.gob.mx/dataset/nacimientos-ocurridos](http://catalogo.datos.gob.mx/dataset/nacimientos-ocurridos)

Se necesitan unos 250MB para almacenar las 6 archivos.zip; descomprimidos ocupan 7.8 GB.
Los 6 archivos cubren un periodo de 2008-2013. Todos los scripts desarrollados hasta ahora para esta historia están en [https://github.com/iorch/historia_condatos_civic_hacks](https://github.com/iorch/historia_condatos_civic_hacks)

## 

```{r fig.width=8, fig.height=7, echo=FALSE}
library(png)
library(grid)
img <- readPNG("images/sinac_datos_gob_mx.png")
 grid.raster(img)
```


## Ya tengo los datos, ¿ahora qué sigue?
Se necesita un programa que nos permita manipular los datos de forma "fácil".
Excel no es opción, ya que no está optimizado para manejo de archivos de millones de filas.
En este caso usamos R. [http://www.r-project.org](http://www.r-project.org/)

+ Es un ambiente para el desarrollo de computo estadístico y visualización de graficas matemáticas
+ Es código abierto (GPL) :D
+ Se puede descargar gratuitamente
+ Es multiplataforma (Aunque recomiendo ampliamente usar un sistema tipo Unix (GNU/Linux ó Mac OS))
+ Es "sencillo" de usar.

## Ya tengo los datos, ¿ahora qué sigue? {.smaller}
Descomprimamos los datos (unzip). Veamos cómo se ven los datos.
```{r fig.width=8, fig.height=7}

df <- read.csv(file="SINAC_2008.csv",nrows=1) 
colnames(df)
```
## Decidir qué pregunta queremos responder
Viendo los Nombres de las columnas y el significado que da el archivo de descripción es que podemos plantearnos varias preguntas:

- ¿Cuántos nacimientos hay al año por estado? (o por institución)
- ¿Cuál ha sido la evolución anual en la tasa de mortalidad materna? (por estado, por institución).
- ¿Cuál ha sido la evolución anual en la tasa de mortalidad en recién nacidos? (por estado, por institución).
- Muchas más....

Vamos a tomar la pregunta 3, y empezar el procedimiento para intentar responderla.

## Al tratar con archivos tan grandes surgen problemas {.smaller}
COrremos el riesgo de que la memoria RAM de nuestro equipo no sea suficiente para cargar todos los datos.

`df <- read.csv(file="SINAC_2009.csv")`

`> ERROR session hadabend; LOGGED FROM: core::Error<unnamed>::rInit(const r::session::RInitInfo&) /home/ubuntu/rstudio/src/cpp/session/SessionMain.cpp:1694`

Al leer linea por linea, perdemos algunas de las ventajas del método, `read.csv`. Por lo que tenemos que mapear nuestros datos "manualmete". El script `clean_data.R`, parsea cada fila y mapea cada campo correspondiente. Algunas columnas no pueden mapearse correctamente, así que momentaneamente las dejaremos fuera de nuestro estudio.  

## ¿Y ahora qué sigue?
Necesitamos obtener sólo la información relevante para nuestro estudio.

+ Agregamos los datos por estado y por institución.
+ Separamos los registros que indican el fallecimiento de la madre
+ Calculamos la Tasa de mortalidad materna por institución, y por estado.

Los primeros dos pasos de este procedimiento están en el archivo `agregate.R`

## Resultados
El últimos paso de la transparencia anterior, se hace en el script que también nos muestra resultados visuales, plot_instituciones.R

## Resultados
```{r fig.width=7, fig.height=6, echo=FALSE}
library(png)
library(grid)
img <- readPNG("inst.png")
 grid.raster(img)
```

## Propuesta

Aún falta para convertir este estudio en una verdadera historia con datos, falta mejorar la visualización de los resultados, escribir la historia de una forma atractiva, y porque no, hacer más preguntas interesantes.

Mi propuesta es crear un grupo de trabajo, dónde tratemos de sacar alguna información útil y atractiva para la sociedad.


