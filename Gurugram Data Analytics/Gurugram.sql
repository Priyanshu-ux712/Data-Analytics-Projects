SELECT * FROM gurugram.gurugram;

create view top_10_date as
select date(day) as Day, 
time, 
`PM10 (Âµg/mÂ³)` as PM10
from gurugram.gurugram 
order by `PM10 (Âµg/mÂ³)` desc limit 10;


create view low_10_date as
select date(day) as Day, 
time, 
`PM10 (Âµg/mÂ³)` as PM10
from gurugram.gurugram 
order by `PM10 (Âµg/mÂ³)` asc limit 10;


create view high_months as 
select month(day) as Month, 
time, 
round(avg(`PM10 (Âµg/mÂ³)`)) as Avg_PM10 
from gurugram.gurugram 
group by month(day),time 
order by Avg_PM10 desc limit 10;


create view low_months as
select month(day) as Month, 
time, 
round(avg(`PM10 (Âµg/mÂ³)`)) as Avg_PM10 
from gurugram.gurugram 
group by month(day),time 
order by Avg_PM10 asc limit 10;


create view high_NO2 as
select
month(day) as Month,
time,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2
from gurugram.gurugram 
group by month(day),time 
order by Avg_NO2 desc limit 10;

create view low_NO2 as
select 
month(day) as Month,
time, 
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2
from gurugram.gurugram 
group by month(day),time 
order by Avg_NO2 asc limit 10;

create view high_ozone as
select month(day) as Month, 
time, 
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE
from gurugram.gurugram group by month(day),time 
order by Avg_OZONE desc limit 10;

create view low_ozone as
select month(day) as Month, 
time, 
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE
from gurugram.gurugram group by month(day),time 
order by Avg_OZONE asc limit 10;

create view high_benzene as
select month(day) as Month, 
time, 
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
from gurugram.gurugram group by month(day),time 
order by Avg_Benzene desc limit 10;

create view low_benzene as
select month(day) as Month, 
time, 
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
from gurugram.gurugram group by month(day),time 
order by Avg_Benzene asc limit 10;


create view season_avg as
SELECT
  CASE
    WHEN `rain (mm)` > 0 THEN 'Rainy'
    ELSE 'Dry'
  END AS day_type,
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
FROM gurugram.gurugram
GROUP BY day_type;

create view season_min as
SELECT
  CASE
    WHEN `rain (mm)` > 0 THEN 'Rainy'
    ELSE 'Dry'
  END AS day_type,
round(min(`PM10 (Âµg/mÂ³)`),2) AS Min_PM10,
round(min(`NO2 (Âµg/mÂ³)`),2) as Min_NO2,
round(min(`Ozone (Âµg/mÂ³)`),2) as Min_OZONE,
round(min(`Benzene (Âµg/mÂ³)`),2) as Min_Benzene 
FROM gurugram.gurugram
GROUP BY day_type;

create view season_max as
SELECT
  CASE
    WHEN `rain (mm)` > 0 THEN 'Rainy'
    ELSE 'Dry'
  END AS day_type,
round(max(`PM10 (Âµg/mÂ³)`),2) AS Max_PM10,
round(max(`NO2 (Âµg/mÂ³)`),2) as Max_NO2,
round(max(`Ozone (Âµg/mÂ³)`),2) as Max_OZONE,
round(max(`Benzene (Âµg/mÂ³)`),2) as Max_Benzene 
FROM gurugram.gurugram
GROUP BY day_type;

create view wind_pollutant as
SELECT
  CASE
    WHEN `wind_speed_10m (km/h)` < 5 THEN 'Low wind'
    WHEN `wind_speed_10m (km/h)` < 15 THEN 'Medium wind'
    ELSE 'High wind'
  END AS wind_category,
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
FROM gurugram.gurugram
GROUP BY wind_category;


create view avg_4 as
select 
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
from gurugram.gurugram;

create view min_4 as
select 
round(min(`PM10 (Âµg/mÂ³)`),2) AS Min_PM10,
round(min(`NO2 (Âµg/mÂ³)`),2) as Min_NO2,
round(min(`Ozone (Âµg/mÂ³)`),2) as Min_OZONE,
round(min(`Benzene (Âµg/mÂ³)`),2) as Min_Benzene 
from gurugram.gurugram;

