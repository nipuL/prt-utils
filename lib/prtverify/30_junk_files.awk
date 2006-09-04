#
# 30_junk_files.awk
#
# Version 0.1.2 - 2006-07-14
# Jürgen Daubert <jue at jue dot li> 


BEGIN {

    # Perl junk files
    junk_files[1] = ".*/perl./.*/(perllocal\\.pod|\\.packlist|[^/]+\\.bs)$"

    # GNU junk files
    junk_files[2] = "AUTHORS|BUGS|COPYING|ChangeLog|INSTALL|NEWS|README|THANKS|TODO"
}


loglevel_ok(WARN) && FILENAME ~ FOOTPRINT {

    for (f in junk_files) {
        if ($3 ~ junk_files[f])
            perror(WARN, "junk file found: " $3)
    }
}

