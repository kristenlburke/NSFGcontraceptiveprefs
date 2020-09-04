// Parity

// A note on why some women are coded as postpartum in CONSTAT when their most recent birth
// was a very long time ago OR they have no babies??
// Only people with 0-1 births should be in the postpartum period according to the NSFG (postpartum
// coded as within 2 months). Can go up to 1 in case someone is interviewed in Jan 2016 but gave birth
// in late 2015-- because we don't have CM, we don't know that the time period is actually quite small.

// recode parity
gen parity = .
replace parity = 0 if PARITY == 0
replace parity = 1 if PARITY == 1
replace parity = 2 if PARITY == 2
replace parity = 3 if PARITY >= 3 & PARITY < .
label define parity 0 "0" 1 "1" 2 "2" 3 "3+"
label values parity parity

// dummy of whether or not r has children
gen paritydummy = .
replace paritydummy = 0 if parity == 0
replace paritydummy = 1 if parity > 0 & parity < .

// Generate a "parity * time" variable, which incorporates whether a woman has had
// a birth and how long it has been since her last birth
// Categories: 
// parity 0,
// then broken apart as time since last birth
// 0-2 yrs
// 2-5 yrs
// 5+ yrs

// First, identify date of last birth
// note that in the 2017 NSFG they don't have CM of birth, just year.

// there are 4 respondents who we don't have a date from their most recent pregnancy
list PARITY NUMPREGS DATEND* if CMLASTLB == 9998
// their dates of most recent birth are imputed. Given that there are only 4, 
// going to code their dates of most recent birth to the imputed value
gen yrlastbirth = CMLASTLB
forvalues i = 1/4 {
	replace yrlastbirth = DATEND0`i' if PARITY == `i' & CMLASTLB == 9998
}

// convert CMINTVW into YEAR to be compatible with CMLASTLB
gen interviewyear = .
replace interviewyear = floor(1900 + ((CMINTVW - 1)/12))

gen yrssincelastbirth = .
replace yrssincelastbirth = interviewyear - yrlastbirth

// Gen parity*time variable
gen paritytime = .
replace paritytime = 0 if PARITY == 0
replace paritytime = 1 if PARITY > 0 & yrssincelastbirth >= 0 & yrssincelastbirth < 2
replace paritytime = 2 if PARITY > 0 & yrssincelastbirth >= 2 & yrssincelastbirth < 5
replace paritytime = 3 if PARITY > 0 & yrssincelastbirth >= 5 & yrssincelastbirth < .

label define paritytime 0 "Nulliparous" 1 "Parous, <2 yrs since last" 2 "Parous, >= 2 & <5 yrs since last" ///
						3 "Parous, >=5 yrs since last"
label values paritytime paritytime						
