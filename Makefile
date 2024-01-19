all: ntsc pal

pal:
	ca65 src/game.asm   -DFAMISTUDIO_CFG_PAL_SUPPORT=1  -g -o src/game.o
	ld65 -o Cold\ \&\ Starving\(Europe\).nes -m map.txt -C memory.cfg src/game.o --dbgfile survival.dbg -Ln survival.labels.txt
	rm -rf src/*.o
	python fceux_symbols.py

ntsc:
	ca65 src/game.asm  -DFAMISTUDIO_CFG_NTSC_SUPPORT=1 -g -o src/game.o
	ld65 -o Cold\ \&\ Starving\(USA,\ Japan\).nes -m map.txt -C memory.cfg src/game.o --dbgfile survival.dbg -Ln survival.labels.txt
	rm -rf src/*.o
	python fceux_symbols.py
