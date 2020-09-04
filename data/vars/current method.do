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
