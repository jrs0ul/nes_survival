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
	$(Compress) src/chr/intro.chr src/chr/intro.lz4
	$(Compress) src/chr/cave_bg_tiles.chr src/chr/cave_bg_tiles.lz4
	$(Compress) src/chr/alien_bg_tiles.chr src/chr/alien_bg_tiles.lz4
	$(Compress) src/chr/house_bg_tiles.chr src/chr/house_bg_tiles.lz4
	$(Compress) src/chr/font.chr src/chr/font.lz4
	$(Compress) src/chr/UI.chr src/chr/UI.lz4
	$(Compress) src/chr/main_core_sprites.chr src/chr/main_core_sprites.lz4
	$(Compress) src/chr/main_animal_sprites.chr src/chr/main_animal_sprites.lz4
	$(Compress) src/chr/cave_sprites.chr src/chr/cave_sprites.lz4
	$(Compress) src/chr/boss_sprites.chr src/chr/boss_sprites.lz4
	$(Compress) src/chr/alien_sprites.chr src/chr/alien_sprites.lz4
	$(Compress) src/chr/house_sprites.chr src/chr/house_sprites.lz4
	$(Compress) src/chr/main_bg_tiles.chr src/chr/main_bg_tiles.lz4
	$(Compress) src/chr/crashed_plane_tiles.chr src/chr/crashed_plane_tiles.lz4
	$(Compress) src/chr/title_tiles.chr src/chr/title_tiles.lz4
	$(Compress) src/chr/gameover_tiles.chr src/chr/gameover_tiles.lz4
	$(Compress) src/chr/game_logo_tiles.chr src/chr/game_logo_tiles.lz4
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
	$(RM) src/chr/*.lz4
	$(RM) *.nl
	$(RM) *.dbg
	$(RM) *.labels.txt
	$(RM) map.txt
