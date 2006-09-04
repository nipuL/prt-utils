#
# 10_file_check_clean_repo.awk
#
# Version 0.1.0 - 2006-08-07
# Johannes Winkelmann, jw at smts dot ch
#
# Tests for invalid files in a clean repo


function list_files(dir,af,   cmd,f)
{
    cmd = "ls -1A --color=none " dir
    delete af
    while (cmd | getline f)
        af[f]
    close(cmd)
}


BEGIN {

    if (loglevel_ok(FATAL)) {

        list_files(PORTDIR, af)

        for (f in af) {
            if (f ~ "(.(tar.(bz2|gz)|tgz|zip|rar|svn)|CVS|REPO|index.hml)$")
                perror(FATAL, "invalid file/directory: " f)
        }
    }
}

