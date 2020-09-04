** Defining at risk of preg
// From : Mosher, William, Jo Jones, and Joyce Abma. “Nonuse of Contraception among Women at Risk of Unintended Pregnancy in the United States.” Contraception 92, no. 2 (August 1, 2015): 170–76. https://doi.org/10.1016/j.contraception.2015.05.004.
// At risk - using contraception and had sex at least once, or not using contraception and sexually active
// not at risk - pregnancy, trying to be pregnant, 6 or fewer weeks postpartum, sterile
// Q: how do we want to handle sterilization?

// From: Kavanaugh, Megan L., and Jenna Jerman. “Contraceptive Method Use in the United States: Trends and Characteristics between 2008, 2012 and 2014.” Contraception 97, no. 1 (January 1, 2018): 14–21. https://doi.org/10.1016/j.contraception.2017.10.003.

// not preg, not trying to be preg, ever had sex, isn't sterilized for non-cp reasons
gen included = 0
replace included = 1 if pregnant != 1 & trying != 1 & RHADSEX == 1 & CONSTAT1 != 33 & CONSTAT1 != 34 & CONSTAT1 != 35 & CONSTAT1 != 38 & CONSTAT1 != 32 & AGER <= 44

** INCLUDEDSEX3MO -- the inclusion critera we'll use **
// baseline inclusion -- not preg, not trying to be preg, had sex in past 3 mo
gen includedsex3mo = 0
replace includedsex3mo = 1 if pregnant != 1 & trying != 1 & SEX3MO == 1 & AGER <= 44
cou if includedsex3mo == 1

// additionallly, isn't sterilized for non-cp reasons
// count
cou if includedsex3mo == 1 & (CONSTAT1 == 33 | CONSTAT1 == 34 | CONSTAT1 == 35 | CONSTAT1 == 38)
// exclude
replace includedsex3mo = 0 if (CONSTAT1 == 33 | CONSTAT1 == 34 | CONSTAT1 == 35 | CONSTAT1 == 38)

// additionally, isn't w/in 2 months postpartum
// count
cou if includedsex3mo == 1 & CONSTAT1 == 32
// exclude
replace includedsex3mo = 0 if CONSTAT1 == 32

tab includedsex3mo
