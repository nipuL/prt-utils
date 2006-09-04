#
# 20_pkgfile_headers.awk
#
# Version 0.1.1 - 2006-08-24
# Jürgen Daubert <jue at jue dot li> 


BEGIN {

    pkgfile_headers["Description"] = 0
    pkgfile_headers["URL"]         = 0
    pkgfile_headers["Maintainer"]  = 0
}


loglevel_ok(ERROR) && FILENAME ~ PKGFILE {

    for (h in pkgfile_headers) {
        if ( $0 ~ ("^# " h ":") ) {
            pkgfile_headers[h] = 1
            split($0, ac, ":")
            if (! ac[2])
                perror(ERROR, "empty header found: " h)
        }
    }
}


END {

    if (loglevel_ok(ERROR)) {
        for (h in pkgfile_headers) {
            if (! pkgfile_headers[h])
                perror(ERROR, "header not found: " h)
        }
    }
}

