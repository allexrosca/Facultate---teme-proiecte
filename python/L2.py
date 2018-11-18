from itertools import zip_longest

def F(n):       
    if n == 0: return 0
    elif n == 1: return 1
    else: return F(n-1)+F(n-2)


def F2(n):
    count = 0
    n1 = 0
    n2 = 1
    while count < n:
        print(n1,end=' , ')
        nth = n1 + n2
        n1 = n2
        n2 = nth
        count += 1

#F(10)
 
#default par: if it is going to be changed in the function it will be altered  
#Recursiv, dar nu este ineficient
def fib(n, l=[0,1]):
    try:  
        return l[n]
    except:
        l.append(fib(n-1) + fib(n-2))
        return l[n]

def isPrime(x):
    for a in range(2,x-1):
        if x%a == 0: 
            return False;
    return True;

def line2p(p1, p2):
    x1, y1 = p1
    x2, y2 = p2
    dx = (x2 - x1)
    dy = y2 - y1
    a = dy
    b = -dx
    c = -x1 * dy + y1 * dx

    return (a, b, c) if a > 0 else (-a, -b, -c)


def lines(ls):
    rez = []
    for i in range(len(ls) - 1):
        for j in range(i, len(ls)):
            t = line2p(ls[i], ls[j])
            if t not in rez:
                rez += [t]
    return rez


#print(lines([(1, 2), [2, 4], [1, 2]]))

def isprime(n):
    return len([d for d in range(1, n + 1) if n % d == 0]) == 2


def primes(ls):
    return [x for x in ls if isprime(x)]

#print(primes([1, 2, 3, 5, 13]))

def multimi(a, b):
    a, b = set(a), set(b)
    return list(a | b), list(a & b), list(a - b), list(b - a)

#print(multimi([1, 2, 3, 4], [3, 4, 5, 6])) 
###Pentru combinari -> itertools###

from itertools import combinations


def combinari(x, k):
    return list(combinations(x, k))


print(combinari([1, 2, 3, 4], 3))


def numar(*args, x):
    toate = sum(args, [])
    return [e for e in set(toate) if toate.count(e) == x]


print(numar([1, 2, 3], [2, 3, 4], [4, 5, 6], [4, True, "test"], x=2))

"""
def div_cifre(x = 1, flag = True, *args):
    return [[c for c in s if ord(x) % x != flag] for s in args]

def div_cifre(*args):
    x, flag = 1, True
    if type(args[0]) == int:
        x, i1 = args[0], 1
    if type(args[-1]) == bool: 
        flag, i2 = args[-1], 1
    siruri = args[i1:i2]  
    return [[c for c in s if ord(x) % x != flag] for s in args]
"""
#p7:

def div_cifre(*args):
    a = list(args)
    x, flag = 1, True
    if type(a[0]) == int:
        x = a.pop(0)
    if type(a[-1]) == bool:
        flag = a.pop(-1)

    return [[c for c in s if ord(c) % x != flag] for s in a]


print(div_cifre(2, "test", "hello", "lab002", False))

#p8
print(list(zip_longest([1, 2, 3, None], [5, 6], ["a", "b", "c"], fillvalue='piton'))) 

#p9
"""
def l3e2(x):
    return x[1][2] 
def poz3(x):
    return x[2]

l = [('abc', 'bcd'), ('abc', 'zza')]
l.sort(key = l3e2)
l.sort(key = lamda c:c[2])
print (l)
"""
def l3e2(x):
    return x[1][2]


def poz3(x):
    return x[2]


l = [('abc', 'bcd', 2, 'ASD', 343),
     ('asd', 'abc', 1267), ('abc', 'zza', 4, 'xcv')]
l.sort(key=lambda c: c[2])
print(l)

"""O functie care isi salveaza mereu starea interna"""
def fib(n):
    i = 0
    a, b = 0, 1
    while i < n:
        yield b
        a, b = b, a+b
        i += 1
    return a

for e in fib(6):
    print(e) 

"""print ([fib(i) for i in range(6)])"""
o = fib(6)
print(dir(o))    
###In spate -> next   

"""
def fib(n):
    i = 0
    a, b = 0, 1
    while i < n:
        yield b
        a, b = b, a + b
        i += 1


o = fib(6)
print(o.__next__())
print(o.__next__())
print(o.__next__())


def fib(n):
    return 'da'


print(o.__next__())
print(o.__next__())
"""   