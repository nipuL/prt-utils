#
# 20_missing_deps.awk
#
# Version 0.1 - 2006-08-26
# Jürgen Daubert <jue at jue dot li>


BEGIN {

    if (DEP_PORTS) {
        split(DEP_PORTS, ac)
        for (i in ac)
            DEP_MAP[ac[i]]
    }
}


loglevel_ok(ERROR) && FILENAME ~ PKGFILE && DEP_PORTS {

    if ( $0 ~ ("^# Depends on:") ) {

        split($0, ac, /:[[:space:]]*/)
        split(ac[2], ad, /[[:space:]]*,[[:space:]]*|[[:space:]]+/)

        for (d in ad) {
            if (ad[d] !~ /^ *$/ && ! (ad[d] in DEP_MAP))
                perror(ERROR, "missing dependency: " ad[d])
        }
    }
}

