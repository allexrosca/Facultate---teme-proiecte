def dreapta(n,m):
    x1, y1 = n
    x2, y2 = m
    dx = x2 - x1
    dy = y2 - y1
    a = dy
    b = -dx
    c = -x1 * dy + y1 * dx
    return (a, b, c) if a > 0 else (-a, -b, -c)

def linii(puncte):
    x = []
    for i in range(len(puncte)-1):
        for j in range(i, len(puncte)):
            t = dreapta(puncte[i],puncte[j])
            if t not in x:
                x.append(t)
    return x

print(linii([(1, 2), [2, 4], [1, 2]]))