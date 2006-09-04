#
# 00_prtverify_lib.awk
#
# Version 0.1.6 - 2006-08-30
# Jürgen Daubert <jue at jue dot li> 
#
# Utility functions for prtverify


function fullpath(dir,   cmd)
{
    cmd = "cd " dir " && pwd"
    cmd | getline dir
    close(cmd)
    return dir
}

function collectionport(path)
{
    sub(/\/$/, "", path)
    return substr(path, match(path, /[^/]+\/[^/]+$/))
}

function perror(level,message,   d,i,l,m,p,w)
{
    l = 25
    w[INFO]  = "INFO  "
    w[WARN]  = "WARN  "
    w[ERROR] = "ERROR "
    w[FATAL] = "FATAL "

    p = substr(COLLPORT, 1, l)
    for (i=1; i<=l-length(p); i++)
        d = d "."
    m = sprintf("%s %s %s %s", w[level], p, d, message)
    if (! (m in WLIST))
        print m
}

function loglevel_ok(level)
{
    return and(LOG_LEVEL,level)
}

function usr_error(message)
{
    print "===== ", message > "/dev/stderr"
}


BEGIN {

    if (! LOG_LEVEL)
        LOG_LEVEL = 15

    if (LOG_LEVEL <1 || LOG_LEVEL >15) {
        LOG_LEVEL = 15
        usr_error("Invalid loglevel, using " LOG_LEVEL)
    }

    INFO  = 8
    WARN  = 4
    ERROR = 2
    FATAL = 1
    
    PKGFILE   = ".*\\/Pkgfile"
    FOOTPRINT = ".*\\/\\.footprint"
    MD5SUM    = ".*\\/\\.md5sum"
}

