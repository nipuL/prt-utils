TOOLS 	= prtcreate prtrej prtsweep prtcheck prtwash pkgexport pkgsize \
	  prtorphan prtcheckmissing oldfiles finddeps dllist \
	  findredundantdeps pkg_installed

PREFIX	= /usr
MANDIR	= $(PREFIX)/man
BINDIR	= $(PREFIX)/bin
CONFDIR	= /etc

install-man:
	if [ ! -d $(DESTDIR)$(MANDIR)/man1 ]; then \
	  mkdir -p $(DESTDIR)$(MANDIR)/man1; \
	fi
	for manpage in $(TOOLS); do \
	  if [ -f $$manpage.1 ]; then \
	    cp $$manpage.1 $(DESTDIR)$(MANDIR)/man1/; \
	    chmod 644 $(DESTDIR)$(MANDIR)/man1/$$manpage.1; \
	  fi; \
	done

install-bin:
	if [ ! -d $(DESTDIR)$(BINDIR) ]; then \
	  mkdir -p $(DESTDIR)$(BINDIR); \
	fi
	for binary in $(TOOLS); do \
	  cp $$binary $(DESTDIR)$(BINDIR)/; \
	  chmod 755 $(DESTDIR)$(BINDIR)/$$binary; \
	done

install-conf:
	if [ ! -d $(DESTDIR)$(CONFDIR) ]; then \
	  mkdir -p $(DESTDIR)$(CONFDIR); \
	fi
	for tool in $(TOOLS); do \
	  if [ -f $$tool.conf ]; then \
	    cp $$tool.conf $(DESTDIR)$(CONFDIR)/; \
	    chmod 644 $(DESTDIR)$(CONFDIR)/$$tool.conf; \
	  fi; \
	done

install: install-man install-bin # install-conf
