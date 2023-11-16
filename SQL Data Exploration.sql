Select * 
From PortifolioProject..CovidDeaths
where continent is not null
order by 3,4

----Select * 
----From PortifolioProject..CovidVaccinations
----order by 3,4

---- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortifolioProject..CovidDeaths
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (convert(float, total_deaths) / nullif(convert(float, total_cases), 0))*100 as DeathPercentage
From PortifolioProject..CovidDeaths
Where location like '%brazil%'
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
Select Location, date, population, total_cases, (total_cases / population)*100 as InfeccionPercentage
From PortifolioProject..CovidDeaths
Where location like '%brazil%'
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population
Select Location, population, MAX(total_cases) as HighestInfeccionCount, MAX((total_cases / population))*100 as InfeccionPercentage
From PortifolioProject..CovidDeaths
where continent is not null
Group by Location, population
order by InfeccionPercentage desc

-- Showing Countries with Highest Death Count per Population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
where continent is not null
Group by Location
order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the hightest death count per Population
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
where continent is null
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS
Select date, SUM(new_cases) as Cases, SUM(new_deaths) as Deaths, SUM(new_deaths) / nullif(SUM(new_cases), 0) * 100 as DeathPercentage
From PortifolioProject..CovidDeaths
where continent is null
Group by date
order by 1,2

Select SUM(new_cases) as Cases, SUM(new_deaths) as Deaths, SUM(new_deaths) / nullif(SUM(new_cases), 0) * 100 as DeathPercentage
From PortifolioProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- CTE

With PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopVsVac



-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *
From PercentPopulationVaccinated