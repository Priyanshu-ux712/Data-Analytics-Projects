SELECT * FROM modifiedgwr.modifiedgwr;


create view modifiedgwr.Temperature as 
select year(last_updated) as `year`,quarter(last_updated) as `Quarter`,month(last_updated) as `month` ,country,location_name,timezone,
round(avg(temperature_celsius)) as avg_temp_cel,
round(avg(feels_like_celsius)) as avg_temp_feel_cel, 
round(avg(feels_like_celsius-temperature_celsius)) as temp_diff from 
modifiedgwr.modifiedgwr group by country,location_name,timezone,year(last_updated),quarter(last_updated),month(last_updated) order by avg_temp_cel asc;


create view modifiedgwr.region_condition as 
select country,location_name,round(avg(temperature_celsius)) as avg_temp_cel,round(avg(humidity)) as humidity,
case 
when round(avg(temperature_celsius)) > 25 and round(avg(humidity)) > 60 then "Hot & Humid (Tropical)"
when round(avg(temperature_celsius)) > 30 and round(avg(humidity)) < 40 then "Hot & Dry (Desert)"
when round(avg(temperature_celsius)) < 20 and round(avg(humidity)) < 40 then "Cold & Dry (Desert/Arid)"
else "Moderate"
end as region_condition
from modifiedgwr.modifiedgwr 
group by country,location_name;


create view modifiedgwr.cloudy_visibility as 
select year(last_updated) as `year`,quarter(last_updated) as `quarter`,country,location_name,round(avg(cloud)) as cloudy, 
round(avg(visibility_km)) as visibility_km,round(avg(wind_kph)) as wind_kph
from modifiedgwr.modifiedgwr group by country,location_name,`year`,`quarter`;


create view modifiedgwr.wind_direction as 
select year(last_updated) as `year`,quarter(last_updated) as `quarter`,country,count(*) countOFcountires,wind_direction,
round(avg(wind_kph)) as wind_speed from modifiedgwr.modifiedgwr group by country,wind_direction,year(last_updated),quarter(last_updated);


create view modifiedgwr.pressure_condition as
select year(last_updated) as `year`,quarter(last_updated) as `quarter`,country,condition_text,round(avg(pressure_mb)) as pressure,
round(avg(visibility_km)) as visibility_km,round(avg(temperature_celsius)) as avg_temp_cel,round(avg(humidity)) as Avg_humidity
from modifiedgwr.modifiedgwr group by country,condition_text,year(last_updated),quarter(last_updated);


create view modifiedgwr.AQI as 
select year(last_updated) as `year`,quarter(last_updated) as `quarter`,country,
ROUND(AVG(CASE 
                WHEN air_quality_Carbon_Monoxide >= 0 THEN air_quality_Carbon_Monoxide
                ELSE (SELECT AVG(t.air_quality_Carbon_Monoxide) 
                      FROM modifiedgwr t 
                      WHERE t.air_quality_Carbon_Monoxide >= 0)
            END
            )
            ) as `Avg_CO_μg/m³`,
