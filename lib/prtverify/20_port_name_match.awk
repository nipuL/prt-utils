#
# 20_port_name_match.awk
#
# Version 0.1.1 - 2006-07-14
# Jürgen Daubert <jue at jue dot li> 


loglevel_ok(ERROR) && FILENAME ~ PKGFILE {

    if ($1 ~ /^name=/) {
        split($1, an, "=")
        if (an[2] != PORT)
            perror(ERROR, "variable name do not match the portname: " an[2])
    }
}

