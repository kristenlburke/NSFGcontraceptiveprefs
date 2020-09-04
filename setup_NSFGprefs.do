* Set up the base environment.

* The current directory is assumed to be the one with the base  code.

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




