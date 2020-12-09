// read in recoded data
use "$NSFGKeep/NSFGprefs_analytic.dta", clear

// svyset the data
svyset SECU [pweight = WGT2015_2017], strata(SEST)

// test association between all potential variables of interest
// and assess F statistic for significant relationship
local vars b2.HISPRACE 			/// ref - white  	- SIG
		   b2.HISPRACE2 		/// ref - white  	- SIG
		   b5.BRNOUT 			/// ref - us born	- SIG
		   insurancecat3 		/// ref - private	- SIG
		   agecat6 				/// ref - youngest 	- SIG, but less
		   agecat3 				/// ref - youngest	- SIG - more
		   parity 				/// ref - 0			- marginally SIG
		   paritydummy 			/// ref - 0			- NS
		   paritytime 			/// ref - 0			- NS
		   b3.marstat 			/// ref - single	- SIG
		   fplcat4 				/// ref - lt 100	- SIG
		   b2.PUBASSIS 			/// ref - no		- NS
		   educat4 				/// ref - lths		- SIG
		   EDUCMOM 				/// ref - lths		- NS
		   b5.cpcollapsed 		/// ref - pill		- SIG
		   sourceofcare  		/// ref - none		- SIG	
		   sourceofcarecat3 	/// ref - none		- SIG
		   b3.METRO 				/// ref - metro		- SIG
		   wantmore 			/// ref - no		- marginally sig
		   intendmore			///  ref - no		- NS
		   methodtime4
			
foreach var in `vars' {
	svy, subpop(if includedsex3mo == 1): poisson preferanotherdummy i.`var'
}


** FINAL MODEL **
poisson preferanotherdummy i.b5.cpcollapsednone i.b2.HISPRACE i.insurancecat3 i.agecat3 i.b4.fplcat4 if includedsex3mo == 1, irr
svy, subpop(if includedsex3mo == 1): poisson preferanotherdummy i.b5.cpcollapsednone i.b2.HISPRACE i.insurancecat3 i.agecat3 i.b4.fplcat4, irr


** EXPORT RESULTS **
// keep if includedsex3mo == 1 - if we drop the includedsex3mo, i'm not detecting any changes in CIs or SEs
// Begin export w/ a "replace" at end of outreg command

svy, subpop(if includedsex3mo == 1): poisson preferanotherdummy i.b5.cpcollapsednone, irr
outreg2 using "$results/poisson_includedsex3mo_nometro.xls", sideway stats(coef ci) alpha(0.001, 0.01, 0.05) dec(2) label eform replace 

// run over the rest of the predictor variables with an append command -- this will give bivariate ORs
local poissonvars i.b2.HISPRACE i.insurancecat3 i.agecat3 i.b4.fplcat4		
foreach var in `poissonvars' {		   
	svy, subpop(if includedsex3mo == 1): poisson preferanotherdummy `var', irr
	outreg2 using "$results/poisson_includedsex3mo_nometro.xls", sideway stats(coef ci) alpha(0.001, 0.01, 0.05) dec(2)  label eform append 
}		   

// for all variables-- AORs
svy, subpop(if includedsex3mo == 1): poisson preferanotherdummy i.b5.cpcollapsednone `poissonvars', irr
outreg2 using "$results/poisson_includedsex3mo_nometro.xls", sideway stats(coef ci) alpha(0.001, 0.01, 0.05) dec(2) label eform append 
