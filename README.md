# What is discriminatory machine learning

Discriminatory machine learning focuses on the challenges relating to the machine learning (through data) discriminatory aspects.
It can take place through using variables that are considered discriminatory (e.g. sex, race) or correlated with them (e.g. neighbourhood).

This repository relates to a course in [Aalto University](https://sites.google.com/site/zliobaite/HIIT_discrimination.pdf?attredirects=0) focused on these challenges, and demonstrates two approaches to manage discremination.

# What has been done?

I explore the relationship of household income to being an immigrant (that is, born in other country than currently living).
I used European value survey data to condcuct my analysis, comparing two methods.
The data can be obtained from [Genis](http://www.gesis.org/en/services/data-analysis/survey-data/european-values-study/), free of charge for academic purposes.

## What methods were chosen for comparison?

* [Pope & Sydnor (2011)](https://www.aeaweb.org/articles.php?doi=10.1257/pol.3.3.206) propose fixing the nature of discrimination using a linear regression model and using variable replace for these variables.
* [Caldres & Verwer (2010)](http://link.springer.com/article/10.1007/s10618-010-0190-x) propose teaching different predictive models based on the discriminatory variables.

## What were the variables used?

* Household income (fixed on country level, v353M_ppp)
* Immigrant status by the responder and his/her partner
* Combined level of education
* If the household has children
* The left-right leaning of the responder

## How was discremination measured

We confirmed that there existed differences on household income based on the immigration status by comparing the household income in households with no immigrants and households of 1 or 2 immigrants.

## What was observed

1. On the raw data, there is clear statistical difference on household income, indicating discrimination
1. Pope & Sydnor method was able to reduce the impact of the discrimination but not remove it.
1. The Caldres & Verwer method was not able to reduce discrimination.

