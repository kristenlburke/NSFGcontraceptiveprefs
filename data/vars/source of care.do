// USUALCAR
// USLPLACE

gen sourceofcare = .
replace sourceofcare = 0 if USUALCAR == 5 // no place you usually go when sick
replace sourceofcare = 1 if USLPLACE == 1 // private doc
replace sourceofcare = 2 if USLPLACE == 3 | USLPLACE == 10 // family planning or STD clinic
replace sourceofcare = 3 if USLPLACE == 2 | USLPLACE == 5 // community or school-based clinic
replace sourceofcare = 4 if USLPLACE == 7 // ER
replace sourceofcare = 5 if USLPLACE == 6 | USLPLACE == 8 | USLPLACE == 9 // hospital outpatient or urgent care
replace sourceofcare = 6 if USLPLACE == 4 | USLPLACE == 11 | USLPLACE == 20 | USLPLACE == 99 // other/dk

label define sourceofcare 0 "None" 1 "Private doc" 2 "Family planning/STD clinic" 3 "Community or school-based" 4 "ER" ///
						  5 "Hospital outpatient or urgent care" 6 "Other/dk"
label values sourceofcare sourceofcare						  

gen sourceofcarecat3 = .
replace sourceofcarecat3 = 0 if USUALCAR == 5 // none
replace sourceofcarecat3 = 1 if USLPLACE == 1 // private doc
replace sourceofcarecat3 = 2 if USLPLACE != 1 & USUALCAR != 5 & USLPLACE != 99 & USLPLACE != . // does have a usual place, it isn't a private doc, isn't dk or missing

label define sourceofcarecat3 0 "None" 1 "Private doctor" 2 "Other facility"
label values sourceofcarecat3 sourceofcarecat3
