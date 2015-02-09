/* 1. Which destination in the flights database is the furthest distance away?  */

SELECT  dest, MAX(distance)
FROM flights
GROUP BY  dest
ORDER BY MAX(distance) DESC
limit 1

-- it looks the furthest destination is Honolulu */
-- Or we can also query the flights table using the distance and air time. However, airtime can be misleading as */
-- flights can be delayed in the air sometimes while due to busy runways */

SELECT  dest, MAX(air_time), max(distance)
FROM flights
GROUP BY  dest
ORDER BY MAX(distance) DESC
limit 1



/* 2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have
the most number of seats? */

SELECT DISTINCT engines
FROM planes
ORDER BY engines DESC


SELECT  DISTINCT  engines AS "Engine", 
        manufacturer AS "Manufacturer", 
        MAX(seats) AS "Maximum Seats"
FROM planes
WHERE   engines IN ( SELECT DISTINCT engines FROM planes)
AND seats IN (SELECT MAX(seats) FROM planes GROUP BY engines)
GROUP BY  manufacturer, engines
ORDER BY MAX(seats) DESC

-- The above finds the maximum seats for each manufacturer given the number of engines..
-- The below statement finds the maximum seats based on the number of engines then it associates the manufacturer with that max seats.
-- Hence, the below statement produces four rows sinc ewe have four different engines. then find finds the maximum seats.. */

(SELECT  DISTINCT manufacturer, engines, max(seats) 
FROM planes 
WHERE engines =1 
GROUP BY    manufacturer, engines
ORDER BY   max(seats) DESC
LIMIT 1
)
UNION

(SELECT  DISTINCT manufacturer, engines, max(seats) 
FROM planes 
WHERE engines =2 
GROUP BY    manufacturer, engines
ORDER BY   max(seats) DESC
LIMIT 1
)
UNION
(SELECT  DISTINCT manufacturer, engines, max(seats) 
FROM planes 
WHERE engines =3 
GROUP BY    manufacturer, engines
ORDER BY   max(seats) DESC
LIMIT 1
)
UNION

(SELECT  DISTINCT manufacturer, engines, max(seats) 
FROM planes 
WHERE engines =4 
GROUP BY    manufacturer, engines
ORDER BY   max(seats) DESC
LIMIT 1
)


/* 3. What weather conditions are associated with New York City departure delays?  */
-- There is correlation between the low visibility and higher departure delays and 
-- conversely the higher visibly the lower departure delays  

SELECT  f.origin, w.visib, avg(f.dep_delay) AS "Average Delay"
FROM flights f JOIN weather w USING (origin, year, month, day) 
WHERE f.origin IN ('JFK', 'EWR', 'LGA')
GROUP BY f.origin, w.visib
ORDER BY  avg(f.dep_delay), f.origin 

-- The above statement can be written as below  
SELECT  f.origin, w.visib, avg(f.dep_delay) AS "Average Delay"
FROM flights f JOIN weather w ON (f.origin=w.origin 
				AND w.year= f.year 
				AND w.month= f.month 
				AND  w.day = f.day
				) 
WHERE f.origin IN ('JFK', 'EWR', 'LGA')
GROUP BY f.origin, w.visib
ORDER BY  avg(f.dep_delay), f.origin 


/* ====== */
/* 4. Are older planes more likely to be delayed?  */ 


-- From the below statement's results, there is no direct correlation between older planes and delayed. 
-- The delays are likely to happen because due weather conditions as was seen in the previous question.   
-- Perhaps if we have airplanes’ maintenance schedules and frequencies may help indicate if the age planes contributes in delays…   
  

SELECT round((avg(dep_delay)/60), 2) AS "Average Departure Delay in hours" , 
       engines AS " Number of Engines", 
       manufacturer, p.year AS "Year Built"
FROM planes p LEFT JOIN flights f USING (tailnum)
GROUP BY p.year, manufacturer, engines
ORDER BY avg(dep_delay) DESC




/* 5. Ask (and if possible answer) a question that also requires joining information from two or more tables in the
flights database, and/or assumes that additional information can be collected in advance of answering your
question. */ 

-- I want to find out when the maximum number of flights from the airports in NYC (EWR, LGA, JFK) occors. it turns out to be that it corrolates 
-- with schools breaks mailnly summer and spring breaks. 
-- Also we found that the least number of flights happens in October time frame.  
-- Also, we notice that the level of temp in NYC does not neccessary translate to low or hih number of flights out NYC.

SELECT f.origin, 
       count(flight), 
       temp, month , CASE WHEN MONTH=1 THEN 'JANUARY' 
                          WHEN MONTH=2 THEN 'FEBRUARY'
                          WHEN MONTH=3 THEN 'MARCH'
                          WHEN MONTH=4 THEN 'APRIL'
                          WHEN MONTH=5 THEN 'MAY'
                          WHEN MONTH=6 THEN 'JUNE'
                          WHEN MONTH=7 THEN 'JULY'
                          WHEN MONTH=8 THEN 'AUGUST'
                          WHEN MONTH=9 THEN 'SEPTEMBER'
                          WHEN MONTH=10 THEN 'OCTOBER'
                          WHEN MONTH=11 THEN 'NOVEMBER'
                          WHEN MONTH=12 THEN 'DECEMBER'
                     END  AS Month
FROM flights f JOIN weather USING ( year, month, day)
WHERE f.origin IN ('JFK', 'EWR', 'LGA')
GROUP BY  f.origin, temp, month
ORDER BY count(flight) DESC








