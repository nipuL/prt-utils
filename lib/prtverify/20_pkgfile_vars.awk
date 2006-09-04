#
# 20_pkgfile_vars.awk
#
# Version 0.1.2 - 2006-07-14
# Jürgen Daubert <jue at jue dot li> 


BEGIN {

    pkgfile_vars["name"]    = 0
    pkgfile_vars["version"] = 0
    pkgfile_vars["release"] = 0
    pkgfile_vars["source"]  = 0
}


loglevel_ok(ERROR) && FILENAME ~ PKGFILE {

    for (v in pkgfile_vars) {
        if ( $1 ~ ("^" v "=") )
            pkgfile_vars[v] = 1
    }
}


END {

    if (loglevel_ok(ERROR)) {
        for (v in pkgfile_vars) {
            if (! pkgfile_vars[v])
                perror(ERROR, "variable not found: " v)
        }
    }
}

