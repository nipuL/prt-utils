#
# 30_suid_sgid.awk
#
# Version 0.1 - 2006-07-24
# Jürgen Daubert <jue at jue dot li> 


loglevel_ok(INFO) && FILENAME ~ FOOTPRINT {

    if ($1 ~ /^...s....../)
        perror(INFO, "suid file found: " $3)

    if ($1 ~ /^......s.../)
        perror(INFO, "sgid file found: " $3)
}

