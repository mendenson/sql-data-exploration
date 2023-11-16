# Portfolio Project: COVID-19 Data Analysis

This repository contains SQL queries and data analysis scripts for exploring and visualizing COVID-19 data. The project focuses on understanding the impact of the pandemic on different regions, assessing infection and death rates, and analyzing vaccination trends.

## Data Sources

The project utilizes two main tables from the `PortifolioProject` database:

1. **CovidDeaths**
   - Contains information about COVID-19 deaths, including location, date, total cases, new cases, total deaths, and population.

2. **CovidVaccinations**
   - Provides data on COVID-19 vaccinations, including location, date, and new vaccinations.

## SQL Queries and Analysis

### Basic Data Selection

- Retrieve COVID-19 deaths data for continents, excluding records with null continents, and order by columns 3 and 4.

### Total Cases vs. Total Deaths

- Calculate death percentage for Brazil by comparing total deaths to total cases over time.

### Total Cases vs. Population

- Examine infection percentage in Brazil by comparing total cases to the population over time.

### Countries with Highest Infection Rate

- Identify countries with the highest infection rate compared to their population.

### Countries with Highest Death Count per Population

- List countries with the highest death count per population.

### Analysis by Continent

- Explore continents with the highest death count per population.

### Global COVID-19 Numbers

- Summarize global COVID-19 statistics, including cases, deaths, and death percentages, both globally and by continent.

### Population vs. Vaccinations

- Analyze the relationship between total population, new vaccinations, and rolling vaccinated population over time for each location.

### Common Table Expression (CTE)

- Utilize a CTE to calculate the percentage of the population vaccinated over time.

### Temporary Table

- Use a temporary table to store data on the percentage of the population vaccinated.

### Creating a View

- Create a view named `PercentPopulationVaccinated` to store data for later visualizations.

## Visualization

The data analysis results can be visualized using various tools, and the views and temporary tables created can serve as a foundation for creating insightful visualizations.

Feel free to explore and adapt these queries for your own analysis or visualization needs. If you have any questions or suggestions, please feel free to reach out.

Happy coding!
