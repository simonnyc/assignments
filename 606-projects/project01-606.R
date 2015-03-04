
sink("c:/CUNY/code.pdf")

library(ggplot2) 


pdf("c:/CUNY/myplot.pdf")

sales_data<- read.csv(file="c:/cuny/sales.csv", head=TRUE)

ham_demand <- sales_data$demand.ham
turkey_demand <- sales_data$demand.turkey
veggie_demand <- sales_data$demand.veggie


# create factors with value labels 
sales_data$demand.ham <- factor(sales_data$demand.ham) 
sales_data$demand.turkey <- factor(sales_data$demand.turkey) 
sales_data$demand.veggie <- factor(sales_data$demand.veggie)

# Kernel density plots for the demand
# Pretty much all the demand data exhibit normal distribution 

qplot(demand.ham, data=sales_data, geom="density", fill=sales_data$demand.ham, alpha=I(.5), 
      main="Distribution of the Ham Deman", xlab="daily Ham Demand", 
      ylab="Density")


qplot(demand.turkey, data=sales_data, geom="density", fill=sales_data$demand.turkey, alpha=I(.5), 
      main="Distribution of the Turkey Deman", xlab="daily Turkey Demand", 
      ylab="Density")

qplot(demand.veggie, data=sales_data, geom="density", fill=sales_data$demand.veggie, alpha=I(.5), 
      main="Distribution of the Veggie Deman", xlab="daily Veggie Demand", 
      ylab="Density")


hist(ham_demand)
hist(turkey_demand)
hist(veggie_demand)




summary(sales_data)


mean(ham_demand)
mean(turkey_demand)
mean(veggie_demand)

sd(ham_demand)
sd(turkey_demand)
sd(veggie_demand)


datah<- sales_data$demand.ham
# Monday data 

i=0
y=[0]
y<- seq(1, length(sales_data$demand.ham), by=5)
datah_Monday<-0
for (i in 1:26) {
  datah_Monday[i]<-  datah[y[i]]
  print(datah[y[i]])
}



# Tuesday demand data 
i=0
y=[0]
y<- seq(2, length(sales_data$demand.ham), by=5)
datah_Tuesday<-0
for (i in 1:26) {
  datah_Tuesday[i]<-  datah[y[i]]
  print(datah[y[i]])
}

# Wed day demand data 
i=0
y=[0]
y<- seq(3, length(sales_data$demand.ham), by=5)
datah_Wed <-0
for (i in 1:26) {
  datah_Wed[i]<-  datah[y[i]]
  print(datah[y[i]])
}


# Thurs day demand data 
i=0
y=[0]
y<- seq(4, length(sales_data$demand.ham), by=5)
datah_Thurs<-0
for (i in 1:26) {
  datah_Thurs[i]<-  datah[y[i]]
  print(datah[y[i]])
}


# Friday demand data 
i=0
y=[0]
y<- seq(5, length(sales_data$demand.ham), by=5)
datah_Friday<-0
for (i in 1:26) {
  datah_Friday[i]<-  datah[y[i]]
  print(datah[y[i]])
}

hist(datah_Monday)
hist(datah_Tuesday)
hist(datah_Wed)
hist(datah_Thurs)
hist(datah_Friday)

dev.off()

#

