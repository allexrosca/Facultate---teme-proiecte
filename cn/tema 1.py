import random

def problema1():
    m = 0
    while 1 + 10 ** (-m) != 1:
        m = m + 1
    return 10 ** (-m + 1)


def problema2():
    x = 1.0
    y = problema1()
    z = problema1()
    if (x + y) + z != x + (y + z):
        return True
    else:
        return False


def problema2_extra():
    count = 1
    x = random.random()
    y = random.randint(1, 100)
    z = random.randint(1, 100)
    while (x + y) + z == x + (y + z):
        count = count + 1
        x = random.random()
        y = random.randint(1, 100)
        z = random.randint(1, 100)
    return {"rez": (x, y, z), "count": count}


print("precizia masina este: ", problema1())

a = problema2()
if a is True:
    print("Operatia +c este neasociativa")
else:
    print("Operatia +c este asociativa")
b = problema2_extra()
print("Operatia *c este neasociativa pentru urmatoarele numere: ", b["rez"], "in ", b["count"], " pasi")

A = [[1, 2], [3, 4]]
B = [[5, 6], [7, 8]]
D = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
E = [[2, 2, 2], [3, 9, 3], [4, 4, 4]]
Z = [[random.randint(1, 10) for i in range(1, 9)] for j in range(1, 9)]
W = [[random.randint(1, 10) for i in range(1, 9)] for j in range(1, 9)]


def afiseaza_matrice(a):
    for i in range(0, len(a)):
        buffer = ""
        for j in range(0, len(a[i])):
            buffer = buffer + str(a[i][j]) + " "
        print(buffer)


def Strassen_2x2(a, b):
    rez = [[0, 0], [0, 0]]
    p1 = (a[0][0] + a[1][1]) * (b[0][0] + b[1][1])
    p2 = (a[1][0] + a[1][1]) * b[0][0]
    p3 = a[0][0] * (b[0][1] - b[1][1])
    p4 = a[1][1] * (b[1][0] - b[0][0])
    p5 = (a[0][0] + a[0][1]) * b[1][1]
    p6 = (a[1][0] - a[0][0]) * (b[0][0] + b[0][1])
    p7 = (a[0][1] - a[1][1]) * (b[1][0] + b[1][1])
    rez[0][0] = p1 + p4 - p5 + p7
    rez[0][1] = p3 + p5
    rez[1][0] = p2 + p4
    rez[1][1] = p1 + p3 - p2 + p6
    return rez


def adunare_matrici(a, b):
    rez = [[0 for i in range(0, len(a))] for j in range(0, len(a))]
    for i in range(0, len(a)):
        for j in range(0, len(a)):
            rez[i][j] = a[i][j] + b[i][j]
    return rez


def scadere_matrici(a, b):
    rez = [[0 for i in range(0, len(a))] for j in range(0, len(a))]
    for i in range(0, len(a)):
        for j in range(0, len(a)):
            rez[i][j] = a[i][j] - b[i][j]
    return rez


def inmultire_matrici_clasica(a, b):
    rez = [[0 for i in range(0, len(a))] for j in range(0, len(b[0]))]
    for i in range(0, len(a)):
        for j in range(0, len(a)):
            for k in range(0, len(a)):
                rez[i][j] = rez[i][j] + a[i][k] * b[k][j]
    return rez


def testare_automata(param1, param2):
    for i in range(0, len(param1)):
        for j in range(0, len(param1)):
            if param1[i][j] != param2[i][j]:
                return False
    return True


def Strassen_recursiv(a, b, n, n_min):
    rez = [[0 for i in range(0, len(a))] for j in range(0, len(a))]
    new_n = n // 2

    if n <= n_min:
        rez = inmultire_matrici_clasica(a, b)
        return rez
    else:
        a11 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # a
        a12 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # b
        a21 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # c
        a22 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # d
        b11 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # e
        b12 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # f
        b21 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # g
        b22 = [[0 for i in range(0, new_n)] for j in range(0, new_n)]  # h

        for i in range(0, new_n):
            for j in range(0, new_n):
                a11[i][j] = a[i][j]
                a12[i][j] = a[i][j + new_n]
                a21[i][j] = a[i + new_n][j]
                a22[i][j] = a[i + new_n][j + new_n]
                b11[i][j] = b[i][j]
                b12[i][j] = b[i][j + new_n]
                b21[i][j] = b[i + new_n][j]
                b22[i][j] = b[i + new_n][j + new_n]
        """
        print("+++++++")
        afiseaza_matrice(a11)
        print("*")
        afiseaza_matrice(a12)
        """

        p1 = Strassen_recursiv(adunare_matrici(a11, a22), adunare_matrici(b11, b22), new_n, n_min)
        p2 = Strassen_recursiv(adunare_matrici(a21, a22), b11, new_n, n_min) #a11 in loc de a21
        p3 = Strassen_recursiv(a11, scadere_matrici(b12, b22), new_n, n_min)
        p4 = Strassen_recursiv(a22, scadere_matrici(b21, b11), new_n, n_min)
        p5 = Strassen_recursiv(adunare_matrici(a11, a12), b22, new_n, n_min)
        p6 = Strassen_recursiv(scadere_matrici(a21, a11), adunare_matrici(b11, b12), new_n, n_min)
        p7 = Strassen_recursiv(scadere_matrici(a12, a22), adunare_matrici(b21, b22), new_n, n_min)

        rez11 = scadere_matrici(adunare_matrici(adunare_matrici(p1, p4), p7),p5) #aici era p1+p4-p5+p7 nu (p1+p4)-(p5+p7)
        rez12 = adunare_matrici(p3, p5)
        rez21 = adunare_matrici(p2, p4)
        rez22 = scadere_matrici(adunare_matrici(adunare_matrici(p1, p3), p6), p2) #la fel ca la precedenta

        for i in range(0, new_n):
            for j in range(0, new_n):
                rez[i][j] = rez11[i][j]
                rez[i][j + new_n] = rez12[i][j]
                rez[i + new_n][j] = rez21[i][j]
                rez[i + new_n][j + new_n] = rez22[i][j]
        return rez



#print("\nNormal")
#rez = inmultire_matrici_clasica(A, B)
#afiseaza_matrice(rez)

#print("\nStrassen 2x2")
#afiseaza_matrice(Strassen_2x2(A, B))

#print("\nInmultire clasica 2x2")
#afiseaza_matrice(inmultire_matrici_clasica(A, B))

#print("\nAdunare matrici")
#afiseaza_matrice(adunare_matrici(A, B))

#print("\nScadere matrici")
#afiseaza_matrice(scadere_matrici(A, B))

print("\nMatricea Z")
afiseaza_matrice(Z)

print("\nMatricea W")
afiseaza_matrice(W)

print("\nStrassen recursiv")
afiseaza_matrice(Strassen_recursiv(Z, W, 8, 2))

print("\nInmultire normala")
afiseaza_matrice(inmultire_matrici_clasica(Z, W))

print("\nTestare automata")
print("La fel: ", testare_automata(Strassen_recursiv(Z, W, 8, 1), inmultire_matrici_clasica(Z, W)))
