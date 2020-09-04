// Recode of education

tab HIEDUC

gen educat4 = . 
replace educat4 = 1 if HIEDUC > 0 & HIEDUC <= 8 & HIEDUC < . // LT HS
replace educat4 = 2 if HIEDUC == 9  						 // HS
replace educat4 = 3 if HIEDUC == 10 | HIEDUC == 11			 // Some college, associates
replace educat4 = 4 if HIEDUC > 11 & HIEDUC < . 			 // Bachelor's degree or more 

label define educat4 1 "LTHS" 2 "HS grad" 3 "Some college/AA" 4 "Bachelors+"
label values educat4 educat4
