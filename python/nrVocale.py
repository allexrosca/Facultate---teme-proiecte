def vocale(sir):
    count = 0
    for i in sir:
        if i in "AEIOUaeiou":
            count = count + 1
    return count
print(vocale("aaikdnjwoaiej"))