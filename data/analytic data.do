use "$NSFGKeep/NSFGprefs_recoded.dta", clear

** TODO: only listwise vars that need to be in models.
local vars  preferanotherdummy ///
			cpcollapsednone ///
			HISPRACE ///
			insurancecat3 ///
			agecat3 ///
			fplcat4 ///
			METRO
			
// initialize a variable for listwise deletion of cases that are missing on 
// covariates
gen listwisedel = .
			
// unweighted tab with inclusion variables to see how many are missing		   
foreach var in `vars' {
	tab `var' if includedsex3mo == 1, m
	
	// replace flags for listwise deletion
	replace listwisedel = 1 if includedsex3mo == 1 & `var' == .
}	

tab listwisedel includedsex3mo

// LISTWISE DELETION for all cases that are missing any covariate among included == 1
replace includedsex3mo = 0 if listwisedel == 1

save "$NSFGKeep/NSFGprefs_analytic.dta", replace
