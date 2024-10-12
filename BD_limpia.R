# Instalación de paquetes
install.packages("tidyverse")
install.packages("openxlsx")


# Librerías
library(tidyverse)
library(openxlsx)

# Se manda llamar el archivo de Excel, para crear el df original
IDVFC_NM <- read_xlsx("Estatal-Victimas-2015-2024_ago2024.xlsx")

# Resumen estadístico
summary(IDVFC_NM)

# Revisar encabezados 
head(IDVFC_NM)

# Renombrar algunas columnas
IDVFC_NM <- rename(IDVFC_NM,
                   Bien_juridico_afectado = "Bien jurídico afectado",
                   Tipo_de_delito = "Tipo de delito",
                   Subtipo_de_delito = "Subtipo de delito",
                   Rango_de_edad = "Rango de edad")

# Revisar encabezados con nuevos nombres
head(IDVFC_NM)

# Crear la columna 'Total' que suma los incidentes en todos los meses del año para cada fila,
# filtrando los registros donde el total de incidentes es cero, y luego agrupar los datos por
# año, tipo de delito, sexo, y rango de edad en la entidad de Colima.
IDVFC <- IDVFC_NM %>%
  mutate(Total = rowSums(across(c(Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre)))) %>%
  select(Año, Entidad, Tipo_de_delito, Sexo, Rango_de_edad, 
         Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre, 
         Total) %>%
  filter(Total != 0) %>%
  filter(Entidad == "Colima") %>%
  group_by(Año, Tipo_de_delito, Sexo, Rango_de_edad) %>%
  summarise(
    enero = sum(Enero),
    febrero = sum(Febrero),
    marzo = sum(Marzo),
    abril = sum(Abril),
    mayo = sum(Mayo),
    junio = sum(Junio),
    julio = sum(Julio),
    agosto = sum(Agosto),
    septiembre = sum(Septiembre),
    octubre = sum(Octubre),
    noviembre = sum(Noviembre),
    diciembre = sum(Diciembre),
    Total_victimas_año = sum(Total),
    .groups = "drop"
  )

# Revisar encabezados del dataframe
head(IDVFC)

# Exportar dataframe a Excel para utilizarlo para el visualizador de datos
write.xlsx(IDVFC, file = "IDVFC.xlsx")


# Agrupar por Año y calcular estadísticas descriptivas
estadisticas_por_ano <- IDVFC %>%
  group_by(Año) %>%
  summarise(
    promedio_total = mean(Total_victimas_año), # Promedio por año
    mediana_total = median(Total_victimas_año), # Mediana
    sd_total = sd(Total_victimas_año)           # Desviación estándar
  )

# imprime resultado
print(estadisticas_por_ano)


# Sumar los valores de los meses y encontrar el mes con mayor incidencia
Tabla_estacional <- IDVFC %>%
  group_by(Año) %>%  # Agrupar por año
  summarise(
    enero = sum(enero),
    febrero = sum(febrero),
    marzo = sum(marzo),
    abril = sum(abril),
    mayo = sum(mayo),
    junio = sum(junio),
    julio = sum(julio),
    agosto = sum(agosto),
    septiembre = sum(septiembre),
    octubre = sum(octubre),
    noviembre = sum(noviembre),
    diciembre = sum(diciembre)
  ) %>%
  pivot_longer(cols = enero:diciembre, names_to = "Mes", values_to = "Total_victimas") %>%
  arrange(Año)

# Ordenar categoricamente los meses del df Tabla_estacional
Tabla_estacional$Mes <- factor(Tabla_estacional$Mes, 
                               levels = c("enero", "febrero", "marzo", 
                                          "abril", "mayo", "junio", 
                                          "julio", "agosto", "septiembre", 
                                          "octubre", "noviembre", "diciembre"))

# Revisar el dataframe
print(Tabla_estacional)

