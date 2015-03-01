require(RPostgreSQL)
library(RPostgreSQL)
require(DBI)
library(DBI)
require(dplyr)
library(dplyr)

con <- dbConnect(PostgreSQL(), user= "postgres", password="owner", dbname="flights")
dbListTables(con)



#  The below SQL statement include all the logic needed to get the below columns. The result set is saved in the flights_data data frame 
#  . Airport of origin
#  . Carrier
#  . Approximate temperature at scheduled time of departure
#  . Departure Delay
#  . Arrival Delay
# . Air Time in Minutes
# . Seating Capacity of Airplane


  
flights_data<- data.frame(dbGetQuery( con, "SELECT   
                                      f.origin  , 
                                     f.carrier,  
                                     f.month, 
                                     f.day,
                                     f.dest, 
                                     w.temp, 
                                     p.seats,  
                                     -- p.tailnum,
                                     f.dep_delay, 
                                     f.arr_delay, 
                                     f.air_time
                                     FROM flights f JOIN weather w USING (origin, year, month, day, hour)
                                     JOIN planes p USING (tailnum)
                                     WHERE dest IN ('LAX')
                                     AND f.origin in ('JFK', 'LGA', 'EWR')
                                     AND f.year= 2013
                                     AND (f.month = 3 AND f.day = 1)
                                     OR  (f.month = 2 AND f.day >= 23)
                                     AND tailnum IS NOT NULL
                                     AND seats IS NOT NULL
                                     AND w.temp IS NOT NULL 
                                     ")
                        )
str(flights_data)
flights_data
      

        
