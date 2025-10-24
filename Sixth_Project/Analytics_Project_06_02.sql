select * from modifiedgwr.modifiedgwr;

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
year(last_updated) as quarter,
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



