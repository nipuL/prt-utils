#
# 30_suid_sgid.awk
#
# Version 0.1.2 - 2006-09-23
# Jürgen Daubert <jue at jue dot li> 


FILENAME ~ FOOTPRINT {

    if (loglevel_ok(INFO)) {

        if ($1 ~ /^[^d]..s....../)
            perror(INFO, "suid file found: " $3)

        if ($1 ~ /^[^d].....s.../)
            perror(INFO, "sgid file found: " $3)
    }

    if (loglevel_ok(FATAL)) {

        if ($1 ~ /^d..s....../)
            perror(FATAL, "suid directory found: " $3)

        if ($1 ~ /^d.....s.../)
            perror(FATAL, "sgid directory found: " $3)
    }
}

