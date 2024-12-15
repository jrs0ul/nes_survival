#!/usr/bin/env python3
import sys
import math
assert sys.version_info[0] >= 3, "Python 3 required."



def calc_diag():
    intPart = 0
    fraction = 0
    print("Enter NTSC integer part:")
    intPart = int(input())
    print("Enter NTSC fraction in 1/256 units:")
    fraction = int(input())
    speed = fraction / 256.0 + float(intPart)
    diagonalSpeed = float(math.sqrt(speed * speed / 2.0))
    diagonalFrac = float(diagonalSpeed - int(diagonalSpeed));
    diagonalFraction = math.ceil(diagonalFrac * 256.0);
    print("diagonal speed: " + str(diagonalSpeed));
    print("in bytes: " + str(int(diagonalSpeed)) + " " + str(diagonalFraction));
    print("PAL conversion")
    speed *= 1.2
    diagonalSpeed *= 1.2
    palFrac = speed - int(speed)
    #print("PAL diagonal speed" + str(diagonalSpeed))
    dPalFrac = diagonalSpeed - int(diagonalSpeed)
    intDParlFrac = math.ceil(dPalFrac * 256.0)
    intPalFrac = math.ceil(palFrac * 256.0)
    print("regular :" + str(int(speed - palFrac)) + " " + str(intPalFrac) )
    print("diagonal :" + str(int(diagonalSpeed - dPalFrac)) + " " + str(intDParlFrac))


if __name__ == "__main__":
    calc_diag()
