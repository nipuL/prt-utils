#
# 90_mk_footprint_db.awk
#
# Version 0.1.0 - 2006-08-31
# Jürgen Daubert <jue at jue dot li>
#
# Creates a temporary file with all footprints and
# the owners of those
#
# File format:
#  <file-name>  coll1/port1:coll2/port2:...
#
# Needed variables:
# - FOOTPRINTDB   the name of the temporary file
#
# Requires:
# - 00_prtverify_lib.awk
#
# Usage example:
#   gawk -v FOOTPRINTDB=<file> \
#        -f 00_prtverify_lib.awk \
#        -f 90_mk_footprint_db.awk \
#        /usr/ports/{core,opt,contrib}/*/.footprint


function beginfile(name)
{
    sub(/\/\.footprint/, "", name)
    name = fullpath(name)
    COLLPORT = collectionport(name)
}


BEGIN {
    FS = "\t"
}


FNR == 1 {
    beginfile(FILENAME)
}

FILENAME ~ FOOTPRINT && $3 !~ /\/$/ {
    sub(/ -> .*/, "", $3)
    if (! ($3 in fc_map))
        fc_map[$3] = COLLPORT
    else
        fc_map[$3] = fc_map[$3] ":" COLLPORT
}


END {

    for (i in fc_map)
        print i "\t" fc_map[i] > FOOTPRINTDB
}

