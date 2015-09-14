HS_FILES=$(shell echo *.hs)

all: simple

install: simple
	mv simple /usr/bin

simple: $(HS_FILES)
	ghc *.hs -O2 -o simple
	rm *.hi *.o

.PHONY: install

