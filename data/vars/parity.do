// Parity

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
