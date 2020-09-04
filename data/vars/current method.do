// recode current method to collapse
// Qs: collapse pill patch ring? or collapse patch, ring, depo? or have patch and ring separate?

// variable of interest - CONSTAT1

// female ster (excluding non cp ster)- 1 
// male ster (excluding non cp ster) - 2 
// implant - 3
// IUD - 10
// pill 6
// patch ring 7 8 
// shot - 5
// condom - 12
// withdrawal - 21
// natural - 19 20
// other - 9 18 22
// none (includes those who never had sex) - 40 41 42
// non cp sterilized female - 33 35
// non cp sterilized male - 34 38

// First, identify those who are pregnant or trying to become pregnant
gen pregnant = .
replace pregnant = 1 if CURRPREG == 1

gen trying = .
replace trying = 1 if CONSTAT1 == 31
// "Trying" to become pregnant recoded from 2 variables. If yes to either, is
// considered "trying" to become pregnant.
// WYNOTUSE - You may have already answered a similar question, 
// 			  but is the reason you are not using a method of birth control now 
// 			  because you, yourself, want to become pregnant as soon as possible?
// HPPREGQ - And your partner, does he want you to become pregnant as soon as possible?


gen cpmethod = .
replace cpmethod = 1  if CONSTAT1 == 1  									// fem ster
replace cpmethod = 2  if CONSTAT1 == 2  									// male ster
replace cpmethod = 3  if CONSTAT1 == 3  									// implant
replace cpmethod = 4  if CONSTAT1 == 10 									// IUD
replace cpmethod = 5  if CONSTAT1 == 6  									// pill 
replace cpmethod = 6  if CONSTAT1 == 7 | CONSTAT1 == 8  					// patch ring
replace cpmethod = 7  if CONSTAT1 == 5										// shot
replace cpmethod = 8  if CONSTAT1 == 12										// Condom
replace cpmethod = 9  if CONSTAT1 == 19 | CONSTAT1 == 20					// natural
replace cpmethod = 10 if CONSTAT1 == 9  | CONSTAT1 == 18 | CONSTAT1 == 22	// ec, jelly, other
replace cpmethod = 11 if CONSTAT1 == 21										// withdrawal
replace cpmethod = 12 if CONSTAT1 == 42										// sexually active none
replace cpmethod = 13 if CONSTAT1 == 40 | CONSTAT1 == 41 					// not sexually active none
replace cpmethod = 14 if CONSTAT1 == 33 | CONSTAT1 == 35					// Fem ster for non cp reasons
replace cpmethod = 15 if CONSTAT1 == 34 | CONSTAT1 == 38					// male ster for non cp reasons
replace cpmethod = 16 if CONSTAT1 == 32										// postpartum

label define cpmethod 1 "Female sterilization" 2 "Male sterilization" 3 "Implant" 4 "IUD" ///
					  5 "Pill " 6 "Patch or ring" 7 "Injectable" 8 "Condom" 9 "Natural" ///
					  10 "Other" 11 " Withdrawal" 12 "None, sexually active" 13 "None, no sex" ///
					  14 "Female ster for non cp reasons" 15 "Male ster for non cp reasons" 16 "Postpartum within 2 mo"
label values cpmethod cpmethod

tab CONSTAT1 cpmethod, m // the only ones missing are those who are pregnant or trying; goal achieved.




gen cpcollapsed = cpmethod
replace cpcollapsed = 8  if cpmethod == 9 | cpmethod == 10 | cpmethod == 11	// collapse condom, withdrawal, natural, and other
replace cpcollapsed = 5  if cpmethod == 6 		// collapse pill patch and ring
replace cpcollapsed = . if (CONSTAT1 == 33 | CONSTAT1 == 35 | CONSTAT1 == 34 | CONSTAT1 == 38)
label define cpcollapsed 1 "Female sterilization" 2 "Male sterilization" 3 "Implant" 4 "IUD" ///
						 5 "Pill/patch/ring" 7 "Injectable" 8 "Condom/withdrawal/other" ///
						 11 "Other methods" 12 "None, sex in last 3mo" 13 "None, no sex in last 3mo" ///
						 14 "Female ster for non cp reasons" 15 "Male ster for non cp reasons" 16 "Postpartum within 2 mo"
label values cpcollapsed cpcollapsed

gen cpcollapsednone = cpcollapsed
replace cpcollapsednone = 12 if cpcollapsed == 13
replace cpcollapsednone = . if cpcollapsed == 16
label define cpcollapsednone 1 "Female sterilization" 2 "Male sterilization" 3 "Implant" 4 "IUD" ///
							 5 "Pill/patch/ring" 7 "Injectable" 8 "Condom/withdrawal" ///
							 11 "Other methods" 12 "None" ///
							 16 "Postpartum within 2 mo"
