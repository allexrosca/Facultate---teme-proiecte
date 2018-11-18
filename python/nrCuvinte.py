def cuvinte(str):
    count = 0
    str = str.replace("?", " ")
    str = str.replace(".", " ")
    str = str.replace("!", " ")
    str = str.replace(",", " ")
    str = str.replace(";", " ")
    for i in str.split(" "):
        count = count + 1
    return count

print(cuvinte("asd.asd;asd?asd!asd"))