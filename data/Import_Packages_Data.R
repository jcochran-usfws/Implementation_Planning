
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

IP <- read_excel("../data/projected_effort.xlsx", sheet = 1) %>% 
  mutate(., Priority = factor(Priority, levels = c("High", "Moderate", "Low"))) %>% 
  mutate(., Basin = factor(Basin, levels = c("Lake Erie", "Lake Ontario")))

metaB <- read_excel("../data/metaB_effort.xlsx", sheet = 1) %>%  
  mutate(., Priority = factor(Priority, levels = c("High", "Moderate", "Low"))) %>% 
  mutate(., Basin = factor(Basin, levels = c("Lake Erie", "Lake Ontario")))

Lake_sf <- st_read(here("shapefiles/GL_Outline", "glgis_gl_shore_noaa_70k.shp"))
cropped <- st_crop(Lake_sf, xmin = -73, xmax = -81,
                   ymin = 41.5, ymax = 45.4)
NY_sf <- st_read(here("shapefiles/NYS_Civil_Boundaries.shp/NYS_Civil_Boundaries_SHP",  "State_Shoreline.shp"))

US_sf <- st_read(here("shapefiles/States_shapefile", "States_shapefile.shp")) %>% 
  filter(State_Code %in% c('PA'))
#US_cropped <- st_crop(US_sf, xmin = -73, xmax = -81, ymin = 41.5, ymax = 45.4)