create view max_4 as
select 
round(max(`PM10 (Âµg/mÂ³)`),2) AS Max_PM10,
round(max(`NO2 (Âµg/mÂ³)`),2) as Max_NO2,
round(max(`Ozone (Âµg/mÂ³)`),2) as Max_OZONE,
round(max(`Benzene (Âµg/mÂ³)`),2) as Max_Benzene 
from gurugram.gurugram;


create view month_avg_4 as
select month(day) as Month,
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene 
from gurugram.gurugram group by month(day);

create view month_min_4 as
select month(day) as Month,
round(min(`PM10 (Âµg/mÂ³)`),2) AS Min_PM10,
round(min(`NO2 (Âµg/mÂ³)`),2) as Min_NO2,
round(min(`Ozone (Âµg/mÂ³)`),2) as Min_OZONE,
round(min(`Benzene (Âµg/mÂ³)`),2) as Min_Benzene 
from gurugram.gurugram group by month(day);

create view month_max_4 as
select month(day) as Month,
round(max(`PM10 (Âµg/mÂ³)`),2) AS Max_PM10,
round(max(`NO2 (Âµg/mÂ³)`),2) as Max_NO2,
round(max(`Ozone (Âµg/mÂ³)`),2) as Max_OZONE,
round(max(`Benzene (Âµg/mÂ³)`),2) as MAx_Benzene 
from gurugram.gurugram group by month(day);



create view all_avg as
select 
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene,
round(AVG(`NO (Âµg/mÂ³)`),2) as Avg_NO,
round(AVG(`NOx (ppb)`),2) as Avg_NOx,
round(AVG(`NH3 (Âµg/mÂ³)`),2) as Avg_NH3,
round(AVG(`SO2 (Âµg/mÂ³)`),2) as Avg_SO2,
round(AVG(`CO (mg/mÂ³)`),2) as Avg_CO,
round(AVG(`Toluene (Âµg/mÂ³)`),2) as Avg_Toluene,
round(AVG(`Xylene (Âµg/mÂ³)`),2) as Avg_Xylene,
round(AVG(`Eth-Benzene (Âµg/mÂ³)`),2) as `Avg_Eth-Benzene`,
round(AVG(`MP-Xylene (Âµg/mÂ³)`),2) as `Avg_MP-Xylene`,
round(AVG(`relative_humidity_2m (%)`),2) as `Avg_Relative_Humidity`,
round(AVG(`rain (mm)`),2) as `Avg_Rain`,
round(AVG(`surface_pressure (hPa)`),2) as `Avg_Surface_Pressure`,
round(AVG(`wind_speed_10m (km/h)`),2) as `Avg_Wind_speed_10M (Km/h)`,
round(AVG(`wind_direction_10m (Â°)`),2) as `Avg_Wind_Direction_10M`,
round(AVG(`wind_speed_100m (km/h)`),2) as `Avg_Wind_speed_100M (Km/h)`,
round(AVG(`wind_direction_100m (Â°)`),2) as `Avg_Wind_Direction_100M`
from gurugram.gurugram;


create view month_all_avg as
select Month(day) as Month,
round(AVG(`PM10 (Âµg/mÂ³)`),2) AS Avg_PM10,
round(AVG(`NO2 (Âµg/mÂ³)`),2) as Avg_NO2,
round(AVG(`Ozone (Âµg/mÂ³)`),2) as Avg_OZONE,
round(AVG(`Benzene (Âµg/mÂ³)`),2) as Avg_Benzene,
round(AVG(`NO (Âµg/mÂ³)`),2) as Avg_NO,
round(AVG(`NOx (ppb)`),2) as Avg_NOx,
round(AVG(`NH3 (Âµg/mÂ³)`),2) as Avg_NH3,
round(AVG(`SO2 (Âµg/mÂ³)`),2) as Avg_SO2,
round(AVG(`CO (mg/mÂ³)`),2) as Avg_CO,
round(AVG(`Toluene (Âµg/mÂ³)`),2) as Avg_Toluene,
round(AVG(`Xylene (Âµg/mÂ³)`),2) as Avg_Xylene,
round(AVG(`Eth-Benzene (Âµg/mÂ³)`),2) as `Avg_Eth-Benzene`,
round(AVG(`MP-Xylene (Âµg/mÂ³)`),2) as `Avg_MP-Xylene`,
round(AVG(`relative_humidity_2m (%)`),2) as `Avg_Relative_Humidity`,
round(AVG(`rain (mm)`),2) as `Avg_Rain`,
round(AVG(`surface_pressure (hPa)`),2) as `Avg_Surface_Pressure`,
round(AVG(`wind_speed_10m (km/h)`),2) as `Avg_Wind_speed_10M (Km/h)`,
round(AVG(`wind_direction_10m (Â°)`),2) as `Avg_Wind_Direction_10M`,
round(AVG(`wind_speed_100m (km/h)`),2) as `Avg_Wind_speed_100M (Km/h)`,
round(AVG(`wind_direction_100m (Â°)`),2) as `Avg_Wind_Direction_100M`
from gurugram.gurugram group by Month(day);

