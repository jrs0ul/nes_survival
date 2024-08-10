#!/usr/bin/env python3
#python ConvertBytes.py '$00,$00,$00,$00,$42,$5a,$5a,$5a,$00,$50,$3a,$42,$4d,$3e,$3d,$5a'
import sys
assert sys.version_info[0] >= 3, "Python 3 required."

def convert_bytes():
    dataLine = sys.argv[1]
    byteArray = dataLine.split(',')

    outPut = ""
    for strByte in byteArray:
        litteral = "0x" + strByte.strip("$ ")
        num = int(litteral, 16)


        if num == 0 :
            outPut += "$0"+str(num) + ","
        else:
            num -= 47
            outPut += "$" + hex(num)[2:] + ","
    print(outPut)



if __name__ == "__main__":
    convert_bytes()