# Dataframe para agrupar por año y sumar el total de victimas por año
data_victimas <- IDVFC %>%
  group_by(Año, Tipo_de_delito) %>%
  summarise(Total_victimas_año = sum(Total_victimas_año)) %>% 
  ungroup()

# Análisis de distribución de sexo en diferentes tipos de delitos
distribucion_sexo_delito <- IDVFC %>%
  group_by(Tipo_de_delito, Sexo) %>%
  summarise(Total_victimas = sum(Total_victimas_año), .groups = "drop")

# Análisis de vulnerabilidad por grupo de edad
vulnerabilidad_edad_delito <- IDVFC %>%
  group_by(Tipo_de_delito, Rango_de_edad) %>%
  summarise(Total_victimas = sum(Total_victimas_año), .groups = "drop")







### Visualizaciones de Datos ###

# Gráfico de líneas para el promedio de víctimas por año
estadisticas_por_ano %>% 
  ggplot(aes(x = Año, y = promedio_total)) +
  geom_line(color = "darkblue", size = 1.2) +  
  geom_point(size = 3, color = "red") + 
  geom_text(aes(label = round(promedio_total, 1)), vjust = -1, size = 3.5) +  # Añadir etiquetas a los puntos
  labs(title = "Promedio de Víctimas por Año",
       x = "Año",
       y = "Promedio de Víctimas") +
  theme_minimal() +  # Tema minimalista
  theme(plot.title = element_text(hjust = 0.5))  # Centra el título


# Gráfico de líneas para la mediana de víctimas por año
estadisticas_por_ano %>% 
  ggplot(aes(x = Año, y = mediana_total)) +
  geom_line(color = "blue", size = 1) +
  geom_point(size = 3, color = "red") +
  labs(title = "Mediana de Víctimas por Año",
       x = "Año",
       y = "Mediana de Víctimas")


# Gráfico de barras para la desviación estándar
estadisticas_por_ano %>% 
  ggplot(aes(x = factor(Año), y = sd_total)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Desviación Estándar de Víctimas por Año",
       x = "Año",
       y = "Desviación Estándar")


# Histograma de Total_victimas_año
data_victimas %>% 
  ggplot(aes(x = na.omit(Total_victimas_año))) + 
  geom_histogram(binwidth = 50, fill = "blue", color = "white", alpha = 0.7) +  
  geom_density(aes(y = ..count.. * 50), color = "red", linetype = "solid", size = 0.5) +  #curva de densidad
  labs(title = "Histograma de Total de Víctimas con Curva de Densidad",
       x = "Total de Víctimas",
       y = "Frecuencia") +
  theme_minimal()


# Gráfico de barras para el total de víctimas por tipo de delito durante los 9 años.
data_victimas %>%
  ggplot(aes(x = Tipo_de_delito, y = Total_victimas_año, fill = factor(Año))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Total de Víctimas por Tipo de Delito",
       x = "Tipo de Delito",
       y = "Total de Víctimas") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Gráfico de líneas para las tendencias estacionales
Tabla_estacional %>% 
  ggplot(aes(x = Mes, y = Total_victimas, color = factor(Año), group = Año)) +
  geom_line() +
  geom_point(size = 2) +
  labs(title = "Tendencias Estacionales del Total de Víctimas por Año",
       x = "Mes",
       y = "Total de Víctimas")


# Gráfico de barras de distribución por sexo y tipo de delito
distribucion_sexo_delito %>% 
  ggplot(aes(x = Tipo_de_delito, y = Total_victimas, fill = Sexo)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Distribución del Sexo de las Víctimas por Tipo de Delito",
       x = "Tipo de Delito",
       y = "Total de Víctimas") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Gráfico de barras apiladas por rango de edad y tipo de delito
vulnerabilidad_edad_delito %>%   
  ggplot(aes(x = Tipo_de_delito, y = Total_victimas, fill = Rango_de_edad)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Vulnerabilidad por Grupo de Edad y Tipo de Delito",
       x = "Tipo de Delito",
       y = "Total de Víctimas") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
