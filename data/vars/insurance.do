// Insurance status 

// I had some questions about the coding, especially with regard to IHS and single-service
// plans. Below is an email exchange with Kari, which is used to guide this recode.

/* KLB to KW, 9/18:
I'm looking at the CURR_INS variable to do recodes into public/private/uninsured, 
and I'm mostly not sure what to do with the few folks who fall into this category who *do* have coverage: 
Currently covered only by a single-service plan, only by the Indian Health Service, or currently not covered by health insurance. 
IHS seems public, but not sure where I'd put the single-service plan folks.

KW to KLB, 9/18: 
Are you working with the recode variable?  These people end up in the ‘uninsured’ category. 
So the categories would be private insurance, public (medicaid, medicare, military, 
other government, and uninsured (including single-service plan)
*/

gen insurancecat3 = .
replace insurancecat3 = 1 if  CURR_INS == 1										// Private insurance
replace insurancecat3 = 2 if (CURR_INS == 2 | CURR_INS == 3 )					// Medicaid/chip and medicare/military
replace insurancecat3 = 3 if  CURR_INS == 4										// single-service, IHS, or none

label define insurancecat3 1 "Privately insured" 2 "Publicly insured" 3 "Uninsured"
label values insurancecat3 insurancecat3
