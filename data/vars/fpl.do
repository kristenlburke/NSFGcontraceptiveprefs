// Recode and categories % of FPL

// POVERTY - NSFG generated variabel that expresses HH poverty as % of FPL

// Four category variable
gen fplcat4 = .
replace fplcat4 = 1 if POVERTY < 100
replace fplcat4 = 2 if POVERTY >= 100 & POVERTY < 200
replace fplcat4 = 3 if POVERTY >= 200 & POVERTY < 300
replace fplcat4 = 4 if POVERTY >= 300 & POVERTY < .

label define fplcat4 1 "< 100%" 2 "100-199%" 3 "200-299%" 4 "300+%"
label values fplcat4 fplcat4

// Three category variable
gen fplcat3 = .
replace fplcat3 = 1 if POVERTY < 100
replace fplcat3 = 2 if POVERTY >= 100 & POVERTY < 250
replace fplcat3 = 3 if POVERTY >= 250 & POVERTY < .
label define fplcat3 1 "< 100%" 2 "100-249%" 3 "250+"
