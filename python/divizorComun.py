def divizorComun2(a,b):
      while a is not b:
            if a > b:
                  a = a - b
            else:
                  b = b - a
      return a


def divizorComun(*numere):
      max = 0
      x = []
      for numar in numere:
            x.append(numar)
      x.sort()
      a = divizorComun2(x[0], x[1])
      for i in x[1:]:
            y = divizorComun2(a, i)
            if y > max:
                max = y
      return max

print (divizorComun(2, 4, 6, 8, 10, 58, 12, 100))