#
# 20_release_number.awk
#
# Version 0.1.2 - 2006-07-14
# Jürgen Daubert <jue at jue dot li> 
#
# only integer numbers >= 1 are valid for the release variable


loglevel_ok(ERROR) && FILENAME ~ PKGFILE {

    if ($1 ~ /^release=/) {
        split($1, an, "=")
        if (an[2] !~ /^[1-9][0-9]*$/)
            perror(ERROR, "variable release contains invalid characters: " an[2])
    }
}

