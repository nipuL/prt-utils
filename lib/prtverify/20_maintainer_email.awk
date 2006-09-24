#
# 20_maintainer_email.awk
#
# Version 0.1.1 - 2006-09-11
# Jürgen Daubert <jue at jue dot li>
#
# Checks the Maintainer header for invalid characters
# and for the correct 'name, email at provider dot sth'.


loglevel_ok(WARN) && FILENAME ~ PKGFILE {

    if ( $0 ~ ("^# Maintainer:") ) {

        if ( p = match($0, /[<>@]+/) )
            perror(WARN, "invalid email address: " substr($0, p))

        else if ( $0 !~ /.*, .* at .* dot .*/ ) {
            m = gensub(/^# Maintainer: */,"", "1")
            if ( m !~ /^ *$/ )
                perror(WARN, "invalid Maintainer-header: " m)
        }
    }
}

