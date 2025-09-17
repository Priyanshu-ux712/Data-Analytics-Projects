SELECT * FROM renewable_energy.renewable_energy;

SELECT country FROM renewable_energy.renewable_energy group by Country;

SELECT year(str_to_date(day,'%d-%m-%Y')) as year FROM renewable_energy.renewable_energy group by year;

create view 01_all_with_deacde_total as
select country,Energy_Source,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy group by Country,Energy_Source,Decade ;


-- country vs spec. energy with decades ------- done
-- spec. country vs energy_sources ---------- done
-- spec. country vs total energy with specifc energy_source with decade ----- done
-- spec. energy_source vs total energy with all countries ---- done
-- spec. country vs all energy_sources with total energy ----- done
-- spec. energy source with decades vs total energy ------- done
-- decades with spec. country vs total energy ----- done
-- countribution of energy sources in each counrty without decades -------- done
-- contribution of countries in each energy sources without decades ------- done
-- complete total energy of all sources ----- done
-- complete total energy of all countries ------ done




create view 01_all_total as
select country,Energy_Source,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy group by country,Energy_Source ;


create view 01_Energies_total_decade as
select Energy_Source,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW 
from renewable_energy.renewable_energy group by Decade,Energy_Source ;



create view 01_countries_total_decade as
select Country,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy group by Decade,Country ;



create view 01_all_total_decade_contribution as
with total_energy_for_contribution as(
select country,
round(sum(Energy_Power),2) as Total_Energy 
from renewable_energy.renewable_energy group by Country
)

select R.Country,R.Energy_Source,
round(sum(R.Energy_Power)/1000,2) as Total_Energy_GW,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(R.Energy_Power)/T.Total_Energy*100,2) as `Contibution_OF_Energy_in(%)`
from renewable_energy.renewable_energy R 
join total_energy_for_contribution T 
on T.Country = R.Country
group by R.Country,R.Energy_Source,Decade;




create view 01_energies_countOFcountries_decade as
select Energy_Source,count(distinct Country) as number_OF_countries,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade
from renewable_energy.renewable_energy group by Energy_Source,Decade;



create view 01_all_total_min_max as
with first1 as (
select Country,Energy_Source,
round(sum(Energy_Power),2) as Total_Energy 
from renewable_energy.renewable_energy group by Country,Energy_Source),
ranked as (
select Country,Energy_Source,Total_Energy, 
row_number() over(partition by Country order by Total_Energy desc) as max_Energy,
row_number() over(partition by Country order by Total_Energy asc) as min_Energy
from first1
)
select Country,Energy_Source,round(Total_Energy/1000,2) as Total_Energy_GW,"Max" as Type from ranked 
where max_Energy = 1
union all 
select Country,Energy_Source,round(Total_Energy/1000,2) as Total_Energy_GW,"Min" as Type from ranked 
where min_Energy = 1; 



create view 01_all_zero_total_decade as
select country,Energy_Source,round(sum(Energy_Power)/1000,2) as Total_Energy_GW,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade 
from renewable_energy.renewable_energy
group by Country,Energy_Source,Decade having round(sum(Energy_Power),2) = 0;