label values cpcollapsednone cpcollapsednone						 

// collapse into categories
gen cpmethodcat = .
replace cpmethodcat = 1 if cpmethod == 1 | cpmethod == 2 // ster
replace cpmethodcat = 2 if cpmethod == 3 | cpmethod == 4 // LARC
replace cpmethodcat = 3 if cpmethod == 5 | cpmethod == 6 // pill patch ring
replace cpmethodcat = 4 if cpmethod == 7 // depo
replace cpmethodcat = 5 if cpmethod == 8 // condoms
replace cpmethodcat = 6 if cpmethod == 9 | cpmethod == 10 | cpmethod == 11 // LEM - EC 
replace cpmethodcat = 7 if cpmethod == 12 // none

label define cpmethodcat 1 "Sterilization" 2 "LARC" 3 "Pill/patch/ring" 4 "Depo" 5 "Condoms" 6 "Other LEM" 7 "None"
label values cpmethodcat cpmethodcat



** DURATION OF USE **

// How long has respondent been using their current method?
// To answer this question, we have to go into the cp calendar.

// Recode each METHX`i' variable, which correspond to up to 4 methods used by women 
// in each month, to match the coding scheme of cpmethod recoded above
forvalues i = 1/192 {
	gen meth`i' = .
	replace meth`i' = 1  if METHX`i' == 6  // fem ster
	replace meth`i' = 2  if METHX`i' == 5  // male ster
	replace meth`i' = 3  if METHX`i' == 9  // implant
	replace meth`i' = 4  if METHX`i' == 19 // IUD
	replace meth`i' = 5  if METHX`i' == 3  // pill
	replace meth`i' = 6  if METHX`i' == 25 | METHX`i' == 26 // patch ring
	replace meth`i' = 7  if METHX`i' == 8  // shot
	replace meth`i' = 8  if METHX`i' == 4  // condoms
	replace meth`i' = 9  if METHX`i' == 11 | METHX`i' == 10 // natural
	replace meth`i' = 10 if METHX`i' == 20 | METHX`i' == 15 | METHX`i' == 21 // EC, jelly, other
	replace meth`i' = 11 if METHX`i' == 7  // withdrawal
	replace meth`i' = 12 if METHX`i' == 1  // none, though we don't have sexual activity here, so skip meth`i' = 13
	replace meth`i' = 14 if METHX`i' == 22 // sterile for non cp reasons
	replace meth`i' = 15 if METHX`i' == 23 // partner sterile for non cp reasons
	replace meth`i' = 99 if METHX`i' == 98 | METHX`i' == 99 // refused don't know
	
	label values meth`i' cpmethod
}

** Collapse methods within each month **
// Collapse the methods used within each month to identify the most efficactious 
// we're looping over 48 possible months of method use, which up to 4 methods reported per month
forvalues i = 1/48 {
	// Gen "topmeth`i'" var which is the most effective method used in that month; initiate as missing
	gen topmeth`i' = .
	label values topmeth`i' cpmethod
	
	// Replace it with the first method reported in that month -- this follows a different path
	// depending on whether it's the first month or a subsequent month
	
	// if mo == 1, then just use i = i (METHX1 == first method in mo 1)
	if `i' == 1 {
		replace topmeth`i' = meth`i'
		
		// if the 2nd through 4th mention of method in the first month is more effective (has a lower # value) than
		// the method stored in the previous mentions, replace the method in topmeth with that 
		// method.
		forvalues j = 2/4 {
			replace topmeth`i' = meth`j' if meth`j' < topmeth`i' & meth`j' != . & topmeth`i' != .
		}
	}
	
	// if mo > 1, then use the method that's in month * 4 + 1, e.g. the first method in the 2nd month
	// is stored in the variable METHX5, in the 3rd is METHX9
	if `i' > 1  {
		local j = ((`i' - 1) * 4) + 1
		replace topmeth`i' = meth`j'
		
		// if the 2nd through 4th mention of the method in the 2nd+ mo is more effective (has a lower # value) than
		// the method stored in the first mention, then replace the method in topmet with that method.
		
		// make k = `j', the first method for that month, + 1, 2nd method for that month
		// e.g. for 2nd month, j == 5, so k will first take the value 6
		local k = `j' + 1
		// then loop through 2/4, three digits, incrementing k by one for each loop, so that k in the 2nd month
		// is first evalued at value 6 (when l = 2), at 7 when l = 3, and at 8 when l = 4
		forvalues l = 2/4 {
			replace topmeth`i' = meth`k' if meth`k' < topmeth`i' & meth`k' != . & topmeth`i' != .
			local k = `k' + 1
		}
	}
}

** Sort out sexually active w/o method vs no sex **
// We didn't sort out whether no method was used because of lack of sexual activity
// or if sex was had but no method was used in previous loop. We'll disentangle here,
//; using corresponding month data on sexual activity

