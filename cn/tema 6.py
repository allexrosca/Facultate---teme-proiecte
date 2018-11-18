import numpy as np
import scipy.stats as stats
import scipy.sparse as sparse
from numpy import linalg as alg


def citireFisier(fisier):

    with open(fisier, "r") as fisier:
        count = 0

        #   citire din fisier
        for linie in fisier:

        #   stergere newline + conditia sa se citeasca n-ul, vectorul apoi matricea
            linie = linie.strip('\n')
            if linie == "":
                count += 1

        #   citire n + initializare matrice
            if count == 0:
                n = int(linie)
                matrice = [[0 for linii in range(1)] for coloane in range(int(n))]

        # citire matrice
            elif count == 1 and linie != "":
                element = linie.split(', ')
                val = float(element[0])
                linie = int(element[1])
                coloana = int(element[2])

                if matrice[linie]==[0]:
                    matrice[linie].remove(0)
                    matrice[linie].append((val,coloana))
                else:
                    matrice[linie].append((val,coloana))

        # sortarea matricei
        for linie in range(0,n):
            for coloana in range(0,len(matrice[linie])):
                if matrice[linie][coloana][1]==linie:
                    aux = matrice[linie][coloana]
                    matrice[linie].remove(matrice[linie][coloana])
                    break
            matrice[linie].sort(key=lambda el: (el[1], el[0]))
            matrice[linie].append(aux)

        #   daca sunt mai multe valori cu aceeasi linie si coloana
        for linie in range(0, n):
            for coloana in range(1,len(matrice[linie])):
                if matrice[linie][coloana][1] == matrice[linie][coloana-1][1]:
                    matrice[linie][coloana][0] = matrice[linie][coloana][0] + matrice[linie][coloana-1][1]
                    matrice[linie].remove(matrice[linie][coloana-1])
    return matrice




def inmultireAx(A, x, n):
    for vectorAux in A:
        vectorAux.sort(key=lambda el: (el[1], el[0]))

    vector = list()
    for i in range(0, n):
        vectorAux = list()
        inmultirea = 0

        #   inmultirea intre matricea A si vectorul x
        for j in range(0, len(A[i])):
            a = A[i][j]
            inmultirea = inmultirea + a[0] * x[a[1]]

        #   pun intr-un vector auxiliar rezultatul inmultirii + indicele, pentru ca ulterior sa ordonez vectorul in functie de indici
        vectorAux.append((inmultirea, i))
        vectorAux.sort(key=lambda el: (el[1], el[0]))

        #   vectorul doar cu rezultatul inmultirii, fara indici
        for i in vectorAux:
            vector.append(i[0])

    return vector




def generareMatrice(n):

    valoriRandom = stats.norm().rvs
    matraux = sparse.random(n, n, density=0.05, data_rvs=valoriRandom)
    triungSus = sparse.triu(matraux)
    matrice = triungSus + triungSus.T - sparse.diags(matraux.diagonal())
    afisare = matrice
    matrice = matrice.toarray()

#   adaugarea valorilor intr-o matrice de tip lista in liste
    matrice2 = [[0 for x in range(1)] for y in range(n)]
    for linie in range(0,n):
        for coloana in range(0,n):
            if matrice[linie][coloana]!=0:
                valoare = matrice[linie][coloana]
                if(matrice2[linie]==[0]):
                    matrice2[linie].remove(0)
                    matrice2[linie].append((valoare,coloana))
                else:
                    matrice2[linie].append((valoare,coloana))

    # sortarea matricei
    for linie in range(0,n):
        aux=0
        for coloana in range(0,len(matrice2[linie])):
            if (matrice2[linie] == [0]):
                matrice2[linie].remove(0)
            else:
                if(matrice2[linie][coloana][1]==linie):
                    aux=matrice2[linie][coloana]
                    matrice2[linie].remove(matrice2[linie][coloana])
                    break
        matrice2[linie].sort(key=lambda tup: (tup[1], tup[0]))
        if(aux!=0):
            matrice2[linie].append(aux)

    #   test daca matricea este simetrica
    if (afisare - afisare.T).nnz == 0:
        print("\nMatricea: ")
        print(matrice2)
        print("\nMatricea este simetrica")
    else:
        print("\nMatricea nu este simetrica")
        exit()

    return matrice2



def rezolvarePutere(matrix, n):

    vaux = np.random.rand(n)
    v0 = vaux / alg.norm(vaux, 1)

    w0 = inmultireAx(matrix, v0, n)
    w0 = np.dot(v0, w0)

    y = (w0, v0)
    k = 0

    while True:
        Av = inmultireAx(matrix, v0, n)
        v1 = Av / np.linalg.norm(Av)

        w1 = inmultireAx(matrix, v1, n)
        w1 = np.dot(v1,w1)

        if np.abs(w0 - w1) < pow(10,-9) or k > 1000000:
            break

        v0 = v1
        w0 = w1
        y = (w0, v0)
        k = k + 1

    if np.abs(w0 - w1) < pow(10,-9) and k < 1000000:
        print("\nValoarea proprie a matricei: ", y[0])
        print("\nVectorul propriu asociat: ")
        print(y[1])
        print("\nNumarul de pasi: ", k)


if __name__ == "__main__":

    raspuns = input("Matrice generata automat?\n1 - da\n2 - nu\nRaspuns: ")

    if raspuns == "nu":
        matrice = citireFisier("m_rar_sim_2018.txt")
        n = len(matrice)
        print("\nMatricea citita din fisier: ")
        print(matrice)

        #   test daca matricea este simetrica
        if np.matrix(matrice).all() == np.transpose(np.matrix(matrice)).all():
            print("\nMatricea este simetrica")
            rezolvarePutere(matrice, int(n))

    elif raspuns == "da":
        n = input("\nDa-ti un numarul pentru marimea matricei: ")
        matriceGen = generareMatrice(int(n))
        rezolvarePutere(matriceGen, int(n))
