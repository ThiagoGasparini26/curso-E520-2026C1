
# Carga de paquetes -------------------------------------------------------


library(tidyverse)
library(nycflights13)



# Pruebas en base a la lectura --------------------------------------------


glimpse(flights)

vuelos_abril <- flights|>  
  filter(month == 4)

glimpse(vuelos_abril)

vuelos_abril |>
  filter(dep_time>1800 | dep_time<200) |>
  arrange(-desc(dep_time))

          

# Ejercicios 3.2.5 --------------------------------------------------------
flights |> 
  distinct(carrier)

#1.

flights |>
  filter(arr_delay >= 120) 

flights |>
  filter(dest == 'HOU'| dest == 'IAH', carrier == 'UA' | carrier == 'AA' |
           carrier == 'DL')

flights|>
  filter(month %in% c(7,8,9))

flights|>
  filter(arr_delay > 120, dep_delay == 0)

flights|>
  filter(arr_delay > 60, dep_delay - arr_delay > 30)


#2

flights |>
  arrange(desc(dep_delay))

flights |>
  arrange(time_hour)

#3

flights |>
  arrange(-desc(arr_time - dep_time))


#4

flights |>
  distinct(year == 2013, month, day)

#Como se pudede ver, haciendo el distinct para el año 2013, hay 365 filas, por
#lo que hubo vuelos todos los días de ese año.


#5

#Los que menos distancia recorrieron:
menos_distancia <- flights|>
  arrange(distance)

#El que menos distancia recorrió  fue uno sin identificar, que solo hizo 17km.
#De los identificados fue el N13989, que hizo 80km.
view(flights)

mas_distancia <- flights|>
  arrange(desc(distance))

glimpse(menos_distancia)
glimpse(mas_distancia)


#El que más recorrió fue el vuelo N380HA, que hizo 4983km.


#6

#En términos de resultado, no importa el orden de filter y arrange, pero en
#cuanto a rendimiento sí, conviene usar filter primero ya que reduce la
#cantidad de filas que debe ordenar arrange.


# Ejercicios 3.3.5 --------------------------------------------------------



flights |>
  select(dep_time,sched_dep_time,dep_delay)

#2

flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |>
  select(starts_with("dep"),starts_with("arr"))


#3

flights |>
  select(dep_time, dep_time, dep_time)

#Si se pone más de una vez una misma variable en select, dplyr mostrará la 
#primera e ignorará el resto.

#4

#La función any_of() busca coincidencias dentro de un conjunto dado, si las 
#encuentra las selecciona, sino las ignora. Esto permite buscar elementos de
#interés en dataframes de muchas columnas

variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights |>
  select(any_of(variables))

#5

flights |> select(contains("TIME"))

flights |> select(contains("TIME", ignore.case = FALSE))
#No diferencia entre mayúsculas y minúsculas, para que sí lo haga hay que
#cambiar el argumento ignore.case a FALSE,


#6 

flights |>
  rename(air_time_min = air_time) |>
  relocate(air_time_min, .before = year)

#7

flights |> 
  select(tailnum) |> 
  arrange(arr_delay)

#El código falla ya que en el select se deja solo la columna tailnum, de esta
#manera, se borra la columna arr_delay, por lo que el arrange no la encuentra.
#Para que sí funcione, el arrange debería ir primero.




# Ejercicios 3.5.7 --------------------------------------------------------

#1

flights |> group_by(carrier) |> 
  summarize(
    avg_delay = mean(arr_delay, na.rm = TRUE)) |>
    arrange(desc(avg_delay))
    
#La aerolínea con mayor promedio de retrasos es Frontier (F9) con 21.9 minutos
#promedio de retraso.

flights |> group_by(carrier, dest) |> summarize(n())
  
chequeo <- flights |> 
  filter(carrier == "9E") |>
  group_by(dest) |>
  summarise(average_delay = mean(arr_delay, na.rm = TRUE), n = n())

view(chequeo)

# Se puede observar que el promedio de delay en los vuelos varía bastante
# dependiendo cada destino, y si se miran los destinos en los que más vuelos
# realiza la aerolínea se puede ver que por lo general, los tiempos de delay
# son menores al promedio de esta, por lo tanto estimo que es un problema más
# de los aeropuertos.


#2

flights |> 
  group_by(dest) |> 
  slice_max(dep_delay, n = 1) |>
  relocate(dep_delay, dest, .before = 1 )


#3

dato <- flights |>
  group_by(hour)|>
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE))|>
  select(avg_delay,hour)

ggplot(data = dato,
       aes(x = hour, y = avg_delay))+
      geom_point()+
      labs(
        title = 'promedio de retraso según la hora',
        x = 'hora del día',
        y = 'promedio de retraso'
      )
ggsave(filename = "grafico_promedio_horas.png")
  


#4  


flights |>
  slice_min(arr_delay, n = -100)

#no provoca nada.


#5

#Count, en cuanto a combinaciones de verbos es un equivalente a hacer

#flights |> 
# group_by()|>
# summarise(n = n())

#Ya que, justamente, cuenta en base a un grupo que nosotros mismos le damos.

flights |>
  count(carrier)

flights |>
  count(carrier, sort = TRUE)

#Count los ordena alfabéticamente de forma automática. El argumento sort es 
#equivalente a hacer un arrange(desc(n)), porque ordena los datos de mayor a 
#menor en base a n.


#6

#A

df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

df |>
  group_by(y)

#La salida será igual, solo que con un dato de los grupos arriba, ya que
#group_by() no modifica los datos.

#B

df |>
  arrange(y)

#El tibble saldrá ordenado alfabéticamente en base a la variable y.


#C

df |>
  group_by(y) |>
  summarize(mean_x = mean(x))

#Saldrá la media de x para los dos grupos de y (a,b)


#D

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

#Hará las media de x para los grupos que se formen en base a los valores de z e y.
#La diferencia con el anterior, son los grupos que se forman. Mientras que en
#el otro los grupos eran los valores que tomaba y, ahora son las combinaciones
#que toman z e y.


#E

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")

#Va a devolver lo mismo que el inciso anterior salvo el dato  del grupo.


#F

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))

#El primero devuelve una tabla con el dato medio de x para un grupo por fila.
#El segundo crea la columna de media pero no reduce los datos de los grupos
#a una sola fila
