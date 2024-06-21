# nes_survival aka Cold and Starving
A survival game for the NES and Famicom. The game uses the UNROM mapper.


To build the game you will need cc65 and make, also python and lz4.

How to get the needed packages on a debian based **Linux** distro: 

<code>sudo apt install cc65 make python3 lz4</code>

On **Windows** you will have to download and install a cc65 snapshot from:

https://sourceforge.net/projects/cc65/

Make for windows:

http://gnuwin32.sourceforge.net/packages/make.htm

LZ4

https://github.com/lz4/lz4/releases

Don't forget to add cc65, lz4, and make bin folders to your environment variable *PATH*

Install Python from Microsoft store by typing *Python* inside the windows power shell. 


After everything is installed, clone the repository, enter its directory ant run:

<code>make</code>

The result will be the **Cold & Starving(USA, Japan).nes** and **Cold & Starving(Europe).nes** roms.  

Use them on an emulator of your choise(preferably MESEN) or play on a real hardware using a flash cartridge. 
