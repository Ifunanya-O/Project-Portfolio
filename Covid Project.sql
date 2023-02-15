SELECT * 
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` 
WHERE continent = 'Africa';

SELECT * 
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` 
WHERE continent = 'Africa';

/*Total Cases VS Total Deaths*/
SELECT location, total_cases, MAX(total_cases) AS max_total_cases, 
MAX(total_deaths) AS max_total_deaths, 
ROUND(((MAX(total_deaths)/MAX(total_cases))*100),2) AS Deaths_Percentage
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
GROUP BY location, total_cases
ORDER BY total_cases DESC;

/*Total Death Count, this was later used for visualization on Tableau*/
SELECT continent, location, SUM(new_deaths) AS total_deathcount, 
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
GROUP BY continent, location
ORDER BY total_deathcount DESC;

/*Death Rate by Continent, this was later used for visualization on Tableau*/
SELECT continent, population, SUM(new_deaths) AS total_deaths, 
ROUND((SUM(new_deaths)/population*100),4) as death_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent IS NOT NULL 
GROUP BY continent, population
ORDER BY 1,2 DESC;

/*Death Rate in Africa, this was later used for visualization on Tableau*/
SELECT continent, location, population, SUM(new_deaths) AS total_deaths, 
ROUND((SUM(new_deaths)/population*100),4) as death_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
GROUP BY continent, location, population
ORDER BY 1,2;

/*Infection Rate by Continent, this was later used for visualization on Tableau*/
SELECT continent, population,
SUM(new_cases) AS overall_cases,  
ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent IS NOT NULL 
GROUP BY continent, population
ORDER BY 1,2 DESC;

/*Infection Rate in Africa, this was later used for visualization on Tableau*/
SELECT continent, location, population, 
SUM(new_cases) AS overall_cases,  
ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
GROUP BY continent,location,population
ORDER BY 1, 2;

/*2020 Infection Rate in Africa*/
SELECT continent, location, population, 
SUM(new_cases) AS overall_cases,  
ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
AND date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY continent, location, population
ORDER BY 1,2; 

/*2021 Infection Rate in Africa*/
SELECT continent, location, population, 
SUM(new_cases) AS overall_cases,  
ROUND(((SUM(new_cases)/ population)*100),4) AS infection_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths`
WHERE continent = 'Africa'
AND date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY continent, location,population
ORDER BY 1,2; 

/*Vaccination Rate in Africa, this was later used for visualization on Tableau*/
SELECT dea.continent, dea.location, dea.population,
SUM(dea.new_cases) AS overall_cases, 
SUM(vac.total_vaccinations) AS overall_vaccinations, 
ROUND(((SUM(vac.total_vaccinations)/dea.population)*100),4) AS vaccination_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent = 'Africa' 
GROUP BY dea.continent,dea.location,dea.population
ORDER BY overall_cases DESC;

/*Vaccination Rate by Continent*/
SELECT dea.continent, SUM(dea.population) AS total_population, 
SUM(dea.new_cases) AS overall_cases, 
SUM(vac.total_vaccinations) AS overall_vaccinations, 
ROUND(((SUM(vac.total_vaccinations)/SUM(dea.population))*100),4) AS vaccination_rate
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
GROUP BY dea.continent
ORDER BY 1,2;

/*Showing new vaccinations administered per day*/
SELECT dea.location, dea.population, vac.new_vaccinations
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent = 'Africa'
ORDER BY 1,2;

/*Showing up to date record of vaccinations administered by date in each country*/
SELECT dea.location, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location, dea.date) 
AS Updated_Vaccination_Records
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent = 'Africa' 
AND vac.new_vaccinations IS NOT NULL
ORDER BY 1,2,3; 

/*Showing up to date percentage of vaccinated population for each country*/
WITH Vaccinated_population AS 
(
  SELECT dea.location, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) 
OVER (PARTITION BY dea.location, dea.date) AS Updated_Vaccination_Records
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent = 'Africa'
)
SELECT *, 
ROUND(((Updated_Vaccination_Records/population)*100),4) AS vaccinated_population_percentage
FROM Vaccinated_population
WHERE Updated_Vaccination_Records IS NOT NULL;


SELECT *
FROM `fiery-azimuth-376322.PortfolioOne.Covid_Deaths` AS dea
JOIN `fiery-azimuth-376322.PortfolioOne.Covid_Vaccinations` AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
LIMIT 100;
