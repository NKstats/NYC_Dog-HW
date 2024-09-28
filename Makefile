# Clean and preprocess data
clean_data: NYC_Dog.csv
	Rscript clean_data.R

# Find distinct rows and duplicates
distinct_rows: clean_data
	Rscript distinct_rows.R

# Plot birth years
birth_year_plot: clean_data
	Rscript birth_year_plot.R

# Filter unique dogs
unique_dogs: clean_data
	Rscript unique_dogs.R

# Find most popular dog names (runs everything before it)
most_popular_names: distinct_rows birth_year_plot unique_dogs
	Rscript most_popular_names.R

.PHONY: clean
clean:
	rm -f *.csv
