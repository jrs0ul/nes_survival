#!/usr/bin/env python3
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
