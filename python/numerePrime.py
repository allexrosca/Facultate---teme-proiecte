def prim(numar):
    for i in range(2,numar-1):
        if numar % i == 0:
            return False
    return True

def listaPrim(numere):
    x = []
    for i in numere:
        if prim(i) is True:
            x.append(i)
    return x


print(listaPrim([1,8,3,7,8,5,7,56,21,8,65,52]))