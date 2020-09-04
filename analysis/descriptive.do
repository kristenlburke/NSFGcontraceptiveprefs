// read in recoded data
use "$NSFGKeep/NSFGprefs_analytic.dta", clear

// svyset the data
svyset SECU [pweight = WGT2015_2017], strata(SEST)

// Note: use subpop command to restrict data when doing 

local vars HISPRACE HISPRACE2 BRNOUT /// 
		   insurancecat3 ///
		   agecat6 agecat3 /// 
		   parity paritydummy paritytime ///
		   marstat ///
		   fplcat4 PUBASSIS ///
		   educat4 EDUCMOM ///
		   CONSTAT1 cpmethod cpcollapsed ///
		   sourceofcare ///
		   RHADSEX SEX3MO ///
		   METRO ///
		   wantmore intendmore ///
		   methodtime4

// weighted tab with both inclusion criteria
foreach var in `vars' {
	svy, subpop(if includedsex3mo == 1): tab `var', col
	svy, subpop(if includedsex3mo == 1): tab `var' preferanotherdummy, row
}

******************************************************
** EXPORT DESCRIPTIVE TABS for includedsex3mo  == 1 **
******************************************************

local vars cpcollapsednone HISPRACE insurancecat3 agecat3 fplcat4 METRO
foreach var in `vars' {
	svy, subpop(if includedsex3mo == 1): tab `var', col
	svy, subpop(if includedsex3mo == 1): tab `var' preferanotherdummy, row
}

** Export for includedsex3mo == 1
/// weighted percents - row %
tabout 	`vars' if includedsex3mo == 1 ///
	   using "$results/descriptives_oneway_includedsex3mo.xls", cells(col) percent oneway svy f(2) replace

// unweighted counts
tabout `vars' if includedsex3mo == 1 ///
	   using "$results/descriptives_oneway_unweighted_includedsex3mo.xls", oneway replace	   

// xtab spreadsheet of characteristics x preference
// ROW %s
tabout cpcollapsednone preferanotherdummy if includedsex3mo == 1 ///
	   using "$results/descriptives_includedsex3mo.xls", svy f(2) percent cells(row) replace
// Append for the rest of the vars in the analysis
local vars HISPRACE insurancecat3 agecat3 fplcat4 METRO
foreach var in `vars' {
	tabout `var' preferanotherdummy if includedsex3mo == 1  ///
		   using "$results/descriptives_includedsex3mo.xls", svy f(2) percent cells(row) append
}

// chi2 for tabs across preferred method
local vars cpcollapsednone HISPRACE insurancecat3 agecat3 fplcat4 METRO
foreach var in `vars' {
	svy, subpop(if includedsex3mo == 1): tab `var' preferanotherdummy, row pearson
}
