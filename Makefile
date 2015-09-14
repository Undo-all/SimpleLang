HS_FILES=$(shell echo *.hs)

all: $(HS_FILES)
	ghc *.hs -O2 -o simple
	rm *.hi *.o

install: all
	mv simple /usr/bin

