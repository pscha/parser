.SUFFIXES:
CC     := gcc
LEX    := flex

LFLAGS := -t
CFLAGS := -Wall -DLEXDEBUG -pedantic

LFILES := minako-lexic.l
HFILES := minako.h
CFILES := parser.c

target = $(LFILES:%.l=%.o) $(CFILES:%.c=%.o)

# Compiling
%.c: %.l
	$(LEX) $(LFLAGS) $< > $@
%.o: %.c
	$(CC) $(CFLAGS) -c $<

# Targets
all: parser
parser: $(target)
	$(CC) $(CFLAGS) $^ -o $@

clean:
	$(RM) $(RMFILES) parser *.o
