from itertools import combinations

def combinari(x, k):
    return list(combinations(x, k))

print(combinari([1,2,3,4],3))