round(avg(`air_quality_gb-defra-index`)) as Avg_GB_DEFRA_index,
round(avg(air_quality_Nitrogen_dioxide)) as `Avg_NO2_μg/m³`,
round(avg(air_quality_Ozone)) as `Avg_O3_μg/m³`,
round(avg(air_quality_PM10)) as `Avg_PM10_μg/m³`,
round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5_μg/m³`,
round(avg(air_quality_Sulphur_dioxide)) as `Avg_SO2_μg/m³`,
round(avg(`air_quality_us-epa-index`)) as Avg_USA_EPA,
round(avg(wind_kph)) as wind_kph,
case 
when round(avg(temperature_celsius)) > 25 and round(avg(humidity)) > 60 then "Hot & Humid (Tropical)"
when round(avg(temperature_celsius)) > 30 and round(avg(humidity)) < 40 then "Hot & Dry (Desert)"
when round(avg(temperature_celsius)) < 20 and round(avg(humidity)) < 40 then "Cold & Dry (Desert/Arid)"
else "Moderate"
end as region_condition,
case 
when round(avg(wind_kph)) between 0 and 5 then "Calm"
when round(avg(wind_kph)) between 6 and 11 then "Light Breeze"
when round(avg(wind_kph)) between 12 and 19 then "Gentle Breeze"
when round(avg(wind_kph)) between 20 and 28 then "Moderate Breeze"
when round(avg(wind_kph)) between 29 and 38 then "Fresh Breeze"
when round(avg(wind_kph)) between 39 and 49 then "Strong Breeze"
when round(avg(wind_kph)) > 50 then "High Wind"
end as wind_status
from modifiedgwr.modifiedgwr group by country,year(last_updated),quarter(last_updated);


create view modifiedgwr.countries_pollution_status as 
select country,location_name,round(avg(`air_quality_gb-defra-index`)) as Avg_DEFRA_index,round(avg(`air_quality_us-epa-index`)) as Avg_EPA_index,
round(avg(air_quality_PM10)) as Avg_PM10,round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,round(avg(wind_kph)) as Avg_wind_speed,
round(avg(humidity)) as Avg_humidity,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name;


create view modifiedgwr.Clean_Cities as 
select country,location_name,round(avg(`air_quality_gb-defra-index`)) as Avg_DEFRA_index,round(avg(`air_quality_us-epa-index`)) as Avg_EPA_index,
round(avg(air_quality_PM10)) as Avg_PM10,round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) > 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name order  by Avg_DEFRA_index asc limit 10;


create view modifiedgwr.Polluted_Cities as 
select country,location_name,round(avg(`air_quality_gb-defra-index`)) as Avg_DEFRA_index,round(avg(`air_quality_us-epa-index`)) as Avg_EPA_index, 
round(avg(air_quality_PM10)) as Avg_PM10,round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name order  by Avg_DEFRA_index desc limit 10;


create view modifiedgwr.astro as 
SELECT moon_phase,
CASE 
  WHEN latitude BETWEEN -23.5 AND 23.5 THEN 'Tropical (Equator)'
  WHEN ABS(latitude) BETWEEN 23.5 AND 40 THEN 'Subtropical'
  WHEN ABS(latitude) BETWEEN 40 AND 60 THEN 'Temperate (Mid-Latitude)'
  WHEN ABS(latitude) BETWEEN 60 AND 66.5 THEN 'Subpolar'
  ELSE 'Polar'
END AS Latitude_Zone,latitude,
round(avg(moon_illumination)) as avg_illumination,round(avg(air_quality_PM10)) as Avg_PM10,round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,
round(avg(temperature_celsius)) as avg_temp,
round(avg(humidity)) as avg_humidity,round(avg(uv_index)) as avg_uv_index,round(avg(visibility_km)) as Avg_Visibility,
case when round(avg(uv_index)) between 0 and 2 then "Low"
when round(avg(uv_index)) between 3 and 5 then "Moderate"
when round(avg(uv_index)) between 6 and 7 then "High"
when round(avg(uv_index)) between 8 and 10 then "Very High"
when round(avg(uv_index)) >= 11 then "Extreme" 
else "Unkown"
end as 
UV_Status
FROM modifiedgwr.modifiedgwr group by Latitude_zone,moon_phase,latitude;


create view modifiedgwr.top_factors as 
with main as(
select country,location_name,
round(avg(temperature_celsius)) as Avg_temp,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name
),
min_temp as(
select *
from main order by Avg_temp asc limit 10
),
max_temp as (
select *
from main order by Avg_temp desc limit 10
)
SELECT 'Coldest' AS category, country, location_name, Avg_temp,Pollution_Status
FROM min_temp
UNION ALL
SELECT 'Hottest' AS category, country, location_name, Avg_temp,Pollution_Status
FROM max_temp
ORDER BY Avg_temp;


create view modifiedgwr.numeric_coor as 
select temperature_celsius,wind_kph,precip_mm,humidity,visibility_km,uv_index,air_quality_PM10,`air_quality_PM2.5`,moon_illumination 
from modifiedgwr.modifiedgwr;


create view modifiedgwr.temp_trend as 
select country,year(last_updated) as Year, month(last_updated) as Month,round(avg(temperature_celsius)) as Avg_temp 
from modifiedgwr.modifiedgwr group by country,Year,Month;


create view modifiedgwr.pollution_wind_speed as 
select country,location_name,round(avg(`air_quality_gb-defra-index`)) as Avg_DEFRA_index,round(avg(wind_kph)) as Avg_wind_speed,
round(avg(`air_quality_us-epa-index`)) as Avg_EPA_index, 
round(avg(air_quality_PM10)) as Avg_PM10,round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr 
group by country,location_name;


create view modifiedgwr.Most_Polluted_Cities as
select country,location_name,
round(avg(`air_quality_gb-defra-index`)) as Avg_DEFRA_index,
round(avg(`air_quality_us-epa-index`)) as Avg_EPA_index, 
round(avg(air_quality_PM10)) as Avg_PM10,
round(avg(`air_quality_PM2.5`)) as `Avg_PM2.5`,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name order by Avg_DEFRA_index desc limit 10;



-- Wind Speed vs PM₂.₅ & PM₁₀ with Precipitation
create view modifiedgwr.numeric_ as
select round(wind_kph) as wind_kph,
round(`air_quality_PM2.5`) as `air_quality_PM2.5`,
round(`air_quality_PM10`) as `air_quality_PM10`,
round(`precip_mm`) as `precip_mm`
from modifiedgwr.modifiedgwr;

-- EPA Index vs PM₂.₅ & PM₁₀; DEFRA Index vs PM₂.₅ & PM₁₀
create view modifiedgwr.index_vs_values as
select round(wind_kph) as wind_kph,
round(`air_quality_PM2.5`) as `air_quality_PM2.5`,
round(`air_quality_PM10`) as `air_quality_PM10`,
round(`air_quality_gb-defra-index`) as GB_DEFRA_INDEX ,
round(`air_quality_us-epa-index`) as US_EPA_INDEX
from modifiedgwr.modifiedgwr;


-- Country-level Avg Wind Speed with Wind Direction, Quarter & Year slicers
create view modifiedgwr.wind_direction as
select year(last_updated) as year,
year(last_updated) as quarter,
country,
wind_direction,
round(avg(wind_kph)) as wind_kph 
from modifiedgwr.modifiedgwr group by year(last_updated) , year(last_updated) , country , wind_direction;


-- Temperature vs Pressure
create view modifiedgwr.temp_Pre as
select round(temperature_celsius) as temperature_celsius , round(pressure_mb) as pressure_mb from modifiedgwr.modifiedgwr;

-- Pressure vs Visibility with Weather Slicers
create view modifiedgwr.pre_visi as
select round(visibility_km) as visibility_km , round(pressure_mb) as pressure_mb , condition_text from modifiedgwr.modifiedgwr;

-- Year, Month, Quarter with Temp, Feels-Like Temp, Temp Diff (Countries slicer)
create view modifiedgwr.time_temp as
select country,
year(last_updated) as year,
month(last_updated) as month,
quarter(last_updated) as quarter,
round(pressure_mb) as pressure_mb,
round(temperature_celsius) as temperture_celsius,
round(feels_like_celsius) as feels_like_celsius,
round(feels_like_celsius - temperature_celsius) as temp_diff
from modifiedgwr.modifiedgwr;



-- Cities Temperature with Hot vs Cold categories, Pollution Status, Countries slicers
create view modifiedgwr.hot_cold as
select country,
round(avg(temperature_celsius)) as Avg_temp,
case 
when round(avg(temperature_celsius)) <= 15 then "cold"
when round(avg(temperature_celsius)) >= 30 then "hot"
else "moderate" end as temperature_categories,
case when round(avg(`air_quality_PM2.5`)) between 0 and 5 then "Very Clean"
when round(avg(`air_quality_PM2.5`)) between 6 and 15 then "Clean"
when round(avg(`air_quality_PM2.5`)) between 16 and 25 then "Moderate"
when round(avg(`air_quality_PM2.5`)) between 26 and 35 then "Polluted"
when round(avg(`air_quality_PM2.5`)) >= 36 then "Most Polluted"
end as Pollution_Status
from modifiedgwr.modifiedgwr group by country,location_name order by avg_temp;


-- Humidity vs Precipitation
create view modifiedgwr.humidity_precipitation as
select humidity, precip_mm from modifiedgwr.modifiedgwr;


SELECT DATE_FORMAT(last_updated, '%Y-%m-%d') AS start_month_year
FROM modifiedgwr.modifiedgwr
ORDER BY last_updated desc
LIMIT 1;

SELECT DATE_FORMAT(last_updated, '%Y-%m-%d') AS start_month_year
FROM modifiedgwr.modifiedgwr
ORDER BY last_updated asc
LIMIT 1;