// we'll use sexual activity, which corresponds with the same 48 months
// but for some reason 1st month is missing a value after!
gen MONSX1 = MONSX
forvalues i = 1/48 {
	replace topmeth`i' = 13 if topmeth`i' == 12 & (MONSX`i' == 5 | MONSX`i' == 8 | MONSX`i' == 9)
}


// Gen variable that's counting methods backwards-- such that methlast1 == method in the 1 month prior to
// interview

// months that each month in calendar resond to
// CMMHCALX1 - CMMHCALX48
// month of interview
// CMINTVW

// Initiate methlast for values 1-48 because there are up to 48 months on which we have data on contraceptive use
// though we do not have data on all 48 months for any one respondent
forvalues i = 1/48 {
	gen methlast`i' = .
	label values methlast`i' cpmethod
	
	// We only have max 47 months of data on pepole, so loop through each of these 47 months
	forvalues j = 1/47 {
		// make the value of methlastX = topmethY if the time that elapsed between time Y and 
		// the current interview is equal to X
		// Say y = 1400 and current CM is 1409, the time elapsed is 9 months
		// We want to put the value of contraceptive method at time y into the variable methlast9
		replace methlast`i' = topmeth`j' if (CMINTVW - CMMHCALX`j' == `i') & topmeth`j' != .
	}
}

gen methlast0 = cpmethod
label values methlast0 cpmethod
// Now we want to see, for how many consecutive months was respondent's current method
// their primary method
gen cpmethodmonths = .
replace cpmethodmonths = 0 if  cpmethod != methlast1 & methlast1 != .
replace cpmethodmonths = 0 if  cpmethod != methlast1  & (methlast1 != . & methlast1 != 13) & cpmethod != . 
replace cpmethodmonths = 0 if (cpmethod != methlast2 & methlast1 == 13 & methlast2 != . & cpmethod != .) & /// 1 mo  of no sex, in methlast1
							  (cpmethod != methlast3 & methlast1 == 13 & methlast2 == 13 & methlast3 != . & cpmethod != .) & /// 2 months of no sex in methlast1 and methlast2
							  (cpmethod != methlast4 & methlast1 == 13 & methlast2 == 13 & methlast3 == 13 & methlast4 != . & cpmethod != .)
replace cpmethodmonths = 1 if (cpmethod == methlast1) | (cpmethod == methlast2 & methlast1 == 13) & cpmethod != .
forvalues i = 2/47 {
	local j = `i' - 1
	local k = `i' - 2
	local l = `i' - 3
	replace cpmethodmonths = `i' if (cpmethod == methlast`i') & (methlast`i' == methlast`j') & (cpmethodmonths == `i' - 1) & cpmethod != .
	replace cpmethodmonths = `i' if (cpmethod == methlast`i') & (methlast`j' == 13) 		 & (cpmethodmonths == `i' - 2) & cpmethod != . // if had 1 month of "no sex" but was using same method before and after
	replace cpmethodmonths = `i' if (cpmethod == methlast`i') & (methlast`k' == 13) 		 & (cpmethodmonths == `i' - 3) & cpmethod != . // if had 2 months of "no sex" but was using same method before and after
	if `i' > 2 {
		replace cpmethodmonths = `i' if (cpmethod == methlast`i') & (methlast`l' == 13) 		 & (cpmethodmonths == `i' - 4) & cpmethod != . // if had 3 months of "no sex" but was using same method before/after
	}
}


// When did sterilizating op happen? This seems to be a little bit confounded in the month coding
// above-- some people are bouncing in and out of sterilization, despite the fact that we would likely assume it's
// quite permanent
// DATFEMOP_Y - we dont' have month, only year of sterilizing op
// set the CM date to the midpoint of the year they were sterilized included
gen cmster = .
replace cmster = (DATFEMOP_Y - 1900)*12 + 6
replace cmster = . if DATFEMOP_Y == 9999

gen cmhyst = .
replace cmhyst = (DATFEMOP_Y2 - 1900)*12 + 6
replace cmhyst = . if DATFEMOP_Y2 == 9999

gen cmov = .
replace cmov = (DATFEMOP_Y3 - 1900)*12 + 6
replace cmov = . if DATFEMOP_Y3 == 9999

gen cmothster = .
replace cmothster = (DATFEMOP_Y4 - 1900)*12 + 6
replace cmothster = . if DATFEMOP_Y4 == 9999

gen cmallster = .
replace cmallster = cmster
replace cmallster = cmhyst    if cmhyst < cmallster 
replace cmallster = cmov      if cmov < cmallster 
replace cmallster = cmothster if cmothster < cmallster 

gen durster = .
replace durster = CMINTVW - cmallster
replace durster = 0 if durster < 0

