
moneda <- c("cara","sello")

sample(moneda, 3)

# Lanzar la moneda 100 veces
sample(moneda, 100, T)

# Contar la cantidad de veces
table(sample(moneda, 100, T))

# Cuando aumenta la cantidad de pruebas 
# se acerca al punto teorico
table(sample(moneda, 10000000, T))
