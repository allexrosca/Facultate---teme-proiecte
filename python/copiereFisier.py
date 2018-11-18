import os


def copiere(pathFisier,pathDir,buffer):
    f = open(pathFisier,"rb",buffering= buffer)
    fisier = os.path.basename(pathFisier)
    g = open(pathDir + "\\" + fisier,"wb",buffering = buffer)
    for i in f:
        g.write(i)


copiere("E:\\fuckultate\\pmp\\FigaroWork\\README.txt","E:\\fuckultate\\python",8)



