#!/usr/bin/make -f

CROSS_COMPILE = i686-w64-mingw32-
CC = $(CROSS_COMPILE)gcc
STRIP = $(CROSS_COMPILE)strip
CFLAGS = -O3 -march=i686 -DTELNET -DGAPING_SECURITY_HOLE
LDFLAGS = -Wl,-lkernel32,-luser32,-lwinmm,-lws2_32
DEPS = getopt.c doexec.c netcat.c
OBJS = getopt.o doexec.o netcat.o
EXEC_UNSTRIPPED = nc_unstripped.exe
EXEC = nc.exe

.PHONY: all
all: build

.PHONY: build
build: $(EXEC)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) $(LDFLAGS)

$(EXEC_UNSTRIPPED): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

$(EXEC): $(EXEC_UNSTRIPPED)
	$(STRIP) -s $^ -o $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(EXEC) $(EXEC_UNSTRIPPED)
