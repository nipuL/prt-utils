#
# 30_system_users.awk
#
# Version 0.1.2 - 2006-09-08
# Jürgen Daubert <jue at jue dot li> 


loglevel_ok(ERROR+INFO) && FILENAME ~ FOOTPRINT {

    split($2, au, "/")
    warned = 0

    if (loglevel_ok(ERROR)) {
 
        if (au[1] ~ /[1-9][0-9]*/) {
            perror(ERROR, "invalid user: " $2 " -> " $3)
            warned = 1
        }

        if (au[2] ~ /[1-9][0-9]*|users/) {
            perror(ERROR, "invalid group: " $2 " -> " $3)
            warned = 1
        }
    }

    if (! warned && loglevel_ok(INFO) && $3 ~ /^(lib|sbin|usr)\//) {
        if (au[1] !~ /root/)
            perror(INFO, "file not owned by root: " $2 " -> " $3)
    }
}

