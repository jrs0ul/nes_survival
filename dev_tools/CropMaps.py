#!/usr/bin/env python3
import sys
assert sys.version_info[0] >= 3, "Python 3 required."

map_files = [
            "field_bg.asm",
            "field_bg1.asm",
            "field_bg2.asm",
            "field_bg4.asm",
            "LOC3_bg1.asm",
            "LOC3_bg0.asm",
            "house.asm",
            "villager_hut.asm",
            "villager2_hut.asm",
            "grannys_hut.asm",
            "alien_bossroom.asm",
            "alien_base1.asm",
            "alien_base2.asm",
            "pre_alien_base0.asm",
            "pre_alien_base1.asm",
            "pre_alien_base2.asm",
            "mine_0.asm",
            "mine_1.asm",
            "mine_2.asm",
            "dark_cave0.asm",
            "dark_cave1.asm",
            "dark_cave2_0.asm",
            "dark_cave2_1.asm",
            "dark_cave2_2.asm",
            "babloc1.asm",
            "babloc2.asm",
            "babloc3.asm",
            "field2_bg.asm",
            "field2_bg1.asm",
            "crashsite0.asm",
            "crashsite1.asm",
            "crashsite2.asm",
            "location_with_cave0.asm",
            "location_with_cave1.asm",
            "location_with_cave2.asm",
            "location_with_cave3.asm",
            "secret_cave0.asm",
            "mine_room.asm",
            "alien_base_lobby.asm",
            "path_to_crashsite.asm",
            "lonely_cave.asm",
            "wood_location_0.asm",
            "wood_location_1.asm"
            ]

map_path = "src/data/maps/"

indoor_maps = [
              "mine_room.asm",
              "house.asm",
              "villager_hut.asm",
              "villager2_hut.asm",
              "grannys_hut.asm",
              "alien_bossroom.asm"
              ]

def crop_maps():

    lines = []

    for fileName in map_files:

        try:
            fileIN = open(map_path + fileName)
            lines = fileIN.readlines()
        except IOError:
            print("********* a FAILURE while reading [" + map_path + fileName + "] ! ************")
            return

        dataOut = ""

        isIndoorMap = fileName in indoor_maps

        for i in range(len(lines)):
            if isIndoorMap :
                if (i < 1 or i > 8) and (i < 45 or i > 58) :
                    dataOut += lines[i]
            else:
                if (i < 1 or i > 8) :
                    dataOut += lines[i]


        nameArray = fileName.split('.')
        fileOut = open(map_path + "/cropped/" + nameArray[0] + "_crop.asm", "wt").write(dataOut)


if __name__ == "__main__":
    crop_maps()
