library(tidyverse)
library(googlesheets4)
library(ggmap)

# You will need a Google API key to run this code.
# You can tell if you do if running this:
# has_google_key()
# evalutes to `TRUE`

getOption("ggmap")

df <- read_sheet("https://docs.google.com/spreadsheets/d/1XZ6n-2_RhQnu_ZwuUSUIhLIezA5y0J9MTPd0qJ1Alc0")

locs <- df %>%
  select(city) %>%
  distinct() %>%
  mutate_geocode(location = city, output = "latlon")

df <- left_join(df, locs)

sheets_write(df, ss = "https://docs.google.com/spreadsheets/d/1XZ6n-2_RhQnu_ZwuUSUIhLIezA5y0J9MTPd0qJ1Alc0", sheet = "full")
