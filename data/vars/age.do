// Recategorize age

// 6 categories
gen agecat6 = .
replace agecat6 = 1 if AGER >= 15 & AGER < 20
replace agecat6 = 2 if AGER >= 20 & AGER < 25
replace agecat6 = 3 if AGER >= 25 & AGER < 30
replace agecat6 = 4 if AGER >= 30 & AGER < 35
replace agecat6 = 5 if AGER >= 35 & AGER < 40
replace agecat6 = 6 if AGER >= 40 & AGER < 45

label define agecat6 1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44"
label values agecat6 agecat6


// 3 categories -- used in final analysis
gen agecat3 = .
replace agecat3 = 1 if AGER >= 15 & AGER < 25
replace agecat3 = 2 if AGER >= 25 & AGER < 35
replace agecat3 = 3 if AGER >= 35 & AGER < 45

label define agecat3 1 "15-24" 2 "25-34" 3 "35-44"
label values agecat3 agecat3

// 4 cagegories
gen agecat4 = .
replace agecat4 = 1 if AGER >= 15 & AGER < 20
replace agecat4 = 2 if AGER >= 20 & AGER < 30
replace agecat4 = 3 if AGER >= 30 & AGER < 40
replace agecat4 = 4 if AGER >= 40 & AGER < 45
label define agecat4 1 "15-24" 2 "20-29" 3 "30-39" 4 "40-44"
label values agecat4 agecat4
