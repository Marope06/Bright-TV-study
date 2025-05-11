SELECT V.userid,name,surname,gender,race,age,province,channel2,date,time,duration_2,

CASE
 WHEN age=0 THEN 'unclassified'
 WHEN age BETWEEN 1 AND 13 THEN 'Child'
 WHEN age BETWEEN 14 AND 19 THEN 'Teenager'
 WHEN age BETWEEN 20 AND 36 THEN 'Young_Adult'
 WHEN age BETWEEN 37 AND 59 THEN 'Adult'
 WHEN age BETWEEN 60 AND 70 THEN 'Pensioner'
 WHEN age BETWEEN 71 AND 100 THEN 'Senior pensioner'
 ELSE 'Outlier'
 END AS Age_classification ,
 
 CASE
 
  WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 
 'Morning' 
 WHEN time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
 WHEN time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
 ELSE 'Night'

 END AS Time_bucket,

CASE
 WHEN DURATION_2 IS NULL THEN 'Non-viewer'
 WHEN DURATION_2 ='00:00:00'THEN 'Non-viewer'
 WHEN duration_2 BETWEEN '00:00:01' AND '00:05:59' THEN 'Visitor'
 WHEN duration_2 BETWEEN '00:06:00' AND '00:29:59' THEN 'Casual_viewer'
 WHEN duration_2 BETWEEN '00:30:00' AND '00:01:59' THEN 'Frequent_viewer'
 WHEN duration_2 BETWEEN '02:00:00' AND '05:00:59' THEN 'Everyday_viewer'
 ELSE 'resident'

 END AS Watch_time,
 
extract(hour from duration_2)*3600+ 
extract(minute from duration_2)*60+
extract(second from duration_2) AS New_duration,

FROM userprofile AS U

FULL OUTER JOIN viewership AS V
ON U.USERID=V.USERID
ORDER BY userid;





--SELECT avg(age), MAX(age) FROM userprofile;

--MAX duration 11:29:28
--Min duration 00:00:00


SELECT count(userid) U.userid
FROM userprofile AS U

FULL OUTER JOIN viewership AS V
ON U.USERID=V.USERID
ORDER BY userid;

SELECT duration_2, extract(hour from duration_2)*3600+ 
       extract(minute from duration_2)*60+
       extract(second from duration_2) AS New_duration,

FROM viewership;

-- Group BY Channel.

SELECT count(userid),channel2
FROM ( SELECT V.userid,channel2
FROM VIEWERSHIP AS V
FULL OUTER JOIN userprofile AS U
ON U.userid=V.userid)
GROUP BY channel2
ORDER BY count(userid) desc;

----------

SELECT count(userid),channel2
FROM ( SELECT V.userid,channel2
FROM VIEWERSHIP AS V
FULL OUTER JOIN userprofile AS U
ON U.userid=V.userid)
GROUP BY channel2
ORDER BY count(userid) desc;

