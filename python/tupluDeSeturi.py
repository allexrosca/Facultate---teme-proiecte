def tupluDeSeturi(a,b):
    a = set(a)
    b = set(b)
    return (set(a | b),set(a & b), set(a - b), set(b - a))


print(multimiSeturi([7,4,67,3,2,7,9],[7,9,2,4,5,3]))