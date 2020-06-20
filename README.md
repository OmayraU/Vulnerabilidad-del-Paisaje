## Rueda, V., Reisancho, J., Tello, M. & Urbina, O.
# **Motores de Vulnerabilidad del Cambio del Paisaje**

## Objetivo del proyecto
Este estudio tuvo como objetivo determinar la vulnerabilidad de los paisajes del Ecuador en el 2015
## Metodología

<p style="text-align:justify;">Los índices de vulnerabilidad son desarrollados a partir de análisis multivariados de los componentes sociales, ambientales y económicos actuales. La vulnerabilidad como indicador se compone de tres elementos principales como las <u>magnitudes de exposición</u> (estrés del sistema), <u>sensibilidad</u> (grado de estrés en el sistema) y la <u>adaptabilidad</u> (capacidad de respuesta ante el estrés).</p>

1. Se identificó las variables ambientales, biofísicas, sociales y económicas para definir el índice, desde varios sitios de meta data, para la clasificación en variables de magnitud de exposición, capacidad de adaptación,y sensibilidad.

| Exposición                                  | Capacidad de adaptación      | Sensibilidad              |
| ------------------------------------------- | ---------------------------- | ------------------------- |
| Indicador de complejidad estructural        | Distancia a áreas protegidas | Pendiente                 |
| Indicador del número de personas estudiando |                              | Distancia a ríos          |
| Indicador de la disponibilidad de empleo    |                              | Distancia a zonas urbanas |
| Distancia a regímenes de inundación         |                              | Distancia a vías          |



La descripción y fuente de las variables pueden ser encontradas en [Metadata][].

2. Utilizando el software Quantum GIS se realizó la reclasificación con la herramienta *reclass* de las diferentes capas raster escogidas. Las variables socioeconómicas fueron rasterizadas mediante la herramienta *Empirical Bayesian Kriging* en ArcGis y para la resolución deseada de los archivos ráster se utilizó la herramienta *aggregate*, luego se realizó en ArcGis una extracción por puntos aleatorios de los valores obtenidos de las variables de interés y la base de datos creada fue exportada a R Studio.


3. Se realizó el siguiente código en R Studio para obtener las variables más
   influyentes.

Normalización de variables (Ejemplo):

```R
min <- min(data$pendiente, na.rm = TRUE) 
max<- max(data$pendiente, na.rm = TRUE)
data$pendiente<-(data$pendiente-max)/(min-max)*100
```

GLM:

```R
gl <- glm(bnb~salud+educacion+empleo+infraestructura+dist_inund+dist_rios+dist_snap+
dist_urban+dist_vias+pendiente,family = "binomial",datos)
`
```

4. Teniendo en cuenta las variables más influyentes se calculó el índice de la siguiente forma:

```R
data$adaptative <- data$dist_snap
data$sensitivity <-(data$dist_inund+data$salud+data$educacion+data$empleo+data$infraestructura)/5
data$exposure <-
(data$pendiente+data$dist_rios+data$dist_vias+data$dist_urban)/4
data$vulnerability <- (data$exposure+data$sensitivity-data$adaptative)/3
```

5. Luego, se visualizó el mismo en los paisajes en Ecuador mediante el uso de
   funciones de QGIS.

## Resultados
Como resultado del modelo lineal generalizado se obtuvo que el empleo y distancia a áreas de inundación, a poblados urbanos, y a vías son las más influyentes en la vulnerabilidad de los paisajes de Ecuador.

Por lo que se obtuvo el siguiente mapa de vulnerabilidad de Ecuador en 2015.

![](https://github.com/OmayraU/Vulnerabilidad-del-Paisaje/blob/master/Vulnerability_map.png)

En el mapa preliminar obtenido por los resultados del índice de vulnerabilidad se puede observar que las zonas de color amarillo, naranja y rojo (rango entre 58.7 a 100)  representa un alto índice de vulnerabilidad de los paisajes donde se encuentran ubicados asentamientos humanos densamente poblados. En contraste, se observa regiones con índices bajo a medio bajo (18.7-38.7) dispersas en la zona interandina en su mayoría. Esto último está altamente relacionado a la dificultad de acceso de carreteras y servicios básicos debido a su orografía compleja. 

------



[Metadata]: https://github.com/OmayraU/Vulnerabilidad-del-Paisaje/blob/master/Metadatos%20descripci%C3%B3n.xlsx