def speciale(sir):
    count = 0
    for i in sir:
        if i is "\r" or i is "\t" or i is "\n" or i is "\a" or i is "\b" or i is "\f" or i is "\v":
            count = count + 1
    return count

print(speciale("asdasdas\r asdasda \r \n"))