#
# 30_filesystem_collisions.awk
#
# Version 0.1.0 - 2006-10-29
# Jürgen Daubert <jue at jue dot li>
#
# Suggested by Mark Rosenstand
#
# Detects changes in permissions for the directories provided
# by the core/filesystem port


BEGIN {

    core_filesystem = "/usr/ports/core/filesystem/.footprint"

    while ((getline l < core_filesystem) > 0) {
        split(l, al)
        if (al[1] ~ /^d/)
            filesystem_collisions[al[3]] = al[1]
    }
}


loglevel_ok(FATAL) && FILENAME ~ FOOTPRINT {

    if ($3 in filesystem_collisions) {
        p = filesystem_collisions[$3]
        if ($1 != p)
            perror(FATAL, "Collision with core/filesystem: " $1 " != " p " -> " $3)
    }
}

