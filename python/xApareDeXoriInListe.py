def aparitii(*args,x):
     a = sum(args,[])
     return [e for e in set(a) if a.count(e) is x]


print(aparitii([1, 2, 3], [2, 3, 4], [4, 5, 6], [4, True, "test"], x=2))
