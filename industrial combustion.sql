use combustion;
select count(*) from new_table;

-- Q1. MMBtu_TOTAL for Ethane & Ethanol 

select Fuel_TYPE,sum(MMBtu_TOTAL) from new_table where Fuel_type = "Ethane" or Fuel_type ="Ethanol (100%)" group by fuel_type ;

-- Q2. Average GWht_TOTAL for 3M Company Facility
select facility_name,avg(GWht_TOTAL) as Avg_GWht from new_table where facility_name = "3M COMPANY";

-- Q.3 Unit Name trend (1950-2020) Vs GWht_TOTAL (d)

select Unit_name,GWht_Total from new_table where Unit_name between 1950 and 2020;
select Unit_name,GWht_Total from new_table where Unit_name = 01-12-1990 or Unit_name= 01-06-1997 or Unit_name=01-04-1981
or Unit_name=01-05-1981 or Unit_name=01-06-1981 or Unit_name=01-08-1950;

with aa as (SELECT unit_name, sum(gwht_total) from new_table where unit_name between "1950" and "2020" group by unit_name) select * from new_table where unit_name regexp'^[0-9]{4}+$';
select unit_name,gwht_total from new_table where unit_name regexp '[0-9]+[-]+[0-9]+[-]+[0-9]{4}+$';


-- Q.4 % Share of MMBtu_TOTAL & GWht_TOTAL for each MECS_Region
select MECS_Region,(sum(MMBtu_Total)/(sum(MMBtu_Total) + sum(GWht_TOTAL))) * 100 as MMBtu_share,
(sum(GWht_Total)/(sum(MMBtu_Total) + sum(GWht_TOTAL))) * 100 as GWht_share from new_table group by MECS_Region;

select MECS_Region, concat(round(sum(mmbtu_total)*100/ (select sum(mmbtu_total) from new_table),2),'%') as MMBtu_share,
concat(round(sum(gwht_total)*100/ (select sum(gwht_total) from new_table),2),'%') as GWht_share from new_table group by MECS_Region;


-- Q.5 PRIMARY_NAICS_TITLE Vs Facility Name and Fuel Type Stats

select primary_naics_title,fuel_type,facility_name from new_table;


select primary_naics_title, count(distinct Facility_name) as No_Of_Facility_name, count(distinct fuel_type) as No_Of_Fuel_type 
from new_table group by primary_naics_title;

