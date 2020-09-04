// Do variable recode scripts

** Unmet pref 
do "data/vars/prefer another.do"

** Race/ethnicity - doesn't need recode
// HISPRACE & HISPRACE2
// HISPRACE2 has NH other & multi-racial in a separate category

** Nativity
// BRNOUT

** Insurance status
// CURR_INS
do "data/vars/insurance"

** Age
// AGER
do "data/vars/age"

** Parity
// NUMPREGS -- lifetime pregs, including current. also abs.
// NUMBABES
// PARITY -- use this one
do "data/vars/parity"

** Marital status
// FMARIT - formal marital status at interview
// RMARITAL - includes cohab
do "data/vars/marstat"

** Income
// POVERTY
do "data/vars/fpl"

** Public assistance
// PUBASSIS

** Education
do "data/vars/education"

** Mother's education?
// bc lots of the sample is quite young; of course they haven't finished HS
// EDUCMOM 

** Current method
// CONSTAT1
do "data/vars/current method"

** Source of care
// USUALCAR
// USLPLACE
do "data/vars/source of care"

** Sexual activity
// RHADSEX
// SEX3MO
do "data/vars/sexual activity"

** Geography
// METRO

** Future births expected
// INTENT - recoded *intention* to have additional children
// RWANT - do you want a(nother) baby sometime? raw, w/ followup of PROBWANT for dks
do "data/vars/wantmore"

** steriliztaion regret 
do "data/vars/ster regret"

** duration of use

** Housing insecurity/other disruptive events?






