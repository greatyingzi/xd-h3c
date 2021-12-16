CC=gcc
BIN=xd-h3c
LIBS= -lpcap -lm
CFLAGS=-Wall

###support linux
#CFLAGS += -D HAVE_SIOCGIFHWADDR

###support osx/macos
CFLAGS += -D HAVE_GETIFADDRS

INSTALL=install
RM=rm

all: $(BIN)

xd_h3c.o: xd_h3c.c
	$(CC) $(CFLAGS) -c $<

authenticate.o: authenticate.c authenticate.h
	$(CC) $(CFLAGS) -c $<

md5.o: ./md5/md5.c
	$(CC) $(CFLAGS) -c $<

$(BIN): xd_h3c.o authenticate.o md5.o
	$(CC) $(CFLAGS) $+ $(LIBS) -o $@

install:
	$(INSTALL) -d /usr/local/bin
	$(INSTALL) -p -D -m 0755 $(BIN) /usr/local/bin

uninstall:
	$(RM) -rf /usr/local/bin/$(BIN)

clean:
	@$(RM) -rf *.o $(BIN)

