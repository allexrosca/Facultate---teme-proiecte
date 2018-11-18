def sperSaMearga(a,b):
    z = {e for e in a if e in b and a[e]!=b[e]}
    x = {e for e in a if e not in b}
    c = {e for e in b if e not in a}
    return (z,x,c)


print(sperSaMearga({'A': 1, 'n': 21, 'a': 2, 'r': 2, 'e': 3, 'J': 44}, {'n': 3, 'e': 3}))