# Instalación y Carga de Paquetes -----------------------------------------



install.packages("tidyverse")
install.packages("palmerpenguins")
install.packages("ggthemes")
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

penguins
view(penguins)
ggplot(data = penguins)



# Pruebas y ejemplos del capítulo -----------------------------------------



ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")
labs(
  title = "Masa corporal y longitud de las aletas",
  subtitle = "Dimensiones para pingüinos Adelia, barbijo y papúa",
  x = "Longitud de la aleta (mm)", y = "Masa corporal (g)",
  color = "Especies", shape = "Especies"
)

+
scale_color_colorblind(ggplot)


ggplot(penguins, aes(x = species))+
         geom_bar()


ggplot(penguins, aes(x =flipper_length_mm))+
  geom_histogram(binwidth = 5)

ggplot(penguins, aes(x =flipper_length_mm))+
  geom_density()



# Ejercicios 1.4.3 --------------------------------------------------------------


## 1. ----------------------------------------------------------------------

ggplot(penguins,aes(y = species))+
  geom_bar()

# En lo que se diferencia esta gráfica a la anterior, con las especies en el eje x es que justamente, los datos ahora se encuentran en el eje y, haciendo que el gráfico sea horizontal en vez de vertical



## 2. ----------------------------------------------------------------------

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

# Estos gráficos se diferencian en que usan distintos parámetros. El primero usa el parámetro "color", que pinta el contorno de cada barra. Por otro lado, el segundo usa el parámetro "fill" que pinta la barra por completo.


## 3. ----------------------------------------------------------------------

ggplot(penguins, aes(x =flipper_length_mm))+
  geom_histogram(bi)

# El argumento "bins" en geom_histogram() especifica la cantidad de barras que tendrá el histograma.


## 4. ----------------------------------------------------------------------

ggplot(diamonds, aes(x = carat))+
  geom_histogram(binwidth = 0.5)




# Ejercicios 1.5.5 --------------------------------------------------------


## 1. ----------------------------------------------------------------------

glimpse(mpg)

?mpg

# La info se puede ver apretando la tecla "F1" al escribir 'mpg'. En este caso, con la función 'glimpse()' se pueden ver los tipos de datos: manufacturer, model, trans, drv, fl y class son variables categóricas. Por otro lado: displ, year, cyl, cty y hwy son varables numéricas.


## 2. ----------------------------------------------------------------------



ggplot(mpg, aes(x = hwy, y = displ, color = year, size = year))+
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, color = year, size = cty))+
  geom_point()


## 3. ----------------------------------------------------------------------



ggplot(mpg, aes(x = hwy, y = displ, linewidth = 2))+
  geom_point()

## Al agregar una tercera variable 'linewidth' no pasa nada porque el tipo de gráfico es de puntos.


## 4. ----------------------------------------------------------------------

ggplot(mpg, aes(x = hwy, y = displ , color = hwy, size = hwy))+
  geom_point()

# Si se mapea la misma variable a múltiples aesthetics, la información se vuelve redundante. Por ejemplo, si se aplica size y color a la variable 'hwy', estos seguirán el mismo patrón, que es el movimiento de la variable.


## 5. ----------------------------------------------------------------------

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, color = species))+
  geom_point()

# Este gráfico de dispersión revela los ratios de profundidad y longitud de los picos de las tres especies. Los pingüinos Adelie tienen los picos más cortos pero más densos. Los Gentoo más largos pero de menor densidad y por último, los Chinstrap siendo los más parejos en ambos valores, y ambos altos.


## 6. ----------------------------------------------------------------------

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Especies")

# El código produce dos leyendas separadas porque si bien hay dos aesthetics para la variable 'species' el nombre solo se le cambia al color, por lo tanto ggplot2 las separa en dos elementos distintos. Para que devuelva solo una, habría que asignarle a shape el mismo nombre que color, en este caso 'Especies'.

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Especies", shape = "Especies")


## 7. ----------------------------------------------------------------------

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

# En el primero se puede responder cuanta proporciión de la población total de la isla es de cada especie y en el segundo que proporción de la especie es de cada isla.



# Ejercicios 1.6.1 --------------------------------------------------------


## 1. ----------------------------------------------------------------------

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-grafica.png")

# Se guarda el segundo gráfico ya que es el más reciente creado.


## 2. ----------------------------------------------------------------------

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-grafica.pdf")

# Para cambiar el archivo a pdf, se cambia el formato dentro del ggsave(). Para ver los formatos de archivo que acepta ggplot2 puedo ejecutar lo siguiente en la consola '?ggsave()'.

