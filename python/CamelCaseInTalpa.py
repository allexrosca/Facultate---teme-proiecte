def convert(str):
    for i in str:
        if ord(i) >= 65 and ord(i) <=90 and i is not str[0] and i is not str[len(str)-1]:
            str = str.replace(i, "_"+i.lower())
        if i is str[0] or i is str[len(str)-1]:
            str = str.replace(i, i.lower())
    return str

print(convert("sdZamaDeLamaie"))