## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE)
library(dplyr)
library(PUMSutils)

## ----gold, echo=FALSE----------------------------------------------------
# Ground truth for Washington State
wa.gold[c(1, 7),]

## ----noPUMSutils---------------------------------------------------------
# Sum the weights to estimate a count
sum(wa.house$WGTP)

## ----estimate------------------------------------------------------------
estimate(wa.house)

## ----se------------------------------------------------------------------
se.estimate(wa.house)

## ----rentals-------------------------------------------------------------
estimate(filter(wa.house, TEN==3))

## ----se.rentals----------------------------------------------------------
se.estimate(filter(wa.house, TEN==3))

## ----prop----------------------------------------------------------------
proportion(filter(wa.house, TEN==3), wa.house)

## ----se.prop-------------------------------------------------------------
se.proportion(filter(wa.house, TEN==3), wa.house)

## ----table---------------------------------------------------------------
acs.table(wa.house, 'TEN')

