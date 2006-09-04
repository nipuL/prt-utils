#
# 30_file_permissions.awk
#
# Version 0.1.1 - 2006-07-14
# Jürgen Daubert <jue at jue dot li> 


loglevel_ok(FATAL) && FILENAME ~ FOOTPRINT {

    if ($1 ~ /^d.......w./)
        perror(FATAL, "world writable directory found: " $3)

    if ($1 ~ /^-.......w./)
        perror(FATAL, "world writable file found: " $3)
}

