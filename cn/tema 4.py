import math


b=[]
n=0
def citireFisier(fisier):

    with open(fisier, "r") as fisier:
        count = 0

        #   citire din fisier
        for linie in fisier:

        #   stergere newline + conditia sa se citeasca n-ul, vectorul apoi matricea
            linie = linie.strip('\n')
            if linie == "":
                count += 1

        #   citire n + initializare vector
            if count == 0:
                n = int(linie)
                vector = [[0 for linii in range(1)] for coloane in range(int(n))]

        #   citire vector
            elif count == 1 and linie != "":
                b.append(float(linie))

        # citire matrice
            elif count == 2 and linie != "":
                element = linie.split(', ')
                val = float(element[0])
                linie = int(element[1])
                coloana = int(element[2])

                if vector[linie]==[0]:
                    vector[linie].remove(0)
                    vector[linie].append((val,coloana))
                else:
                    vector[linie].append((val,coloana))

        # sortarea matricei
        for linie in range(0,n):
            for coloana in range(0,len(vector[linie])):

                if vector[linie][coloana][1]==linie:
                    aux=vector[linie][coloana]
                    vector[linie].remove(vector[linie][coloana])
                    break

            vector[linie].sort(key=lambda el: (el[1], el[0]))
            vector[linie].append(aux)

        #   daca sunt mai multe valori cu aceeasi linie si coloana
        for linie in range(0, n):
            for coloana in range(1,len(vector[linie])):
                if vector[linie][coloana][1] == vector[linie][coloana-1][1]:
                    vector[linie][coloana][0] = vector[linie][coloana][0] + vector[linie][coloana-1][1]
                    vector[linie].remove(vector[linie][coloana-1])

        #   verificare daca matricea are cel mult 10 elemente nenule pe fiecare linie
        flag = 1
        for linie in range(0, n):
            if len(vector[linie])>10:
                flag=0
                break
        if flag==1:
            print("Sunt maxim 10 elemente nenule pe fiecare linie")
        else:
            print("Sunt mai mult de 10 elemente nenule pe fiecare linie")
        return (vector,n)


def inmultireAx(A, x):

    for vectorAux in A:
        vectorAux.sort(key=lambda el: (el[1], el[0]))

    vector=list()
    for i in range(0,n):
        vectorAux = list()
        inmultirea = 0

        #   inmultirea intre matricea A si vectorul x
        for j in range(0, len(A[i])):
            a = A[i][j]
            inmultirea = inmultirea + a[0]*x[a[1]]

        #   pun intr-un vector auxiliar rezultatul inmultirii + indicele, pentru ca ulterior sa ordonez vectorul in functie de indici        vectorAux.append((inmultirea,i))
        vectorAux.append((inmultirea, i))
        vectorAux.sort(key=lambda el: (el[1], el[0]))

        #   vectorul doar cu rezultatul inmultirii, fara indici
        for i in vectorAux:
            vector.append(i[0])

    return vector



def calcNorma(xc, xp, n):
    suma = 0
    for i in range(n):
        suma = suma + pow((xc[i] - xp[i]), 2)
    suma = math.sqrt(suma)

    return suma



def solve(matrice):
    #   initializari
    xc = [0 for i in range(0,n+1)]
    k = 0

    #   bucla do-while
    while True:
        xp = xc[:]

        for i in range(0,n):
            suma1 = 0
            suma2 = 0

    #   formarea variabilelor pentru formula (3)
            for j in range(0, len(matrice[i]) - 1):
                element = matrice[i][j]
                coloana = element[1]
                valoare = element[0]

            #   prima suma din formula
                if coloana < i:
                    suma1 = suma1 + valoare * xp[coloana]

            #   a doua suma in formula
                elif coloana >= i:
                    suma2 = suma2 + valoare * xc[coloana]

            #   a[i][i]
            diag = matrice[i][len(matrice[i]) - 1][0]

            #   calcularea efectiva a formulei
            xc[i] = (b[i] - suma1 - suma2) / diag

        #   norma xc - xp
        dx = calcNorma(xp, xc, n)

        k = k + 1

        #   conditia de oprire a buclei (ca in cerinta)
        if not (dx >= epsilon and k <= kmax and dx <= conditie):
            break

    if dx < epsilon:
        print("\nSolutia sistemului este:",xc)
        print( "_______________________________________________________________________________________________________________________________")

        print("\nNumarul de iteratii efectuate:",k)
        print( "_______________________________________________________________________________________________________________________________")

    #   verificare
        x = inmultireAx(matrice, xc)
        dx = calcNorma(x, b, n)
        print("\nRata erorii (verificarea) este de:", dx)
        print( "_______________________________________________________________________________________________________________________________")

    else:
        print("\nDivergenta")



if __name__ == "__main__":

    #   initializarile din cerinta
    kmax = 10000
    print("_______________________________________________________________________________________________________________________________")
    p = int(input("\nDati o valoare pt epsilon: "))
    epsilon = pow(10, -p)
    conditie = pow(10, 8)

    #   citirea matricii din fisier
    flag = 1
    print("_______________________________________________________________________________________________________________________________")
    print("\nCitirea matricii facuta cu succes, rezultatul: ")
    citit = citireFisier("m_rar_2018_1.txt")
    matrice = citit[0]
    n = int(citit[1])
    print("_______________________________________________________________________________________________________________________________")

    #   verificare diagonalei principale sa fie != 0
    for i in range(0, n):
        diag = matrice[i][len(matrice[i]) - 1][0]
        if diag == 0:
            flag=0
            break

    if flag == 1:
        solve(matrice)
    else:
        print("\nNu se poate rezolva")