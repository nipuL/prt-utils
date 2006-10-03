#
# 30_invalid_dirs.awk
#
# Version 0.1.3 - 2006-09-24
# Jürgen Daubert <jue at jue dot li> 


BEGIN {

    invalid_dirs[1] = "^usr/share/man/$"
    invalid_dirs[2] = "^usr/local/$"
    invalid_dirs[3] = "^usr/share/locale/$"
    invalid_dirs[4] = "^usr/info/$"
    invalid_dirs[5] = "^usr/libexec/$"
    invalid_dirs[6] = "^usr/man/../$"
}


loglevel_ok(ERROR) && FILENAME ~ FOOTPRINT {

    for (d in invalid_dirs) {
        if ($3 ~ invalid_dirs[d])
            perror(ERROR, "directory not allowed: " $3)
    }
}

