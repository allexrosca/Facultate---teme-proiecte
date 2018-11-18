def kindofFind(toFind, str):
    count = 0
    str = str.replace(toFind,"±")
    for i in str:
        if i is "±":
            count = count + 1
    return count

#sau functia count


print(kindofFind("asd", "asd-.asd?12d31a24123asd312s3"))