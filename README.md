## PUMSutils

### ACS PUMS Data

The American Community Survey (ACS) is an annual survey conducted by the U.S. Census Bureau, covering many of the same topics as the decennial census. It is a 1% sample, and it comes in 2 parts: a housing survey of household units and a population survey of people. ACS data is available in several forms. Online, you can get custom tables from [American FactFinder](https://factfinder.census.gov/faces/nav/jsf/pages/searchresults.xhtml?refresh=t). Microdata is available through the Public Use Microdata Sample, or PUMS. This contains actual responses to the ACS, one per row. This allows essentially any query to be formed, not just those provided by AFF. However, the data is harder to work with, since every query requires doing tabulation. 

The `PUMSutils` package reduces the required tabulation to function calls. 
It has functions for computing estimates and standard errors for counts, proportions, and means, as well as computing tables and point estimates for medians and quantiles.

### Usage

The `PUMSutils` package includes a sample data set called `wa.house`. 
Its documentation is available in R. With the package loaded, use `?wa.house`.
We compute some statistics about Washington State rental housing using this data and the functions in `PUMSutils` below.
    
To get an estimate of a count or total:

```
rentals <- subset(wa.house, TEN==3)
estimate(rentals)
```

To get a standard error of that:

```
se.estimate(rentals)
```

### Contributing

Feel free to raise an issue if you find a bug, or a feature request.
You are also welcome to raise a pull request if you fix a bug or have new functionality that you think should be included.

