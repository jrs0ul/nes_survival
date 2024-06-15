#!/usr/bin/env python3
import sys
assert sys.version_info[0] >= 3, "Python 3 required."

lz4_files = [
            "title.lz4",
            "intro.lz4",
            "house_bg_tiles.lz4",
            "alien_bg_tiles.lz4",
            "main_sprites.lz4",
            "alien_sprites.lz4",
            "house_sprites.lz4",
            "font.lz4",
            "main_bg_tiles.lz4",
            "crashed_plane_tiles.lz4",
            "title_tiles.lz4",
            "gameover_tiles.lz4",
                        ]


def crop_lz4():

    data = []

    for fileName in lz4_files:

        try:
            fileIN = open("src/" + fileName, "rb")
            data = fileIN.read()
            fileIN.close()
        except IOError:
            print("********* a FAILURE while reading [src/" + fileName + "] ! ************")
            return

        length = len(data)
        print(fileName + " " + str(length))
        newLen = length - 11 - 4
        cropped = data[11:]
        finalCrop = cropped[:newLen]



        fileOut = open("src/" + fileName, "wb").write(finalCrop)


if __name__ == "__main__":
    crop_lz4()
