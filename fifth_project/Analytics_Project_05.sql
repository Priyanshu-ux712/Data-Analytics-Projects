SELECT * FROM renewable_energy.renewable_energy;

SELECT country FROM renewable_energy.renewable_energy group by Country;

SELECT year(str_to_date(day,'%d-%m-%Y')) as year FROM renewable_energy.renewable_energy group by year;

-- country vs spec. energy with decades ------- done
create view Countries_vs_specific_Energy as
select country,Energy_Source,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy where Energy_Source = "bioenergy" group by Country,Decade ;

-- spec. country vs energy_sources ---------- done
create view specific_country_VS_Energies as
select country,Energy_Source,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy where Country = "DE" group by Energy_Source,Decade ;

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


-- spec. country vs total energy with specifc energy_source with decade ----- done
create view spec_country_VS_spec_energy as
select country,Energy_Source,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW 
from renewable_energy.renewable_energy where Country = "DE"and Energy_Source = "bioenergy" group by Decade ;



-- spec. energy_source vs total energy with all countries 
create view spec_energy_VS_Countries_total_energies as
select country,Energy_Source,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy where Energy_Source = "bioenergy" group by country ;



-- spec. country vs all energy_sources with total energy
create view spec_country_VS_energy_sources_total_energies as
select country,Energy_Source,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW 
from renewable_energy.renewable_energy where Country = "DE" group by Energy_Source ;



-- spec. energy source with decades vs total energy
create view spec_energy_VS_total_energy_decade as
select Energy_Source,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW 
from renewable_energy.renewable_energy where Energy_Source = "bioenergy" group by Decade ;



-- decades with spec. country vs total energy 
create view spec_country_VS_total_energy_decade as
select Country,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy where Country = "DE" group by Decade ;



-- countribution of energy sources in each counrty without decades
create view spec_country_VS_energies_contribution as
with total_energy_for_contribution as(
select country,
round(sum(Energy_Power),2) as Total_Energy 
from renewable_energy.renewable_energy where Country = "DE" )

select R.Country,R.Energy_Source,
round(sum(R.Energy_Power)/1000,2)as Total_Energy_GW,
round(sum(R.Energy_Power)/T.Total_Energy*100,2) as 'Contibution_OF_Energy_in(%)'
from renewable_energy.renewable_energy R 
join total_energy_for_contribution T 
on T.Country = R.Country
where R.Country = "DE"
group by R.Country,R.Energy_Source;




-- Country vs renewable share (%) per decade
create view spec_country_VS_spec_energy_contribution_decade as
with total_energy_for_contribution as(
select country,
round(sum(Energy_Power),2) as Total_Energy 
from renewable_energy.renewable_energy where Country = "DE" and Energy_Source = "wind" )

select R.Country,R.Energy_Source,
round(sum(R.Energy_Power)/1000,2) as Total_Energy_GW,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(R.Energy_Power)/T.Total_Energy*100,2) as 'Contibution_OF_Energy_in(%)'
from renewable_energy.renewable_energy R 
join total_energy_for_contribution T 
on T.Country = R.Country
where R.Country = "DE" and Energy_Source = "wind"
group by R.Country,R.Energy_Source,Decade;




-- contribution of countries in each energy sources without decades
-- create view countries_VS_spec_energy_contribution as
with total_energy_for_contribution as(
select country,
sum(Energy_Power) as Total_Energy 
from renewable_energy.renewable_energy group by country )

select R.Country,R.Energy_Source,
round(sum(R.Energy_Power)/1000,2) as Total_Energy_GW,
round(sum(R.Energy_Power)/T.Total_Energy*100,2) as `Contibution_OF_Energy_in(%)`
from renewable_energy.renewable_energy R 
join total_energy_for_contribution T 
on T.Country = R.Country
where R.Energy_Source = "solar"
group by R.Country,R.Energy_Source,T.Total_Energy;



-- complete total energy of all sources
create view energies_VS_total_Energy as
select Energy_Source , round(sum(Energy_Power)/1000,2) as Total_Energy_GW from renewable_energy.renewable_energy group by Energy_Source;



-- complete total energy of all countries
create view countries_VS_total_energy as
select Country,round(sum(Energy_Power)/1000,2) as Total_Energy_GW from renewable_energy.renewable_energy group by Country;



-- Country vs peak energy source per decade
create view spec_country_VS_spec_energy_decade as
select country,Energy_Source,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy where Energy_Source = "bioenergy" and Country = "DE" group by Country,Decade order by Total_Energy_GW desc;



-- Energy source vs number of countries adopting it per decade
create view energies_VS_countOFcountries_decade as
select Energy_Source,count(distinct Country) as number_OF_countries,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade
from renewable_energy.renewable_energy group by Energy_Source,Decade;



-- Energy source vs total growth rate per decade
create view energies_VS_total_energy_decade as
select Energy_Source,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy group by Decade,Energy_Source ;



-- Country vs total renewable energy per decade (all energy sources)
create view spec_countries_VS_total_energy_decade as
select Country,concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade,
round(sum(Energy_Power)/1000,2) as Total_Energy_GW
from renewable_energy.renewable_energy group by Decade,Country ;



-- Country vs max/min energy source (all time)
create view countries_energies_min_max as
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



-- countries with energies in decades where total energy is zero
create view 0_countries_energies_decade_total_energy_0 as 
select country,Energy_Source,round(sum(Energy_Power)/1000,2) as Total_Energy_GW,
concat(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10 ,"-", 
least(floor(year(str_to_date(day,'%d-%m-%Y'))/10)*10+9,(select max(year(str_to_date(day,'%d-%m-%Y'))) from renewable_energy.renewable_energy) )) as Decade 
from renewable_energy.renewable_energy
group by Country,Energy_Source,Decade having round(sum(Energy_Power),2) = 0;