create view all_min as
select 
round(min(`PM10 (Âµg/mÂ³)`),2) AS Min_PM10,
round(min(`NO2 (Âµg/mÂ³)`),2) as Min_NO2,
round(min(`Ozone (Âµg/mÂ³)`),2) as Min_OZONE,
round(min(`Benzene (Âµg/mÂ³)`),2) as Min_Benzene,
round(min(`NO (Âµg/mÂ³)`),2) as Min_NO,
round(min(`NOx (ppb)`),2) as Min_NOx,
round(min(`NH3 (Âµg/mÂ³)`),2) as Min_NH3,
round(min(`SO2 (Âµg/mÂ³)`),2) as Min_SO2,
round(min(`CO (mg/mÂ³)`),2) as Min_CO,
round(min(`Toluene (Âµg/mÂ³)`),2) as Min_Toluene,
round(min(`Xylene (Âµg/mÂ³)`),2) as Min_Xylene,
round(min(`Eth-Benzene (Âµg/mÂ³)`),2) as `Min_Eth-Benzene`,
round(min(`MP-Xylene (Âµg/mÂ³)`),2) as `Min_MP-Xylene`,
round(min(`relative_humidity_2m (%)`),2) as `Min_Relative_Humidity`,
round(min(`rain (mm)`),2) as `Min_Rain`,
round(min(`surface_pressure (hPa)`),2) as `Min_Surface_Pressure`,
round(min(`wind_speed_10m (km/h)`),2) as `Min_Wind_speed_10M (Km/h)`,
round(min(`wind_direction_10m (Â°)`),2) as `Min_Wind_Direction_10M`,
round(min(`wind_speed_100m (km/h)`),2) as `Min_Wind_speed_100M (Km/h)`,
round(min(`wind_direction_100m (Â°)`),2) as `Min_Wind_Direction_100M`
from gurugram.gurugram;


create view all_max as
select 
round(max(`PM10 (Âµg/mÂ³)`),2) AS Max_PM10,
round(max(`NO2 (Âµg/mÂ³)`),2) as Max_NO2,
round(max(`Ozone (Âµg/mÂ³)`),2) as Max_OZONE,
round(max(`Benzene (Âµg/mÂ³)`),2) as Max_Benzene,
round(max(`NO (Âµg/mÂ³)`),2) as Max_NO,
round(max(`NOx (ppb)`),2) as Max_NOx,
round(max(`NH3 (Âµg/mÂ³)`),2) as Max_NH3,
round(max(`SO2 (Âµg/mÂ³)`),2) as Max_SO2,
round(max(`CO (mg/mÂ³)`),2) as Max_CO,
round(max(`Toluene (Âµg/mÂ³)`),2) as Max_Toluene,
round(max(`Xylene (Âµg/mÂ³)`),2) as Max_Xylene,
round(max(`Eth-Benzene (Âµg/mÂ³)`),2) as `Max_Eth-Benzene`,
round(max(`MP-Xylene (Âµg/mÂ³)`),2) as `Max_MP-Xylene`,
round(max(`relative_humidity_2m (%)`),2) as `Max_Relative_Humidity`,
round(max(`rain (mm)`),2) as `Max_Rain`,
round(max(`surface_pressure (hPa)`),2) as `Max_Surface_Pressure`,
round(max(`wind_speed_10m (km/h)`),2) as `Max_Wind_speed_10M (Km/h)`,
round(max(`wind_direction_10m (Â°)`),2) as `Max_Wind_Direction_10M`,
round(max(`wind_speed_100m (km/h)`),2) as `Max_Wind_speed_100M (Km/h)`,
round(max(`wind_direction_100m (Â°)`),2) as `Max_Wind_Direction_100M`
from gurugram.gurugram;

