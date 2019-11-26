# Compinion Script

The script countFeat.py is written with the project structure from the vault in mind. All paths are hard-coded according to the file hierarchy of the vault project.

To run the script from the command line use python3.x as follows:

``` 
> python3 countFeat.py "path to corpus directory"
```

The output will be structured as follows:

- results
  - other_counts
  - socal_counts
    - invariant
    - variant
  - total_counts
    - other
    - socal

#### Folder Content

- other_counts will contain 3 .csv files for adverbials, connectives and modals with separate counts for each word per file.
- socal_counts/invariant will contain files for positive and negative adverbs with separate counts for each word per file.
- socal_counts/variant will contain files for positive and negative adjectives, nouns and verbs with separate counts for each word per file.
- total_counts/other will contain files for each type of adverbial, connective and modal feature with the sum of that feature for each file. 
- total_counts/socal will contain files for each type of positive and negative adjective, noun and verb feature with the sum of that feature for each file. 
- total_counts also contains an aggregate_totals.csv file with all the pertinent information.