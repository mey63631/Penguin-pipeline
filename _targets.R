library(targets)
library(tarchetypes)
library(dplyr)
library(palmerpenguins)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(data_summary) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.

tar_option_set(packages = c("dplyr", "broom", "palmerpenguins"))

list(
  tar_target(raw_data, penguins),
  
  tar_target(clean_data, raw_data |> 
               filter(!is.na(body_mass_g)) |> 
               mutate(species = as.factor(species))),
  
  tar_target(adelie_data, filter(clean_data, species == "Adelie")),
  tar_target(chinstrap_data, filter(clean_data, species == "Chinstrap")),
  tar_target(gentoo_data, filter(clean_data, species == "Gentoo")),
  
  tar_target(adelie_model, lm(body_mass_g ~ bill_length_mm, data = adelie_data)),
 # tar_target(chinstrap_model, lm(body_mass_g ~ bill_length_mm, data = chinstrap_data)),
 # tar_target(gentoo_model, lm(body_mass_g ~ bill_length_mm, data = gentoo_data)),

 tar_group_by(
   grouped_data, 
   clean_data, species),
 
 tar_target(
   models,
   list(lm(body_mass_g ~ bill_length_mm, data = grouped_data)), 
   pattern = map(grouped_data)
 )
)
 
 
# Set target-specific options such as packages:
# tar_option_set(packages = "utils") # nolint

# End this file with a list of target objects.


tar_target(
  reporting_tables,
  < >,
  pattern = < >,
  iteration = < >
)



