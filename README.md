# Oklahoma Death Penalty Tracker

An interactive tool tracking Oklahoma death penalty cases since executions resumed in October 2021.

## View Live Tracker

🔗 **[View the live tracker](https://openjusticeok.github.io/death-row-tracker/)**

## About

This tracker displays:
- Interactive map of cases by county
- Comprehensive case details and status updates
- Execution schedules and legal developments

Data is compiled and maintained by the [Oklahoma Policy Institute](https://okpolicy.org/).

## Development

Built with [R](https://r-project.org/) and [Quarto](https://quarto.org/). 

To run locally:
```bash
# Install R and Quarto
# Clone repository
# Restore R environment
Rscript -e "renv::restore()"
# Render document
quarto render death-row-tracker.qmd
```
