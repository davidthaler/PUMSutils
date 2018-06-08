## PUMSutils

### ACS PUMS Data

The American Community Survey (ACS) is an annual survey conducted by the U.S. Census Bureau, covering many of the same topics as the decennial census. It is a 1% sample, and it comes in 2 parts: a housing survey of household units and a population survey of people. ACS data is available in several forms. Online, you can get tabulated results from [American FactFinder](https://factfinder.census.gov/faces/nav/jsf/pages/searchresults.xhtml?refresh=t), or look at [censusreporter.org](https://censusreporter.org/) for a friendlier web interface. Microdata is available through the Public Use Microdata Sample, or PUMS. This contains actual responses to the ACS, one per row. This allows essentially any query to be formed, not just those provided by AFF. However, the data is harder to work with, since every query requires doing tabulation. 

The most important thing to know about the ACS PUMS data is that it is a *weighted* sample. Each row has an expansion weight indicating the number of households or people represented by this row. This complicates estimation, especially of standard errors. The `PUMSutils` package reduces the required computation to function calls. It has functions for computing estimates and standard errors for counts, proportions, and means, as well as computing tables and point estimates for medians and quantiles. It also contains utility functions for loading PUMS datasets, renaming the numerous integer-coded categorical variables in the PUMS data, and other common operations on this dataset.

### Usage

The `PUMSutils` package includes a sample data set called `wa.house16`. 
Its documentation is available in R with `?wa.house16`.
We compute some example statistics about Washington State housing using this data and the functions in `PUMSutils` below.

Compute counts, standard errors and 90% margin-of-error for rented, owned and vacant housing in Washington State, renaming the integer coded categorical variable `TEN`:

    wa.house16$Tenure <- acs.translate(wa.house16, 'TEN', c(1:4, NA), c('own', 'own', 'rent', 'rent', 'vacant'))    
    acs.group.estimate(wa.house16, 'Tenure')

In the PUMS data, the variable `TEN` denotes housing tenure. It is an integer-coded categorical variable. It has the levels: 1 = Owned with mortgage, 2 = Owned free and clear, 3 = Rented for cash, 4 = Occupied without rent, NA = Vacant. This description can be found at the [technical documentation](https://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html) page for the ACS. The technical documentation page also has ground-truth values for these calculations. A portion of that data, for the 2016 ACS housing data for Washington, is included in this package as `wa.gold16`. The example above corresponds to rows 1, 3, 4, and 9 in `wa.gold16`.

For other functions, see the package docs.

### Installation

This package can be installed from github using devtools:    

```
devtools::install_github('davidthaler/PUMSutils')
```

### References

See the [PUMS data dictionary](http://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMSDataDict16.txt) for field definitions.

The [ACS PUMS technical documentation page](http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html) has more information about using the expansion weights.

### Contributing

Feel free to raise an issue if you find a bug, or have a feature request.
Pull requests are also welcome if you fix a bug or have new functionality that you think should be included.
