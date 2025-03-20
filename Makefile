MAKEFLAGS += --silent
FLAGS = \
	-fdiagnostics-color=always \
	-O \
	-optl -fuse-ld=lld \
	-Wall \
	-Wcompat \
	-Werror \
	-Widentities \
	-Wincomplete-record-updates \
	-Wincomplete-uni-patterns \
	-Wmonomorphism-restriction \
	-Wpartial-fields \
	-Wredundant-constraints \
	-Wunused-packages \
	-Wunused-type-patterns
MODULES = \
	Draw \
	Parse \
	Transpose
OBJECTS = $(foreach x,$(MODULES),build/$(x).o)

.PHONY: all
all: bin/main

.PHONY: clean
clean:
	rm -rf bin/
	rm -rf build/

# NOTE: See `https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html`.
build/Primitives.o: src/Primitives.hs
	rm -f $@
	mkdir -p build/
	hlint $<
	ormolu -i --no-cabal $<
	ghc $(FLAGS) -outputdir build -c $<

$(OBJECTS): build/%.o: src/%.hs build/Primitives.o
	rm -f $@
	hlint $<
	ormolu -i --no-cabal $<
	ghc $(FLAGS) -outputdir build -c $<

build/Test/Main.o: src/Test.hs build/Transpose.o
	rm -f $@
	hlint $<
	ormolu -i --no-cabal $<
	mkdir -p bin/
	ghc $(FLAGS) -odir build/Test -hidir build -c $<

bin/test: build/Test/Main.o
	ghc $(FLAGS) -package HUnit -o $@ build/Primitives.o build/Transpose.o $<

build/Main.o: src/Main.hs bin/test build/Draw.o build/Parse.o
	rm -f $@
	./bin/test
	hlint $<
	ormolu -i --no-cabal $<
	ghc $(FLAGS) -outputdir build -c $<

bin/main: build/Main.o
	ghc $(FLAGS) -o $@ build/Draw.o build/Parse.o build/Primitives.o build/Transpose.o $<
