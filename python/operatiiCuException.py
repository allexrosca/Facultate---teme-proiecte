def operatii():
    try:
        x = int(input())
        y = int(input())
        return x+y, x-y, x/y, x*y
    except:
        print("nasol")



print(operatii())