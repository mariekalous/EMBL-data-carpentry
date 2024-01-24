library(tidyverse)

surveys <- read_csv("data_raw/portal_data_joined.csv")
str(surveys)
view(surveys)

select(surveys, plot_id, species_id, weight) #select some columns

select(surveys, -record_id, -species_id) #selects all columns without the specified two
filter (surveys, year == 1995) #filters all entries with year 1995

filter (surveys, year == 1995, sex == "M")

surveys2 <- filter(surveys, weight < 5) #filters individuals with weigth less than 5
surveys_sml <- select(surveys2, species_id, sex, weight) #takes the filtered table and selects only the three specified columns

surveys_sml2 <- select(filter(surveys, weight < 5), species_id, sex, weight)

# %>%  pipe takes the things on the left and applies the function on the right of the pipe
surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight) #this filters inds with weight less than 5 and keeps only the specified columns

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight) #this filters inds sampled before 1995 and retains only columns year, sex and weight

surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  View() #this adds another column name weight_kg with the value of weight/1000 --- mutate() creates new columns that are functions of existing variables. 

surveys %>% 
  filter(!is.na(weight)) %>%  #this filters everything except for missing data (means it removes missing data)
  mutate(weight_kg = weight/1000) %>%
  head

# split-apply-combine paradigm
surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) #this makes three groups of the individuals based on sex (F, M, NA) and calculates mean weight for each group using the "mean" function, while removing missing data for weight

surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T)) %>% 
  tail()#this will summarize groups of species and calculate mean weight for each species, while removing missing data

surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T)) %>%
  print(n = 15) #this will do the same and print the first 15 lines at the end

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T), min_weight = min(weight)) %>%
  arrange(min_weight) #filters out missing data for sex and weight, groups by sex and species, calculates mean and minimum weight for each group and orders the data in ascending order by min weight

surveys %>% 
  count(sex, species) %>%  #counts number of rows for each group
  arrange (species, desc(n)) #arranges the species in descending order of number of inds for sex

surveys %>% 
  count(plot_type) #how many animals were caught in each plot type?

summ_hindfoot <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(mean_hindfootlength = mean(hindfoot_length), 
            min_hindfootlength = min(hindfoot_length), 
            max_hindfootlength = max(hindfoot_length),
            n = n()) %>% 
  
  
View("summ_hindfoot") #calculated mean, min and max of hindfoot length per species and returns number of inds for each species



surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% #we want to see the heaviest individuals for each year
  select(year, genus, species_id, weight) %>% #we want to retain only certain columns
  arrange(year) %>% 
  print(n = 27)


surveys_gw %>% 
  pivot_wider(names_from = genus, 
              values_from = mean_weight, 
              values_fill = 0) #this creates a wide table with plot id as rows and genera as columns and mean weight as values, with 0 replacing NAs (values_fill)


surveys_wide <- surveys_gw %>% 
  pivot_wider(names_from = genus, values_from = mean_weight, values_fill = 0)

surveys_long <- surveys_wide %>% 
  pivot_longer(names_to = "genus", values_to = "mean_weight", cols = -plot_id)


surveys_long <- surveys %>% 
  pivot_longer(names_to = "measurement", values_to = "value", cols = c(hindfoot_length, weight)) %>% 
  View()

surveys_long %>%
  group_by(year, measurement, plot_type) %>%
  summarise(mean_value = mean(value, na.rm = T)) %>% 
  pivot_wider(names_from = measurement, values_from = mean_value)

surveys_complete <- surveys %>% 
  filter(!is.na(weight),
         !is.na(hindfoot_length),
         !is.na(sex))
 write_csv(surveys_complete, file = "data_raw/surveys_complete.csv")





