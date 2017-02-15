## PUMSutils

### ACS PUMS Data

The American Community Survey (ACS) is an annual survey conducted by the U.S. Census Bureau, covering many of the same topics as the decennial census. It is a 1% sample, and it comes in 2 parts: a housing survey of household units and a population survey of people. ACS data is available in several forms. Online, you can get custom tables from [American FactFinder](https://factfinder.census.gov/faces/nav/jsf/pages/searchresults.xhtml?refresh=t). Microdata is available through the Public Use Microdata Sample, or PUMS. This contains actual responses to the ACS, one per row. This allows essentially any query to be formed, not just those provided by AFF. However, the data is harder to work with, since every query requires doing tabulation. 

The `PUMSutils` package reduces the required tabulation to function calls. 
It has functions for computing estimates and standard errors for counts, proportions, and means, as well as computing tables and point estimates for medians and quantiles.

### Usage

The `PUMSutils` package includes a sample data set called `wa.house`. 
Its documentation is available in R with `?wa.house`.
We compute some statistics about Washington State rental housing using this data and the functions in `PUMSutils` below.
    
To get an estimate of a count or total:

```
rentals <- subset(wa.house, TEN==3)       # Occupied rentals
estimate(rentals)
```

To get a standard error of that:

```
se.estimate(rentals)
```

To get a rental vacancy rate for Washington State:

```
all.rentals <- subset(wa.house, TEN==3 | VACS==1)    # Occupied or vacant rentals
vacant <- subset(wa.house, VACS==1)              # For rent
proportion(vacant, all.rentals)
```

And the standard error for that is:

```
se.proportion(vacant, all.rentals)
```

For other functions, see the package docs.

### References

See the [PUMS data dictionary](http://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMSDataDict15.txt) for field definitions.

The [ACS PUMS technical documentation page](http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html) has more information about using the expansion weights.

### Contributing

Feel free to raise an issue if you find a bug, or have a feature request.
Ppull requests are also welcome if you fix a bug or have new functionality that you think should be included.
