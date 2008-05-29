#
# 05_file_check.awk
#
# Version 0.2.0 - 2008-05-21
# Jürgen Daubert <jue at jue dot li> 
#
# Tests for the mandatory port files
# 
# Sets some global variables
# - PORTDIR    the full path of the port
# - PORT       the name of the port
# - COLLPORT   a shortcut for Collection/Port like core/gcc
#
# PORT_FILES and WHITE_LIST are set by prtverify



function readwhitelist(filelist,   f,af,line)
{
    split(filelist,af)

    for (f in af) {
        if (system("test -f " af[f]) != 0) {
            usr_error("Error: file " af[f] " not found!")   
            continue
        }
        while ((getline line < af[f]) > 0)
            WLIST[line]
    }
}


BEGIN {
   
    PORTDIR = ARGV[1]
    if (system("test -d " PORTDIR) != 0) {
        usr_error(PORTDIR " is not a directory, ignoring")
        exit
    }

    PORTDIR = fullpath(PORTDIR)
    PORT = gensub(/^.*\//, "", 1, PORTDIR)
    COLLPORT = collectionport(PORTDIR)

    delete ARGV
    ARGC  = 1

    split(PORT_FILES, af)

    for (f in af) {
        p = PORTDIR "/" af[f]
        if (system("test -f " p) == 0)
            ARGV[ARGC++] = p
        else 
            if(loglevel_ok(FATAL))
                perror(FATAL, "file not found: " af[f])
    }

    if (ARGC == 1)
        exit

    readwhitelist(WHITE_LIST)
}

