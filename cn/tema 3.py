import numpy as np

vector = list()


def citireFisier(file):
    matrice = [[0 for linii in range(1)] for coloane in range(2018)]

    with open(file, "r") as fisier:
        count = 0

        #   citire din fisier
        for linie in fisier:

            #   stergere newline + conditia sa se citeasca n-ul, vectorul apoi matricea
            linie = linie.strip('\n')
            if linie == "":
                count += 1

            #   citire n
            if count == 0:
                n = linie

            #   citire vector
            elif count == 1 and linie != "":
                vector.append(float(linie))

            #   citire matrice
            elif count == 2 and linie != "":
                element = linie.split(', ')
                val = float(element[0])
                linie = int(element[1])
                coloana = int(element[2])

                if matrice[linie] == [0]:
                    matrice[linie].remove(0)
                    matrice[linie].append((val, coloana))
                else:
                    matrice[linie].append((val, coloana))

        #   sortarea matricei
        for linie in range(0, 2018):
            for coloana in range(0, len(matrice[linie])):
                if matrice[linie][coloana][1] == linie:
                    aux = matrice[linie][coloana]
                    matrice[linie].remove(matrice[linie][coloana])
                    break
            matrice[linie].sort(key=lambda el: (el[1], el[0]))
            matrice[linie].append(aux)

        #   daca sunt mai multe valori cu aceeasi linie si coloana
        for linie in range(0, 2018):
            for coloana in range(1, len(matrice[linie])):
                if matrice[linie][coloana][1] == matrice[linie][coloana - 1][1]:
                    matrice[linie][coloana][0] = matrice[linie][coloana][0] + matrice[linie][coloana - 1][1]
                    matrice[linie].remove(matrice[linie][coloana - 1])

        #   verificare daca matricea are cel mult 10 elemente nenule pe fiecare linie
        flag = 1
        for linie in range(0, 2018):
            if len(matrice[linie]) > 10:
                flag = 0
                break

        if flag == 1:
            print("Sunt maxim 10 elemente nenule pe fiecare linie")
        else:
            print("Sunt mai mult de 10 elemente nenule pe fiecare linie")

        return (matrice)


def inmultireAx(A, x):
    for vectorAux in A:
        vectorAux.sort(key=lambda el: (el[1], el[0]))

    vector = list()
    for i in range(0, 2018):
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


def adunareAB(A, B):
    vector = list()
    for i in range(0, 2018):
        vectorAux = list()

        for j in range(0, len(A[i]) - 1):
            a = A[i][j]
            for k in range(0, len(B[i]) - 1):
                b = B[i][k]

            #  daca elementele se afla pe aceeasi coloana, le adun
                if a[1] == b[1]:
                    aduna = a[0] + b[0]
                    vectorAux.append((aduna, a[1]))
                    A[i].remove(a)
                    B[i].remove(b)

        #   in caz ca au ramas valori neadunate din matricea A le adaug la sfarsitul vectorului auxiliar
        for j in range(0, len(A[i]) - 1):
            a = A[i][j]
            vectorAux.append((a[0], a[1]))

        #   in caz ca au ramas valori neadunate din matricea B le adaug la sfarsitul vectorului auxiliar
        for j in range(0, len(B[i]) - 1):
            b = B[i][j]
            vectorAux.append((b[0], b[1]))

        a = A[i][len(A[i]) - 1]
        b = B[i][len(B[i]) - 1]
        vectorAux.sort(key=lambda el: (el[1], el[0]))
        vectorAux.append((a[0] + b[0], i))
        vector.append(vectorAux)

    return vector


if __name__ == "__main__":

    #   Adunarea matricelor

    print("\nAdunarea matricei A cu B: ")
    print("\nCitirea matricii A facuta cu succes, rezultatul: ")
    A = citireFisier("a.txt")

    print("\nCitirea matricii B facuta cu succes, rezultatul: ")
    B = citireFisier("b.txt")

    print("\nCitirea matricii A+B facuta cu succes, rezultatul: ")
    AB = citireFisier("aplusb.txt")
    matriceAux = adunareAB(A, B)

    # Pentru verificarea corectitudinii
    print("\nMatricea A+B din fisierul dat: ")
    print(AB[2])
    print("\nMatricea A+B calculata de functie")
    print(matriceAux[2])

    epsilon = pow(10, -5)  # eroarea cat mai mica
    for i in range(0, 2018):
        result = (abs(
            np.subtract(matriceAux[i], AB[i])) <= epsilon).all()  # daca diferenta dintre valori este mai mare ca e,
        if (result != True):                                      # inseamna ca eroarea este prea mare
            break

    print("\nMatricea A+B (din fisier) este egala cu A+B (data de functie) cu o rata de eroare cat mai mica? ->", result)
    print(
        "_________________________________________________________________________________________________________________________________________________________________")

    # Inmultirea matricei A cu vectorul x
    vector = list()

    print("\nInmultirea matricei A cu vectorul x")
    print("\nCitirea matricii A facuta cu succes, rezultatul: ")
    A = citireFisier("a.txt")
    x = [i for i in range(1, 2019).__reversed__()]  # generare automata a vectorului x

    matriceAux = inmultireAx(A, x)
    print("\nMatricea rezultata in urma inmultirii matricei A cu vectorul x: ")
    print(matriceAux)

    print("\nVectorul initial: ")
    print(vector)

    result = (abs(np.subtract(matriceAux, vector)) <= epsilon).all()
    print("\nA este egal cu vectorul initial cu o rata de eroare cat mai mica? ->", result)