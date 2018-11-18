def fib(n):
    if n is 0:
        return 0
    elif n is 1:
        return 1
    else:
        return fib(n-2) + fib(n-1)




def fibList(n):
    x = []
    for i in range(0,n+1):
        x.append(fib(i))
    return x


print(fibList(10))