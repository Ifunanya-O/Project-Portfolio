/* Covid DATA Exploration Skills used: Joins,
  CTE,
  Windows Functions,
  Aggregate Functions,
  Converting DATA Types 
  Tool used: Google BigQuery */
  
SELECT
  *
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa';
SELECT
  *
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations`
WHERE
  continent = 'Africa'; 
  
  /*Max Total Cases VS Max Total Deaths,
  shows the highest likelihood OF dying
  FROM Covid per country IN Africa*/
SELECT
  location,
  MAX(total_cases) AS max_total_cases,
  MAX(total_deaths) AS max_total_deaths,
  ROUND(((MAX(total_deaths)/MAX(total_cases))*100),2) AS Deaths_Percentage
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
GROUP BY
  location
ORDER BY
  Deaths_Percentage DESC; 
  
  /*Total Death Count
  AND number OF Overall Cases 
  IN different African countries, 
  This was later used FOR visualization
   on Tableau*/
SELECT
  continent,
  location,
  SUM(new_cases) AS overall_cases,
  SUM(new_deaths) AS total_deathcount,
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
GROUP BY
  continent,
  location
ORDER BY
  overall_cases DESC,
  total_deathcount DESC; 
  
  /*Total Death Count
  AND number OF Overall Cases IN each continent, 
  This was later used FOR visualization
  ON Tableau*/
SELECT
  continent,
  SUM(new_cases) AS overall_cases,
  SUM(new_deaths) AS total_deaths,
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  continent
ORDER BY
  1,2; 
  
  /*Death Rate IN Africa,
  shows the death per population 
  IN African countries, 
  This was later used FOR visualization
  ON Tableau*/
SELECT
  continent,
  location,
  population,
  SUM(new_deaths) AS total_deaths,
  ROUND((SUM(new_deaths)/population*100),4) AS death_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
GROUP BY
  continent,
  location,
  population
ORDER BY
  population DESC; 
  
  /*Infection Rate BY Continent,
  shows the rate OF infection per population 
  IN each continent, 
  This was later used FOR visualization
  ON Tableau*/
SELECT
  continent,
  SUM(population) AS total_population,
  SUM(new_cases) AS overall_cases,
  ROUND(((SUM(new_cases)/ SUM(population))*100),4) AS infection_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent IS NOT NULL
GROUP BY
  continent
ORDER BY
  1,2; 
  
  /*Infection Rate IN Africa,
  shows the rate OF population
  WITH infection IN each African country, 
  This was later used FOR visualization
  ON Tableau*/
SELECT
  continent,
  location,
  population,
  SUM(new_cases) AS overall_cases,
  ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
GROUP BY
  continent,
  location,
  population
ORDER BY
  1,2; 
  
  /*2020 Infection Rate IN Africa,
  shows the rate OF population
  WITH infection IN each African country 
  before vaccination commenced*/
SELECT
  continent,
  location,
  population,
  SUM(new_cases) AS overall_cases,
  ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
  AND date BETWEEN '2020-01-01'
  AND '2020-12-31'
GROUP BY
  continent,
  location,
  population
ORDER BY
  1,2; 
  
  /*2021 Infection Rate IN Africa,
  shows the rate OF population
  WITH infection IN each African country 
  after vaccination commenced*/
SELECT
  continent,
  location,
  population,
  SUM(new_cases) AS overall_cases,
  ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE
  continent = 'Africa'
  AND date BETWEEN '2021-01-01'
  AND '2021-12-31'
GROUP BY
  continent,
  location,
  population
ORDER BY
  1,2; 
  
  /*Vaccination Rate IN Africa,
  shows the rate OF vaccination per population 
  IN each African country, 
  This was later used FOR visualization
  ON Tableau*/
SELECT
  dea.continent,
  dea.location,
  dea.population,
  SUM(dea.new_cases) AS overall_cases,
  SUM(vac.total_vaccinations) AS overall_vaccinations,
  ROUND(((SUM(vac.total_vaccinations)/dea.population)*100),4) AS vaccination_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent = 'Africa'
GROUP BY
  dea.continent,
  dea.location,
  dea.population
ORDER BY
  overall_vaccinations DESC; 
  
  /*Vaccination Rate by Continent, 
  shows the rate of vaccination per population in each continent*/
SELECT
  dea.continent,
  SUM(dea.population) AS total_population,
  SUM(dea.new_cases) AS overall_cases,
  SUM(vac.total_vaccinations) AS overall_vaccinations,
  ROUND(((SUM(vac.total_vaccinations)/SUM(dea.population))*100),4) AS vaccination_rate
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent IS NOT NULL
GROUP BY
  dea.continent
ORDER BY
  1,2; 
  
  /*Showing new vaccinations administered per day in each African country*/
SELECT
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent = 'Africa'
ORDER BY
  1,2; 
  
  /*Showing up to date record of vaccinations administered by date 
  in each African country*/
SELECT
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location, dea.date) AS Updated_Vaccination_Records
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent = 'Africa'
  AND vac.new_vaccinations IS NOT NULL
ORDER BY
  1,2,3; 
  
  /*Showing up TO date percentage OF vaccinated population FOR each country,
  shows the percentage OF vaccinated population IN each African country*/
WITH
  Vaccinated_population AS (
  SELECT
    dea.location,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location, dea.date) AS Updated_Vaccination_Records
  FROM
    `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
  JOIN
    `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
  ON
    dea.location = vac.location
    AND dea.date = vac.date
  WHERE
    dea.continent = 'Africa' )
SELECT
  *,
  ROUND(((Updated_Vaccination_Records/population)*100),4) AS vaccinated_population_percentage
FROM
  Vaccinated_population
WHERE
  Updated_Vaccination_Records IS NOT NULL;
SELECT
  *
FROM
  `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN
  `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON
  dea.location = vac.location
  AND dea.date = vac.date
WHERE
  dea.continent IS NOT NULL
LIMIT
  100;