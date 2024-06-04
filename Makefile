all: ntsc pal

PalName := Cold\ \&\ Starving\(Europe\)
NtscName := Cold\ \&\ Starving\(USA,\ Japan\)

ifeq ($(OS), Windows_NT)
	RM = del /Q /F src\*.o
else
	RM = rm -rf src/*.o
endif

pal:
	python CropMaps.py
	lz4 -9 -f -B4 --no-frame-crc src/intro.chr src/intro.lz4
	lz4 -9 -f -B4 --no-frame-crc src/title.chr src/title.lz4
	lz4 -9 -f -B4 --no-frame-crc src/alien_bg_tiles.chr src/alien_bg_tiles.lz4
	lz4 -9 -f -B4 --no-frame-crc src/house_bg_tiles.chr src/house_bg_tiles.lz4
	python CropLZ4bytes.py
	ca65 src/game.asm   -DFAMISTUDIO_CFG_PAL_SUPPORT=1  -g -o src/game.o
	ld65 -o $(PalName).nes -m map.txt -C memory.cfg src/game.o --dbgfile $(PalName).dbg -Ln $(PalName).labels.txt
	$(RM)
	python fceux_symbols.py $(PalName)

ntsc:
	python CropMaps.py
	lz4 -9 -f -B4 --no-frame-crc src/intro.chr src/intro.lz4
	lz4 -9 -f -B4 --no-frame-crc src/title.chr src/title.lz4
	lz4 -9 -f -B4 --no-frame-crc src/alien_bg_tiles.chr src/alien_bg_tiles.lz4
	lz4 -9 -f -B4 --no-frame-crc src/house_bg_tiles.chr src/house_bg_tiles.lz4
	python CropLZ4bytes.py
	ca65 src/game.asm  -DFAMISTUDIO_CFG_NTSC_SUPPORT=1 -g -o src/game.o
	ld65 -o $(NtscName).nes -m map.txt -C memory.cfg src/game.o --dbgfile $(NtscName).dbg -Ln $(NtscName).labels.txt
	$(RM)
	python fceux_symbols.py $(NtscName)
