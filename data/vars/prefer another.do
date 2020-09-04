// Prefer another method of contraception
// Primary outcome: if you didn't have to worry about cost, would you want to use a different method?

// NOCOST1 - If you did not have to worry about cost and could use any type of contraceptive method available, would you want to use a different method?
//			 Applicable if R used any method in the current or previous month (any of currmeth1 - currmeth4 or lstmonmeth1 - lstmonmeth4 = 3 - 26)
// NOCOST2 - If you did not have to worry about cost and could use any type of contraceptive method available, would you want to use a method?
//			 Applicable if R used no method in current and previous month or has never used a method ((currmeth1 = 1 and lstmonmeth1 = 1) or everused = 5)


// collapsing nocost1 and nocost2 into one variable
gen preferanother = .
replace preferanother = NOCOST1													// a different method, among those using amethod
replace preferanother = NOCOST2 if preferanother == .							// a method, among those not contracepting
// NSFG has 5 == no; recode that to 2
replace preferanother = 2 if preferanother == 5
// Collapse refused and "don't know"
replace preferanother = 3 if preferanother == 8 | preferanother == 9

label define preferanother 1 "Yes" 2 "No" 3 "DK/refused"
label values preferanother preferanother


// gen a dummy; will be the primary outcome in analyses
// Don't know/refused dropped through the creation of this variable
gen preferanotherdummy = .
replace preferanotherdummy = 1 if preferanother == 1
replace preferanotherdummy = 0 if preferanother == 2 
