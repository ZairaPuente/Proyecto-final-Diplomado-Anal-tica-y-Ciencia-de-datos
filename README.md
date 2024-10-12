# Proyecto Diplomado Analítica y Ciencia de Datos

## Selección y Justificación de la Base de Datos

Se eligió la base de datos de **Incidencia Delictiva Víctimas del Fuero Común** del SESNSP (Secretariado Ejecutivo del Sistema Nacional de Seguridad Pública) para analizar la situación de inseguridad en México, específicamente en el estado de Colima. Esta base de datos es actualizada regularmente y ofrece una visión integral de la incidencia delictiva a nivel federal, permitiendo el análisis de tendencias en delitos y sus víctimas.

## Preparación y Limpieza de los Datos

Se trabajó con un total de **73,600 registros** y **21 variables** que incluyen información clave como el **Año**, **Entidad**, **Tipo de Delito**, **Sexo**, **Rango de Edad**, y los registros mensuales de víctimas.

Durante el proceso de limpieza:
- Se renombraron las variables para mantener consistencia en R.
- Se eliminaron registros con valores nulos o incompletos.
- Se seleccionaron únicamente los años de 2013 a 2023.

Las variables clave en los datos son:
- **Año:** Año de registro de las averiguaciones previas y/o carpetas de investigación.
- **Tipo_de_delito:** Clasificación de los tipos de delitos.
- **Sexo:** Sexo de las víctimas (Hombre, Mujer, No identificado).
- **Rango_de_edad:** Clasificación de las edades de las víctimas.
- **Enero a Diciembre:** Número de víctimas reportadas por mes.

## Análisis Exploratorio de Datos (EDA)

Se realizaron varios análisis para responder a preguntas clave, como:

- **¿Existen patrones estacionales en el número de víctimas?**
- **¿Qué impacto tuvo la pandemia de COVID-19 en el número de víctimas?**
- **¿Cómo se distribuye el sexo de las víctimas en diferentes tipos de delitos?**
- **¿Qué grupos de edad son más vulnerables a ciertos delitos?**

Este análisis se centró en identificar patrones temporales, diferencias entre categorías y posibles anomalías.

## Análisis de Patrones Estacionales

Se observaron los siguientes patrones:

1. El año 2015 tiene una menor representación en los datos debido a problemas en la denuncia de delitos.
2. Los meses de **enero**, **marzo** y **diciembre** son los que presentan una mayor incidencia delictiva.
3. Durante la pandemia de COVID-19 (2020-2021), se observó una caída en la incidencia delictiva en los meses de abril y mayo, pero a partir de la segunda mitad de 2021 los incidentes volvieron a aumentar.

## Distribución del Sexo de las Víctimas

La mayoría de las víctimas de **homicidios** y **lesiones** son predominantemente hombres, mientras que los **feminicidios** afectan exclusivamente a mujeres. En delitos menores como **corrupción de menores** y **extorsión**, la distribución entre hombres y mujeres es más equitativa.

## Vulnerabilidad por Grupo de Edad

Los **adultos (18 años o más)** son el grupo más afectado en delitos como **homicidios** y **lesiones**, aunque los **menores de edad (0-17 años)** también son víctimas significativas en algunos tipos de delitos como los **delitos contra la libertad personal**.

## Impacto de la Pandemia de COVID-19

La pandemia tuvo un impacto en la dinámica delictiva, mostrando un aumento en los casos reportados en meses específicos, como marzo y diciembre de 2020 y 2021. Estos cambios pueden estar asociados con las restricciones de movilidad y la alteración de la vida social durante la pandemia.

## Visualizaciones

A lo largo del proyecto se incluyen diversas visualizaciones, tales como:
- Gráficos de líneas para el promedio de víctimas por año.
- Gráficos de barras para el total de víctimas por tipo de delito.
- Gráficos de distribución por sexo y edad de las víctimas.

## Conclusiones

1. Los **homicidios** y **lesiones** son los delitos más frecuentes, afectando predominantemente a hombres adultos.
2. Los **patrones estacionales** sugieren una mayor incidencia delictiva en los meses de enero, marzo y diciembre.
3. La **pandemia de COVID-19** tuvo un impacto significativo en la dinámica delictiva, con una caída temporal en los casos, seguida de un aumento en 2021.
4. Es crucial que se enfoquen medidas específicas de prevención en los meses y grupos más vulnerables.

## Uso de las Herramientas

El análisis fue realizado utilizando las siguientes herramientas:
- **R** para la limpieza y manipulación de los datos.
- **ggplot2** para las visualizaciones gráficas.
- **Power BI** para las visualizaciones adicionales interactivas.
