#
# 20_maintainer_email.awk
#
# Version 0.1.0 - 2006-09-02
# Jürgen Daubert <jue at jue dot li>
#
# Checks the Maintainer header for invalid characters


loglevel_ok(WARN) && FILENAME ~ PKGFILE {

    if ( $0 ~ ("^# Maintainer:") ) {
        if ( p = match($0, /[<>@]+/) )
            perror(WARN, "invalid email address: " substr($0, p))
    }
}

