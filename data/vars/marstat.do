// Reocdes of marital status at time of interview

gen marstat = .
replace marstat = 1 if RMARITAL == 1
replace marstat = 2 if RMARITAL == 2
replace marstat = 3 if RMARITAL != 1 & RMARITAL != 2 & RMARITAL != .

label define marstat 1 "Married" 2 "Cohabiting" 3 "Neither cohabiting or married"
label values marstat marstat
