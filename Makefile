#! /usr/bin/make -f

CC65DIR=/usr/share/cc65
CC65LIBDIR=$(CC65DIR)/lib
CC65ASMINCDIR=$(CC65DIR)/asminc
CC65CFGDIR=$(CC65DIR)/cfg
#
AS=ca65
ASFLAGS=-t c64

CONFIGURATIONS=c128-basicfriendly-asm.cfg  c64-basicfriendly-asm.cfg
SOURCES=$(wildcard lib-functions/*.s)
OBJS=$(SOURCES:.s=.o)

.PHONY:	all clean install uninstall

all:	LAMAlib.lib

clean:
	rm -f LAMAlib.lib
	rm -f lib-functions/*.o

install:	all
	mkdir -p $(CC65LIBDIR) $(CC65ASMINCDIR) $(CC65CFGDIR)
	cp LAMAlib.lib $(CC65LIBDIR)
	cp LAMAlib*.inc $(CC65ASMINCDIR)
	cp $(CONFIGURATIONS) $(CC65CFGDIR)

uninstall:
	rm -f $(CC65LIBDIR)/LAMAlib.lib
	rm -f $(CC65ASMINCDIR)/LAMAlib*.inc
	rm -f $(addprefix $(CC65CFGDIR)/, $(CONFIGURATIONS))

LAMAlib.lib:	$(OBJS)
	ar65 a LAMAlib.lib $+
