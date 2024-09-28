
# Step 1: Clean and preprocess data
clean_data: NYC_Dog.csv
	Rscript clean_data.R

# Step 2: Find distinct rows and duplicates
distinct_rows: clean_data
	Rscript distinct_rows.R

# Step 3: Plot birth years
birth_year_plot: clean_data
	Rscript birth_year_plot.R

# Step 4: Filter unique dogs
unique_dogs: distinct_rows birth_year_plot
	Rscript unique_dogs.R

# Step 5: Find most popular dog names (runs everything before it)
most_popular_names: unique_dogs
	Rscript most_popular_names.R

clean:
	rm -f *.csv
