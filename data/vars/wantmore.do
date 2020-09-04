fre RWANT
fre PROBWANT

gen wantmore = .
replace wantmore = 0 if RWANT == 5 // no
replace wantmore = 1 if RWANT == 1 // yes
replace wantmore = 0 if PROBWANT == 2 // prob no
replace wantmore = 1 if PROBWANT == 1 // prob yes

// leaves 33 don't knows


// there is also an "intent" variable,
// which might be worthwhile to test against the "want"
fre INTENT

gen intendmore = .
replace intendmore = 0 if INTENT == 2 // no
replace intendmore = 1 if INTENT == 1 // yes

// ~70 don't knows
