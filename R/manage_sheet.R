library(tidyverse)
library(googlesheets4)
library(ggmap)

# You will need a Google API key to run this code.
# You can tell if you do if running this:
# has_google_key()
# evalutes to `TRUE`

getOption("ggmap")

df <- read_sheet("https://docs.google.com/spreadsheets/d/1XZ6n-2_RhQnu_ZwuUSUIhLIezA5y0J9MTPd0qJ1Alc0/edit#gid=0")

locs <- df %>%
  filter(is.na(x)) %>%
  select(city) %>%
  distinct() %>%
  mutate_geocode(location = city, output = "latlon")

