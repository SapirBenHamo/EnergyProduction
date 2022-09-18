--- Q1


SELECT *
FROM ( SELECT ROUND(electricity_generation,2) AS EG ,YEAR FROM EnergyData) AS S
PIVOT
(
SUM(EG) FOR [YEAR] IN ([2000],[2005],[2010],[2015],[2018])
) AS PVT



---Q2


SELECT 
year,
ROUND(SUM(gas_electricity)/SUM(electricity_generation),3)*100 AS '%OfGas',
ROUND(SUM(coal_electricity)/SUM(electricity_generation),3)*100 AS '%OfCoal',
ROUND(SUM(oil_electricity)/Sum(electricity_generation),3)*100 AS '%OfOil',
ROUND(SUM(solar_electricity)/SUM(electricity_generation),3)*100 AS '%OfSolar',
ROUND(SUM(wind_electricity)/SUM(electricity_generation),3)*100 AS '%Ofwind',
ROUND(SUM(hydro_electricity)/SUM(electricity_generation),3)*100 AS '%OfHydro',
ROUND(SUM(biofuel_electricity)/SUM(electricity_generation),3)*100 AS '%OfBioFuel',
ROUND(SUM(nuclear_electricity)/SUM(electricity_generation),3)*100 AS'%OfNuclear'
FROM EnergyData
WHERE year = 2018 
GROUP BY year



SELECT 
year,
ROUND(SUM(gas_electricity)/SUM(electricity_generation),3)*100 AS '%OfGas',
ROUND(SUM(coal_electricity)/SUM(electricity_generation),3)*100 AS '%OfCoal',
ROUND(SUM(oil_electricity)/Sum(electricity_generation),3)*100 AS '%OfOil',
ROUND(SUM(solar_electricity)/SUM(electricity_generation),3)*100 AS '%OfSolar',
ROUND(SUM(wind_electricity)/SUM(electricity_generation),3)*100 AS '%Ofwind',
ROUND(SUM(hydro_electricity)/SUM(electricity_generation),3)*100 AS '%OfHydro',
ROUND(SUM(biofuel_electricity)/SUM(electricity_generation),3)*100 AS '%OfBioFuel',
ROUND(SUM(nuclear_electricity)/SUM(electricity_generation),3)*100 AS'%OfNuclear'
FROM EnergyData
WHERE year = 2000
GROUP BY year



---Q3

SELECT YEAR,
(ROUND(sum(renewable_electricity),2)/(LAG(sum(renewable_electricity),1) OVER (ORDER BY year))-1)*100 AS '% Renew increase',
(ROUND(sum(conventional_electricity),2)/(LAG(sum(conventional_electricity),1) OVER (ORDER BY year))-1)*100 AS '% OF Conventional increase'
FROM EnergyData
WHERE YEAR IN (1990,1995,2000,2005,2010,2015,2018)
GROUP BY YEAR
ORDER BY YEAR


---Continent

--Q4

SELECT * 
FROM ( SELECT CONTINENT AS 'Cintinent',ROUND(electricity_generation,2) AS'electricity_generation',YEAR FROM EnergyData ) AS S
PIVOT
(
SUM(electricity_generation) FOR [YEAR] IN ([2000],[2005],[2010],[2015],[2018] )
) AS PVT



--Q5

SELECT Continent,
ROUND(SUM(renewable_electricity)/(SUM(renewable_electricity)+SUM(conventional_electricity)),2)AS 'Renewable',
ROUND(SUM(conventional_electricity)/(SUM(renewable_electricity)+SUM(conventional_electricity)),2)AS 'Conventional'
FROM EnergyData
WHERE year =2000
GROUP by Continent
ORDER BY Renewable DESC


SELECT Continent,
ROUND(SUM(renewable_electricity)/(SUM(renewable_electricity)+SUM(conventional_electricity)),2)AS 'Renewable',
ROUND(SUM(conventional_electricity)/(SUM(renewable_electricity)+SUM(conventional_electricity)),2)AS 'Conventional'
FROM EnergyData
WHERE year =2018
GROUP by Continent
ORDER BY Renewable DESC


--Q8

WITH XX AS 
(
SELECT CONTINENT AS 'Continent', YEAR AS 'YEAR' ,ROUND(SUM(electricity_generation) * 1000000000 / SUM(population), 0) AS'energy_per_capita' FROM EnergyData GROUP BY continent,YEAR 
)

SELECT *
FROM XX AS S
PIVOT
(
SUM(energy_per_capita) FOR [YEAR] IN ([2000],[2005],[2010],[2015],[2018]) 
) AS PVT


---Countries

--Q9


WITH yy AS 
(
SELECT country,ROUND(SUM(GDP)/SUM(population),2) AS 'GDPP'
FROM EnergyData
where year = 2018
group by country
)

SELECT *
FROM YY AS K
PIVOT
(
SUM(GDPP) FOR [country] IN ([Israel],[Germany],[india],[Egypt],[United States],[Saudi Arabia])
) 
as pvt



WITH yy AS 
(
SELECT country,ROUND(SUM(GDP)/SUM(population),2) AS 'GDPP'
FROM EnergyData
where year = 2000
group by country
)

SELECT *
FROM YY AS K
PIVOT
(
SUM(GDPP) FOR [country] IN ([Israel],[Germany],[india],[Egypt],[United States],[Saudi Arabia])
) 
as pvt



--Q10

SELECT country,
ROUND(SUM(renewable_electricity)/(SUM(renewable_electricity)+ SUM(conventional_electricity)),2)AS 'Renewable',
ROUND(SUM(conventional_electricity)/(SUM(renewable_electricity)+ SUM(conventional_electricity)),2)AS 'Conventional'
FROM EnergyData 
WHERE renewable_electricity <> 0 and conventional_electricity <> 0 and country in ('Israel','Germany','india','Egypt','United States','Saudi Arabia') and year = 2018
group by country



--Q11

SELECT 

country,
ROUND(SUM(gas_electricity)/SUM(electricity_generation),3)*100 AS '%OfGas',
ROUND(SUM(coal_electricity)/SUM(electricity_generation),3)*100 AS '%OfCoal',
ROUND(SUM(oil_electricity)/Sum(electricity_generation),3)*100 AS '%OfOil',
ROUND(SUM(solar_electricity)/SUM(electricity_generation),3)*100 AS '%OfSolar',
ROUND(SUM(wind_electricity)/SUM(electricity_generation),3)*100 AS '%OfGas',
ROUND(SUM(hydro_electricity)/SUM(electricity_generation),3)*100 AS '%OfHydro',
ROUND(SUM(biofuel_electricity)/SUM(electricity_generation),3)*100 AS '%OfBioFuel',
ROUND(SUM(nuclear_electricity)/SUM(electricity_generation),3)*100 AS'%OfNuclear'

FROM EnergyData
WHERE year= 2018 and country = 'israel'
GROUP BY country
