// TODO: add in a correction/counter of time since ster -- problem is that we only have
// YEAR that someone was sterilized, not CM!

// Do those who are sterilized and would prefer another method have regret about their sterilization?

// RWANTRVT - would you want to reverse your TL
// MANWANTT - would your partener want you to have your TL reversed

// RWANTREV - would you want your partner to reverse vasectomy
// MANWANTR - would your partner want to reverse his vasectomy

gen sterregret = .
replace sterregret = 1 if RWANTRVT == 1 | RWANTRVT == 2
replace sterregret = 0 if RWANTRVT == 3 | RWANTRVT == 4
label define yesno 0 "No" 1 "Yes"
label values sterregret yesno

gen partnersterregret = .
replace partnersterregret = 1 if MANWANTT == 1 | MANWANTT == 2
replace partnersterregret = 0 if MANWANTT == 3 | MANWANTT == 4 
label values partnersterregret yesno

gen vasregret = .
replace vasregret = 1 if RWANTREV == 1 | RWANTREV == 2
replace vasregret = 0 if RWANTREV == 3 | RWANTREV == 4
label values vasregret yesno

gen partnervasregret = .
replace partnervasregret = 1 if MANWANTR == 1 | MANWANTR == 2
replace partnervasregret = 0 if MANWANTR == 3 | MANWANTR == 4
label values partnervasregret yesno


tab cpmethod sterregret, m // if we knock it down to just those included in the sample, n missing shrinks
// who are the people who we don't have sterilization regret info on who are classified as sterilized?
// they are people who are more permanently sterilized, including people who got hysterecomies or had ovariaes removed
// i.e. people for which a tubal ligation reversal wouldn't restor their fecundibilty

/* See below code for exploration
tab ANYTUBAL if sterregret == . & cpmethod == 1  // computed
tab ANYFSTER if sterregret == . & cpmethod == 1  // computed
tab STRLOPER if sterregret == . & cpmethod == 1  // recoded
tab STRLOPER if sterregret == . & cpmethod == 1 & includedsex3mo == 1 // recoded
tab ONLYTBVS if sterregret == . & cpmethod == 1 & includedsex3mo == 1 // recoded
tab STRLOPER if sterregret == . & cpmethod == 1 & includedsex3mo == 1 & ONLYTBVS == 5 // recoded
tab HYST OVAREM if sterregret == . & cpmethod == 1 & includedsex3mo == 1 & ONLYTBVS == 5 // recoded 
tab OTHR if sterregret == . & cpmethod == 1 & includedsex3mo == 1 & ONLYTBVS == 5 & HYST == 5 & OVAREM == 5
tab OVAREM if sterregret == . & cpmethod == 1 & includedsex3mo == 1 & ONLYTBVS == 5 // recoded
*/

