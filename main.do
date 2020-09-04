************************************
** NSFG Contraceptive Preferences **
************************************

/* Written by: Kristen Burke
 * Date started: September 11, 2019
 * Objectives: Identify who, among NSFG respondents, is not using their
			   preferred method of contraception due to cost, and associated predictors 
			   
 * This code corresponds to a brief research article published in Contraception X, 
   Burke, Kristen Lagasse, Joseph E. Potter, and Kari White. 
   "Unsatisfied contraceptive preferences due to cost among women in the United States." 
   Contraception: X (2020): 100032.
   
 * Code is archived on Github: https://github.austin.utexas.edu/klb4637/NSFG-prefs.git */
   
			   

/* Table of Contents: 
 * 1) Run setup files
 * 2) Read in raw data
 * 3) Keep and recode necessary variables
 * 4) Save recoded data
 * 5) Generate and save analytic data
 * 6) Analysis
*/
 
clear all
set more off
set linesize 80

************************
** 1) Run setup files **
************************

// This file identifies appropriate directories, stores them as global macros.
do "setup_NSFGprefs"
  
**********************
** 2) Read Raw Data **
**********************

use "$NSFG1517", clear

*************************************
** 3) Keep & recode necessary vars **
*************************************

do "data/vars"

do "data/inclusion criteria"

**************************
** 4) Save recoded data **
**************************

// keep relevant data
// do "data/varkeep"

save "$NSFGKeep/NSFGprefs_recoded.dta", replace

****************************************
** 5) Generate and save analytic data **
****************************************

// This step includes a listwise deletion of all cases
// missing on any varaible used in analysis.

do "data/analytic data"

*****************
** 5) Analysis **
*****************

do "analysis/descriptive"

// Uncomment for model building/fitting script
// do "analysis/logit_modelbuild"
// Uncomment for logit script
// do "analysis/logit" 

// In the final analysis, we used Poission regression per KW's suggestion
// because the outcome was relatively common (>10%); see also Zou G. A modified poisson 
// regression approach to prospective studies with binary data. 
// Am J Epidemiol. 2004;159(7):702-706. These results are reported
// in the manuscript
do "analysis/possion.do"

