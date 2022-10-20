all:
	ca65 game.asm -g -o game.o
	ld65 -o survival.nes -C memory.cfg game.o
	rm -rf *.o
