x = {
    "+": lambda a, b: a + b,
    "*": lambda a, b: a * b,
    "/": lambda a, b: a / b,
    "%": lambda a, b: a % b
}

def apply_operator(operator, a, b):
    return x[operator](a, b)



print (apply_operator('*',5,5))