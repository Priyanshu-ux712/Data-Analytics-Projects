SELECT * FROM fourth_project.rich_global_condom_usage_dataset;

SELECT COUNT(*) AS ROWS_COUNT FROM fourth_project.rich_global_condom_usage_dataset;

CREATE VIEW `COUNTRY'S_ORDER` AS
SELECT Country , SUM(`Total Sales (Million Units)`) AS SOLD_UNITS , 
ROUND(SUM(`Market Revenue (Million USD)`),2) AS TOTAL_REVENUE FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Country ORDER BY TOTAL_REVENUE DESC;

CREATE VIEW PRICE_VS_SALES AS 
SELECT `Average Price per Condom (USD)` AS AVERAGE_PRICE,`Total Sales (Million Units)` AS SOLD_UNITS FROM fourth_project.rich_global_condom_usage_dataset;


CREATE VIEW Brand_Dominance AS 
SELECT `Brand Dominance` as Brand , ROUND(SUM(`Market Revenue (Million USD)`),2) AS TOTAL_REVENUE , 
SUM(`Total Sales (Million Units)`) AS TOTAL_SALES , 
(ROUND(SUM(`Market Revenue (Million USD)`)*100/(SELECT SUM(`Market Revenue (Million USD)`)FROM fourth_project.rich_global_condom_usage_dataset),2)) AS PERCENT
FROM fourth_project.rich_global_condom_usage_dataset 
GROUP BY Brand;


CREATE VIEW Popular_types AS
SELECT Country, `Most Popular Condom Type` , COUNT(*) AS FREQUENCY FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Country,`Most Popular Condom Type`;


CREATE VIEW GOC_CAMP AS
SELECT Country,`Sex Education Programs (Yes/No)` AS SEX_EDU, `Government Campaigns` AS GOV_CAMP , ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_AWARENESS_INDEX (0-10)`, 
ROUND(AVG(`Contraceptive Usage Rate (%)`),2) AS `AVG_Contraceptive_Usage_Rate (%)`
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY  Country, `Government Campaigns`, `Sex Education Programs (Yes/No)` ;


CREATE VIEW SEX_EDU_IMPACT AS 
SELECT Country, `Sex Education Programs (Yes/No)` AS SEX_EDU , 
ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_AWARENESS_INDEX (0-10)`,
ROUND(AVG(`Teen Pregnancy Rate (per 1000 teens)`),2) AS `AVG_Teen Pregnancy Rate (per 1000 teens)`,SUM(`Total Sales (Million Units)`) AS TOTAL_SALES
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Country , `Sex Education Programs (Yes/No)` ORDER BY `AVG_AWARENESS_INDEX (0-10)` DESC ;


CREATE VIEW Effect_of_awareness AS
SELECT `Awareness Index (0-10)` AS AWARENESS_INDEX , 
ROUND(AVG(`Contraceptive Usage Rate (%)`),2) AS `AVG_Contraceptive_Usage_Rate (%)`,
ROUND(AVG(`Teen Pregnancy Rate (per 1000 teens)`),2) AS `AVG_Teen Pregnancy Rate (per 1000 teens)`,
ROUND(AVG(`HIV Prevention Awareness (%)`),2) AS `AVG_HIV Prevention Awareness (%)`
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY `Awareness Index (0-10)` ORDER BY `Awareness Index (0-10)` ;



CREATE VIEW  HIV_awareness AS 
SELECT Country ,ROUND(AVG(`HIV Prevention Awareness (%)`),2) AS `AVG_HIV Prevention Awareness (%)`, 
ROUND(AVG(`Total Sales (Million Units)`),2) as `AVG_Total Sales (Million Units)`
FROM fourth_project.rich_global_condom_usage_dataset  GROUP BY Country;



CREATE VIEW online_sales AS
SELECT Country, `Sex Education Programs (Yes/No)`,`Government Campaigns` ,
ROUND(AVG(`Online Sales (%)`),2) AS AVG_ONLINE_SALES , 
ROUND(AVG(`HIV Prevention Awareness (%)`),2) AS `AVG_HIV Prevention Awareness (%)`,
ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_Awareness Index (0-10)`,
ROUND(AVG(`Contraceptive Usage Rate (%)`),2) AS `AVG_Contraceptive Usage Rate (%)`,
ROUND(AVG(`Teen Pregnancy Rate (per 1000 teens)`),2) AS `AVG_Teen Pregnancy Rate (per 1000 teens)`
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Country, `Sex Education Programs (Yes/No)`,`Government Campaigns` ORDER BY AVG_ONLINE_SALES ;



CREATE VIEW Gender_split AS
SELECT Country,`Sex Education Programs (Yes/No)`,ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_Awareness Index (0-10)`,
ROUND(AVG(`Purchases (%)`),2) AS `AVG_MALE_PURCHASES(%)`, 
ROUND(AVG(`Purchases (%)2`),2) AS `AVG_FEMALE_PURCHASES(%)` FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Country,`Sex Education Programs (Yes/No)`;



CREATE VIEW OVER_YEARS AS 
SELECT Year,SUM(`Total Sales (Million Units)`)AS TOTAL_UNITS,
ROUND(SUM(`Market Revenue (Million USD)`),2) AS TOTAL_REVENUE,
ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_Awareness Index (0-10)`
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Year;



CREATE VIEW Year_wise_Campaigns AS
SELECT Year,`Government Campaigns`,
ROUND(AVG(`Awareness Index (0-10)`),2) AS `AVG_Awareness Index (0-10)`,
ROUND(AVG(`Contraceptive Usage Rate (%)`),2) AS `AVG_Contraceptive Usage Rate (%)` ,
ROUND(AVG(`Teen Pregnancy Rate (per 1000 teens)`),2) AS `AVG_Teen Pregnancy Rate (per 1000 teens)`,
ROUND(AVG(`HIV Prevention Awareness (%)`),2) AS `AVG_HIV Prevention Awareness (%)`
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Year,`Government Campaigns`;


CREATE VIEW `purchase behavior over time` AS
SELECT Year, ROUND(AVG(`Online Sales (%)`),2) AS `AVG_Online Sales (%)`,
ROUND(AVG(`Purchases (%)`),2) AS AVG_MALE_PURCHASE,
ROUND(AVG(`Purchases (%)2`),2) AS AVG_FEMALE_PURCHASE 
FROM fourth_project.rich_global_condom_usage_dataset GROUP BY Year;