def intersectie(a,b):
    x = []
    for i in a:
        for j in b:
            if i is j:
                x.append(i)
    return x

def reuniune(a,b):
    x = []
    for i in a:
        x.append(i)
    for i in b:
        if i not in intersectie(a,b):
            x.append(i)
    return x

def aMinusb(a,b):
    x = []
    for i in a:
        if i not in intersectie(a,b):
            x.append(i)
    return x

def bMinusa(a,b):
    x = []
    for i in b:
        if i not in intersectie(a,b):
            x.append(i)
    return x


def multimi(a,b):
    print(intersectie(a,b))
    print(reuniune(a, b))
    print(aMinusb(a, b))
    print(bMinusa(a, b))


multimi([2,6,3,6,3,3,76,1],[5,8,7,4,58,541,8,5,2])