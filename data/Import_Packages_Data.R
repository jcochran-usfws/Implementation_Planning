
### -- Package Install and Data Import -- ###

## Install and load packages

# Create vector of packages

requiredPackages <- c("knitr", "tidyverse", "lubridate", "maps", "magrittr", "argosfilter", "here", "readr", "readxl", "janitor", "sf", "ggrepel", "ggspatial", "english", "kableExtra")

options(knitr.kable.NA = '')

# Function to install and load any packages not installed

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# Load packages

ipak(requiredPackages)

### Data and File Import

IP <- read.csv(here("data", "projected_effort.csv"), header=T) %>%  # Reads in the .CSV file from the folder path, change csv to update report
  mutate(., Priority = factor(Priority, levels = c("High", "Moderate", "Low")))

metaB <- read.csv(here("data", "metaB_effort.csv"), header=T)