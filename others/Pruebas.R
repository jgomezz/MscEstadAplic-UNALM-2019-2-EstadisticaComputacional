# Games-Howell test

#install.packages("userfriendlyscience")

library(userfriendlyscience)

# Read data
data_df <- read.csv("others/data.csv",sep=";")

# Store the data in an auxiliary variable for editing
data_df_new <- data_df

# Substitution of the missing values by the mean of the variable
data_df_new$Age <- na.aggregate(as.numeric(data_df$Age), by="Age", FUN = mean)

# Games-Howell test
oneway(y=data_df_new$Age, x = data_df$Tasks, posthoc="games-howell", 
       means=T, fullDescribe=T, levene=T,plot=T, digits=2,pvalueDigits=3, 
       conf.level=0.95)


# Reading the package userfriendlyscience, needed to apply Games-Howell test
library(userfriendlyscience)

# Read data
data_df <- read.csv("others/data.csv",sep=";")

### Games-Howell test for multiple comparisons
# Substitution of the missing values by the mean of the variable
data_df_new$Age <- na.aggregate(as.numeric(data_df$Age), by="Age",FUN = mean)


# Games-Howell test
oneway(y=data_df_new$Age, x = data_df$Tasks, posthoc="games-howell",
       means=T, fullDescribe=T, levene=T,
       plot=T, digits=4, pvalueDigits=4, conf.level=.95)


# Mann-Whitney test
wilcox.test(na.aggregate(data_df[data_df$Gender == "male","Publications"]), 
            y = na.aggregate(data_df[data_df$Gender == "female", "Publications"]))


### Kruskal-Wallis test
kruskal.test(list(data_df[data_df$Tasks=="PhD_Student","Publications"],
                  data_df[data_df$Tasks=="Postdoctoral_research","Publications"],
                  data_df[data_df$Tasks=="Phd_Supervisor","Publications"]))
