.PHONY: all clean ntsc pal

all: ntsc pal

PalName := Cold\ \&\ Starving\(Europe\)
NtscName := Cold\ \&\ Starving\(USA,\ Japan\)
Compress := lz4 -9 -f -B4 --no-frame-crc

ifeq ($(OS), Windows_NT)
	RM = del /Q /F
else
	RM = rm -rf
endif

define prepare_content
	python dev_tools/CropMaps.py
	$(Compress) src/intro.chr src/intro.lz4
	$(Compress) src/title.chr src/title.lz4
	$(Compress) src/cave_bg_tiles.chr src/cave_bg_tiles.lz4
	$(Compress) src/alien_bg_tiles.chr src/alien_bg_tiles.lz4
	$(Compress) src/house_bg_tiles.chr src/house_bg_tiles.lz4
	$(Compress) src/font.chr src/font.lz4
	$(Compress) src/UI.chr src/UI.lz4
	$(Compress) src/main_core_sprites.chr src/main_core_sprites.lz4
	$(Compress) src/main_animal_sprites.chr src/main_animal_sprites.lz4
	$(Compress) src/cave_sprites.chr src/cave_sprites.lz4
	$(Compress) src/alien_sprites.chr src/alien_sprites.lz4
	$(Compress) src/house_sprites.chr src/house_sprites.lz4
	$(Compress) src/main_bg_tiles.chr src/main_bg_tiles.lz4
	$(Compress) src/crashed_plane_tiles.chr src/crashed_plane_tiles.lz4
	$(Compress) src/title_tiles.chr src/title_tiles.lz4
	$(Compress) src/gameover_tiles.chr src/gameover_tiles.lz4
	python dev_tools/CropLZ4bytes.py
endef

pal:
	@$(call prepare_content)
	ca65 src/game.asm   -DFAMISTUDIO_CFG_PAL_SUPPORT=1  -g -o src/game.o
	ld65 -o $(PalName).nes -m map.txt -C memory.cfg src/game.o --dbgfile $(PalName).dbg -Ln $(PalName).labels.txt
	$(RM) src/*.o
	python dev_tools/fceux_symbols.py $(PalName)

ntsc:
	@$(call prepare_content)
	ca65 src/game.asm  -DFAMISTUDIO_CFG_NTSC_SUPPORT=1 -g -o src/game.o
	ld65 -o $(NtscName).nes -m map.txt -C memory.cfg src/game.o --dbgfile $(NtscName).dbg -Ln $(NtscName).labels.txt
	$(RM) src/*.o
	python dev_tools/fceux_symbols.py $(NtscName)

clean:
	$(RM) src/data/maps/cropped/*.asm
	$(RM) src/*.lz4
	$(RM) *.nl
	$(RM) *.dbg
	$(RM) *.labels.txt
	$(RM) map.txt
