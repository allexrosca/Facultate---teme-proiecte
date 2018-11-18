import numpy as np


def gaussPivotPartial(A, b, e):
    n = len(A)

# verificare erori
    if b.size != n:
        print("Argument invalid: marimi incompatibile intre" + "A & b.", b.size, n)

    for l in range(n - 1):

# cautarea pivotului
        maxindex = abs(A[l:, l]).argmax() + l

# testul pentru matricea singulara
        if A[maxindex, l] == 0:
            raise ValueError("Matricea este singulara.")

# interschimbarea liniilor in matrice si a componentelor in vector
        if maxindex != l:
            A[[l, maxindex]] = A[[maxindex, l]]
            b[[l, maxindex]] = b[[maxindex, l]]

# testarea elementului pivot
        if A[l, l] == 0:
            raise ValueError("Elementul pivot este 0.")

# pasii (5) (6) (7)
        for linie in range(l + 1, n):
            aux = A[linie, l] / A[l, l]
            A[linie, l:] = A[linie, l:] - aux * A[l, l:]
            b[linie] = b[linie] - aux * b[l]

# testul pentru matricea singulara
    if np.less_equal(abs(A[l][l]),int(e)):
        print("Matrice singulara.")
        return "nasol"

# calcularea x-ului din ecuatie
    x = np.zeros(n)
    for l in range(n - 1, -1, -1):
        x[l] = (b[l] - np.dot(A[l, l + 1:], x[l + 1:])) / A[l, l]

    return x


# verificarea cu ajutorul librariei numpy
def verificare(A,b):
    return np.linalg.solve(A,b)



if __name__ == "__main__":

    e = input("Dati o valoare pentru E: ")
# matricea A
    A = np.array([[1., -1., 1., -1.], [1., 0., 0., 0.], [1., 1., 1., 1.], [1., 2., 4., 8.]])
   # A = np.random.rand(10,10)
    AInit = np.array([[1., -1., 1., -1.], [1., 0., 0., 0.], [1., 1., 1., 1.], [1., 2., 4., 8.]])
   # AInit = np.random.rand(10, 10)
    print("\nMatricea: \n", A)

#inversa matricei A
    print("\nInversa matricei A: \n", np.linalg.inv(A))


# vectorul b
    b = np.array([[14.], [4.], [2.], [2.]])
   # b = np.random.rand(10)
    bInit = np.array([[14.], [4.], [2.], [2.]])
   # bInit = np.random.rand(10)
    print("\nVectorul: \n", b)

# solutia sistemului
    if gaussPivotPartial(A, b, e) is "nasol":
        exit(1)
    else:
        print("\nSolutia sistemului este: ", gaussPivotPartial(A, b, e))

    rez = gaussPivotPartial(A, b, e)
    verif = verificare(A,b)

# verificarea solutiei data de algoritm cu cea a algoritmului din libraria numpy
    gresit = 0
    for i in range(len(verif)):
        if verif[i].item() != rez[i]:
            gresit = gresit + 1
    if gresit is 0:
        print("Solutia este corecta.")
    else:
        print("Solutia nu este corecta.")

# cerinta b
    bInitLista = []
    for i in range(len(bInit)):
        bInitLista.append(bInit[i].item())

    print("\nRezultatul ||A^init * x.Gauss - b^init||.2 : \n",abs(np.subtract(AInit.dot(rez),bInitLista)))


# cerinta c
    lista = []
    for i in range(len(verif)):
        x = rez[i] - verif[i]
        lista.append(abs(x.item()))
    print("\nRezultatul ||x.Gauss - x.lib||.2 : \n", lista)

# cerinta d
    print("\nRezultatul ||x.Gauss - A.lib^(-1) * b.init||.2 : \n", abs(np.subtract(rez,np.linalg.inv(AInit).dot(bInitLista))))
	
	
	
	
	
	
	
