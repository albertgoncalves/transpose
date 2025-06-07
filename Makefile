MAKEFLAGS += --silent
FLAGS = \
	-fdiagnostics-color=always \
	-ibuild/ \
	-O \
	-optl-fuse-ld=lld \
	-outputdir build/ \
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
	-Wunused-type-patterns \
	-fno-warn-x-partial
MODULES = \
	Draw \
	Main \
	Parse \
	Primitives \
	Test \
	Transpose
BUILDS = $(foreach x,$(MODULES),build/$(x).hs)

.PHONY: all
all: bin/main

.PHONY: clean
clean:
	rm -rf bin/
	rm -rf build/

# NOTE: See `https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html`.
$(BUILDS): build/%.hs: src/%.hs
	mkdir -p build/
	hlint $<
	ormolu -i --no-cabal $<
	cp $< $@

bin/test: build/Test.hs build/Primitives.hs build/Transpose.hs
	mkdir -p bin/
	ghc $(FLAGS) -o $@ $<
	touch -c -m $@

bin/main: build/Main.hs build/Draw.hs build/Parse.hs bin/test
	./bin/test
	ghc $(FLAGS) -o $@ $<
	touch -c -m $@