replace cpmethodmonths = durster if durster != . & durster != 0
replace cpmethodmonths = durster if durster == 0 & methlast1 != 1

// categorize durstertime
gen durstertime = .
replace durstertime = 1 if durster == 0 
replace durstertime = 2 if durster >= 1  & durster <= 6
replace durstertime = 3 if durster >= 7  & durster <= 12
replace durstertime = 4 if durster >= 13 & durster <= 24
replace durstertime = 5 if durster >  24 & durster < .
label define durstertime 1 "Less than 1 mo" 2 "1-6 mo" 3 "7-12 mo" 4 "13-24 mo"  5 "Greater than 24 mo"
label values durstertime durstertime



// Collapse into intelligible categories
gen methodtime = .
replace methodtime = 1 if cpmethodmonths == 0
replace methodtime = 2 if cpmethodmonths >= 1  & cpmethodmonths <= 6
replace methodtime = 3 if cpmethodmonths >= 7  & cpmethodmonths <= 12
replace methodtime = 4 if cpmethodmonths >= 13 & cpmethodmonths <= 24
replace methodtime = 5 if cpmethodmonths > 24  & cpmethodmonths < .
label define methodtime 1 "Less than 1 mo" 2 "1-6 mo" 3 "7-12 mo" 4 "13-24 mo"  5 "Greater than 24 mo"
label values methodtime methodtime
// TODO: go back and look at the ~160 peopel who get changed in this next step to make sure that
// it seems legitimate that we rewrite their methodtime.
// Replace methodtime with durstertime, assuming that durstertime is a more accurate
// depiction 
replace methodtime = durstertime if durstertime != . & (cpmethod == 1 | cpmethod == 14)

gen methodtime4 = .
replace methodtime4 = 1 if methodtime == 1 
replace methodtime4 = 2 if methodtime == 2
replace methodtime4 = 3 if methodtime == 3
replace methodtime4 = 4 if methodtime >= 4 & methodtime != .
label define methodtime4 1 "Less than 1 mo" 2 "1-6 mo" 3 "7-12 mo" 4 "Greater than 1 year"
label values methodtime4 methodtime4

/* Plan moving forward after mtg w Kari on 11/5:
 * Create a measure that looks at method at t-6 t-12 t-24
 * Compare to current method
 * Also count how many months of sexual inactivity in each time window
 * For women who have a lot of sexually inactive months, how consistent is their method use outside of that?
*/

// How many months of sexual inactivity between different time points?
gen nosex1to6 = 0
forvalues i = 1/6 {
	replace nosex1to6  = nosex1to6 + 1 if methlast`i' == 13
}

gen nosex7to12 = 0
forvalues i = 7/12 {
	replace nosex7to12  = nosex7to12 + 1 if methlast`i' == 13
}

gen nosex12to24 = 0
forvalues i = 12/24 {
	replace nosex12to24  = nosex12to24 + 1 if methlast`i' == 13
}

// Is the method used the same between time 0 and time 0 - n?
gen methsame0to1 = .
replace methsame0to1 = 0 if cpmethod != methlast1 & cpmethod != . & methlast1 != .
replace methsame0to1 = 1 if cpmethod == methlast1 & cpmethod != . & methlast1 != .
gen methsame0to6 = .
replace methsame0to6 = 0 if cpmethod != methlast5 & cpmethod != . & methlast6 != .
replace methsame0to6 = 1 if cpmethod == methlast6 & cpmethod != . & methlast6 != .
gen methsame0to12 = .
replace methsame0to12 = 0 if cpmethod != methlast12 & cpmethod != . & methlast12 != .
replace methsame0to12 = 1 if cpmethod == methlast12 & cpmethod != . & methlast12 != .
gen methsame0to24 = .
replace methsame0to24 = 0 if cpmethod != methlast24 & cpmethod != . & methlast24 != .
replace methsame0to24 = 1 if cpmethod == methlast24 & cpmethod != . & methlast24 != .


// Incorporate ster
// Incorporate pregs
gen usedmethatleast = 1
replace usedmethatleast = 2 if methsame0to1 == 1
replace usedmethatleast = 3 if methsame0to6 == 1
replace usedmethatleast = 4 if methsame0to6 == 1 & methsame0to12 == 1
replace usedmethatleast = 5 if methsame0to6 == 1 & methsame0to12 == 1 & methsame0to24 == 1
label define usedmethatleast 1 "LT 1mo" 2 "1 mo" 3 "6 mo" 4 "12 mo" 5 "24 mo"
label values usedmethatleast usedmethatleast

replace usedmethatleast = durstertime if durstertime != . & (cpmethod == 1 | cpmethod == 14)

gen usedmethatleast4 = usedmethatleast
replace usedmethatleast4 = 4 if usedmethatleast == 5
