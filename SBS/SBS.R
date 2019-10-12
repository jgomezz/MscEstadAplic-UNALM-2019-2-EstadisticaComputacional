
# Objetivo: Descargar 1 archivo de la SBS ####
#configura tu directorio de trabajo, es decir, donde deseas trabajar
#setwd("~/DATA/")
setwd("./SBS/DATA/")


#copia la url de tu interés
fileUrl <-  "http://intranet2.sbs.gob.pe/estadistica/financiera/2018/Junio/B-2401-jn2018.XLS"
#usemos ?download.file para saber más de esta función
# probemos primero el caso por default
download.file(fileUrl,destfile="archivo malo.XLS")
# probemos ahora con el wb
download.file(fileUrl,destfile="archivo bueno.XLS",mode="wb")
# ¿Por qué no funciona en el primer caso? A leer la documentación! Para archivos excel, 
# es necesario descargarlo en modo wb.
download.file(fileUrl,destfile="B-2401-jn2018.xls")

a<-readxl::read_xlsx("B-2401-jn2018.xls") # carguemos la data. Conoce más del paquete usando ?readxl
?readxl
View(a)

# 2 Objetivo: Limpiar la data ####
library(dplyr)
library(tidyr)

a<-readxl::read_xlsx("B-2401-jn2018.xls",skip = 5) #quitamos 5 espacios
View(a)
a<-a[complete.cases(a),] # solo elegimos filas completas (sin vacios)
View(a)
options(scipen=999) # para desactivar la nomenclatura cientifica de números
View(a)
names(a)
names(a)[10] #seleccionamos el valor 10
a<-a[,-10] # quitamos la columna 10 #usa dplyr. Como ejercicio recuerda usar "-" y select


names(a)<- c("variables", "BBVA","B. del Comercio", "BCP",
             "Pichincha","BIF","Scotiabank",
             "Citibank","Interbank","Mibanco",
             "GNB","Falabella","Santander","Ripley","Azteca","Cencosud","ICBC",
             "Total Empresas Financieras")
View(a)

exc = !names(a) %in% "variables" # una forma de elegir todo excepto una columna de un vector
exc # va a aplicar todo excepto a la primera columna
a[,exc] # ven? no aparece la columns "variables"
a[,exc] = sapply(a[,exc],as.character) # lo convierto a character. Es buena practica convertir siempre a character tus datos numéricos y luego pasarlos a numeric recién. ¿Por qué? Porque a veces por alguna razón te puede salir tipo factor o character y tener problemas y no darte cuenta hasta el proceso de modelacion 
a[,exc] = sapply(a[,exc],as.numeric) # lo convierto a numérico
a[,exc] = round(a[,exc],2) #redondeo a 2 cifras
View(a)

a %>% gather() %>% View()
a %>% gather(Bancos) %>% View()
a %>% gather(Bancos,valores) %>% View()
a %>% gather(Bancos,valores,-variables) %>% View()
b<-a %>% gather(Bancos,valores,-variables)
b %>% spread(variables,valores) %>% View()
data.final<-b %>% spread(variables,valores)
data.final$Periodo= as.Date("2018-08-31")
data.final
View(data.final)
# Objetivo: Guardar la data ####

saveRDS(data.final,file="midatalimpia.RDS")
