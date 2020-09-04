* Set up the base Cohab Fertility environment.

* The current directory is assumed to be the one with the base Cohab Fertility code.

* We expect to find your setup file, named setup_<username>.do
* in the base Cohab Fertility directory.


* Find my home directory, depending on OS.
if ("`c(os)'" == "Windows") {
    local temp_drive : env HOMEDRIVE
    local temp_dir : env HOMEPATH
    global homedir "`temp_drive'`temp_dir'"
    macro drop _temp_drive _temp_dir`
}
else {
    if ("`c(os)'" == "MacOSX") | ("`c(os)'" == "Unix") {
        global homedir : env HOME
    }
    else {
        display "Unknown operating system:  `c(os)'"
        exit
    }
}


global NSFGprefs_base_code "`c(pwd)'"

do setup_`c(username)'

if ("$boxdir" == "") {
    display as error "boxdir macro not set."
    exit
}


* Files created from original data to be used by other project members or 
* to support analyses in papers are put in the "shared" directory.
* If a file is in the shared directory, there should be code that takes us from
* an original data file to the shared data file. The name of the file with 
* that code should be the same name as the shared data file.



