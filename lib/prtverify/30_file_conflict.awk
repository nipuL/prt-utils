#
# 30_file_conflict.awk
#
# Version 0.1.0 - 2006-08-31
# Jürgen Daubert <jue at jue dot li>


BEGIN {

    if (FOOTPRINTDB) {
        while ((getline l < FOOTPRINTDB) > 0) {
            split(l, am, "\t")
            file_conflict[am[1]] = am[2]
        }
        close(file)
    }
}


loglevel_ok(ERROR) && FILENAME ~ FOOTPRINT {

    if ($3 in file_conflict) {
        split(file_conflict[$3], am, ":")
        for (i in am) {
            if (am[i] != COLLPORT)
                perror(ERROR, "file conflict found: " am[i] " -> " $3)
        }
    }
}

