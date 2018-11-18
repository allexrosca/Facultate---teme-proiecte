#doar in pythonRE 3: from functools import reduce -> pentru functia de reduce

from re import findall 
                                                                          
s = "Hello python"
n = 3
v = [1, 2, "trei"]
d = {'unu':'continut', 'doi':'blabla'}
#Nu poate fi suprascris v[1] din cauza imutabilitatii
#print v[1]
#print d['unu']
#corpurile functiilor -> aliniere
#mai multi parametri -> '*' (face un vector in spate);

"""def cmmdc(*args):
    print(args)"""

"""for-ul itereaza prin colectii"""

def cmmdc2(a, b):
    while b:
        a, b = b, a%b
    return a

"""Daca este prea lunga linia putem pune \ si continua de pe al doilea rand"""

def cmmdc(*args):
    #for a in range(len(args)) -> genereaza o lista in spate;
    index = 1
    rez = args[0]
    args1 = args[1:] #->o lista de la primul caracter pana la sfarsit
    for a in args1:
    #while index < len(args):
    #args[index] pentru while
        rez = cmmdc2(rez, a) 
    #   index += 1
    return rez

#print cmmdc(10, 5, 15)


"""def cmmdc(*args):
    return reduce(cmmdc2, args)"""  #ia rezultatul functiei ca pe element curent 
  

"""Numarul de vocale dintr-un sir"""
def nr_vocale(s):
    vocale = ['a', 'e', 'i', 'o', 'u']   #sau vocale = [aeiouAEIOU]
    #vocale_in_text = ''
    #list comprehension
    vocale_in_text = [c for c in s if c.lower() in vocale] 
    nr = 0
    """for c in s:
        if c.lower() in vocale: #element de apartenenta -> verifica daca elementul apartine colectiei
            nr += 1
            vocale_in_text += c"""
    #return len(vocale_in_text)
    print(sum(map(s.lower().count, 'aeiou')))
    #return s.count('a') + s.count('e')

#nr_vocale('ana')


"""Numarul de cuvinte dintr-un string"""
#print('an?a are ....mere.. '.replace('.', ' ').replace('?', ' ').split()) #default functioneaza pe stringuri empty; pentru spatii stie sa ia doar cuvintele; daca am mai multe semne de punctuatie, '...' imi va returna si puncte, motiv pt care facem mai intai replace

def nrcuv(s):
    for semn in '?!.;,':
        s = s.replace(semn, ' ')
    return len(s.split())

def rep(s, c):
    return s.replace(c, ' ')

def nrcuv(s):
    return len(reduce, [s] + list('?!.'))


"""substring occurences with count"""
def substrOcc(s, q):
    return s.count(q)

#print(substrOcc("ana are ana", "ana"))

"""substring occurences with index"""
def subOcc(s, q):
    i = 0
    count = 0
    for i in range(len(s) - len(q) + 1):
        if (s[i:i+len(q)] == q):
            count+=1
    return count

#print(subOcc("ananas are ana", "ana"))

def f(x):
  y0 = x + 1
  y1 = x * 3
  y2 = y0 ** y3
  return (y0,y1,y2)


"""Problema 8"""
#eval -> for functions; power: **;
print(eval('2**10'))

#print('--sir--'.join(l))
def func(x):
    l = "3x^3 + 5x^2 - 2x - 5".split("x")  
     #l = l[:-1]
    s = ''
    for term in l[:-1]:
        if term[-1].isdigit():
            #print(term, '*')
            s += term + '*'
        else:
            #print(term)
            s += term
        s+=str(x)
    s += l[-1]
    s = s.replace('^', '**')
    return eval(s)

#print func(5)

s =  'ahsfaisd35biaishai23isisvdshcbsi271cidsbfsd97sidsda' 
print(findall('\d+', s));
print([int(e) for e in findall('\d+', s)])

#[e for e in colectie in criteriu(e)]







        
    