import numpy as np


def metoda1(a,n,v1,e,kmax):
    k = 0

#   bucla do-while din algoritm
    while(True):
        v0 = v1

    #   calculul lui v1 in functie de v0 dupa formula (1)
        v1 = np.dot(v0, np.subtract(np.dot(2,np.identity(n)), np.dot(a,v0)))

    #   calculul normei lui delta v
        dv = np.linalg.norm(np.subtract(v1,v0))

    #   numararea pasilor
        k = k + 1

    #   conditia de iesire din bucla do-while
        if float(dv) < e or k >= kmax or dv >= pow(10,10):
            break

    if(dv < e):
        print("_____________________________________________________________________________________________________________________")
        print("\n                            |─────────────|")
        print("                            | Metoda 1: |")
        print("                            |─────────────|")
        print("\nSolutia aproximata: \n",v1)
        print("\nNumarul de pasi: ",k)
        print("\nNorma pentru verificare: ",np.linalg.norm(np.subtract(np.dot(a,v1), np.identity(n))))
    else:
        print("Divergenta")




def metoda2(a,n,v1,e,kmax):
    k = 0

#   bucla do-while din algoritm
    while (True):
        v0 = v1

    #   calculul lui v1 in functie de v0 dupa formula (2)
        v1 = np.dot(v0, np.subtract(np.dot(3,np.identity(n)), np.dot(np.dot(a,v0), np.subtract(np.dot(3,np.identity(n)),np.dot(a,v0)))))

    #   calculul normei lui delta v
        dv = np.linalg.norm(np.subtract(v1, v0))

    #   numararea pasilor
        k = k + 1

    #   conditia de iesire din bucla do-while
        if float(dv) < e or k >= kmax or dv >= pow(10, 10):
            break

    if(dv < e):
        print("\n_____________________________________________________________________________________________________________________")
        print("\n                            |─────────────|")
        print("                            | Metoda 2: |")
        print("                            |─────────────|")
        print("\nSolutia aproximata: \n",v1)
        print("\nNumarul de pasi: ",k)
        print("\nNorma pentru verificare: ",np.linalg.norm(np.subtract(np.dot(a,v1), np.identity(n))))
    else:
        print("Divergenta")




def metoda3(a,n,v1,e,kmax):
    k = 0

    #   bucla do-while din algoritm
    while (True):
        v0 = v1

        #   calculul lui v1 in functie de v0 dupa formula (3)
        v1 = np.dot(np.add(np.identity(n),np.dot(np.dot(1/4,np.subtract(np.identity(n),np.dot(v0,a))),pow(np.subtract(np.dot(3,np.identity(n)),np.dot(v0,a)),2))), v0)

        #   calculul normei lui delta v
        dv = np.linalg.norm(np.subtract(v1, v0))

        #   numararea pasilor
        k = k + 1

        #   conditia de iesire din bucla do-while
        if float(dv) < e or k >= kmax or dv >= pow(10, 10):
            break

    if(dv < e):
        print("\n_____________________________________________________________________________________________________________________")
        print("\n                            |─────────────|")
        print("                            | Metoda 3: |")
        print("                            |─────────────|")
        print("\nSolutia aproximata: \n",v1)
        print("\nNumarul de pasi: ",k)
        print("\nNorma pentru verificare: ",np.linalg.norm(np.subtract(np.dot(a,v1), np.identity(n))))
        print("\n_____________________________________________________________________________________________________________________")
    else:
        print("Divergenta")




def metodaIterativa(n,e,kmax):

#   initializarea matricei A
    A = [[0 for i in range(n)] for j in range(n)]

#   crearea matricei A
    for i in range(0, n):
        for j in range(0, n):
            if i == j:
                A[i][j] = 1
                if j < n - 1:
                    A[i][j + 1] = 4
    a = np.matrix(A)

#   calcularea lui A1 si Ainf dupa formulele (6)
    a1 = max(abs(a.sum(axis = 1)))
    a2 = max(abs(a.transpose().sum(axis = 1)))

#   calcularea lui V0 dupa formula (5)
    v0 = v1 = np.divide(a.transpose(),np.dot(a1, a2))

    metoda1(a,n,v1,e,kmax)
    metoda2(a,n,v1,e,kmax)
    metoda3(a,n,v1,e,kmax)


if __name__ == "__main__":
    print("\nStart program")
    n = input("\nDati o valoare pentru marimea matricei: ")
    if int(n) < 0:
        print("whaaaa.....???")
    else:
        putere = input("\nDati o valoare pentru puterea lui 10 (negativa): ")
        if int(putere) > 0:
            print("NEGATIVA!!!")
        else:
            metodaIterativa(int(n),pow(10,int(putere)),10000)
