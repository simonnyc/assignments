
#      Edinburgh		    Glasgow	
#     16-24	  25+	   16-24	  25+
# YES	80100	143000	99400	  150400
# NO	53900	214800	43000	  307000
#

library(tidyr)
library(dplyr)

# 1. Write down 3 questions that you might want to answer based on this data.

# 1- How any people participated in the survey in all cities across all ages?
# 2- How many people said yes to Cullen skink soup? 
# 3- For people 25 and older, how many said No?


# 2. Create an R data frame with 2 observations to store this data in its current "messy" state. Use
# whatever method you want to re-create and/or load the data.


Edinburgh_16_24 <- c( 80100, 35900)
Glasgow_16_24 <- c( 99400, 43000)
Edinburgh_25 <- c( 143000, 214800)
Glasgow_25 <- c( 150400, 207000)
vote<- c("Yes", "No")

df <- data.frame(Edinburgh_16_24, Glasgow_16_24, Edinburgh_25, Glasgow_25, vote )
df

# 3. Use the functionality in the tidyr package to convert the data frame to be "tidy data."

t1<- gather(df, key= city_age, value= vote, na.rm= TRUE)
t2<- data.frame(c(t1[2], t1[3]))
t2
str(t2)


# 4, Use the functionality in the dplyr package to answer the questions that you asked in step 1.

    ### 1- How any people participated in the survey in all cities across all ages?

summarise(t2, total= sum(vote))

    ### 2- How many people said yes to Cullen skink soup? 

t3<- data.frame(t1)
total_yes <- filter(t3, vote== "Yes")
total_yes
total_yes_summary<- summarize(total_yes, sum(vote.1))
total_yes_summary

    ### 3- For people 25 and older, how many said No?

total25_No<- filter(t3, grepl('25', city_age), vote=='No')
total25_No
total25_No_summary<- summarize(total25_No, sum(vote.1))
total25_No_summary

##  5. Having gone through the process, would you ask different questions and/or change the way that
##  you structured your data frame?

# I would perhaps add more questions to the first three since exploring tidyr/dplry packages.. Perhaps one more question 
# would be, are people older than 25 years old prefer not to drink soup regardless if it is smoked haddock based such as Cullen skink #or seafood based such Partan Bree?
# Also, it will be interesting to know the gender split among those who said yes or no.  


