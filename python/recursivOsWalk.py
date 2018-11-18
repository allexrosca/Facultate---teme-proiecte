import os

def speranta(path,fisierNume):
    f = open(fisierNume,"w")
    for (root, directories, files) in os.walk(path):
        for fileName in files:
            full_fileName = os.path.join(root, fileName)
            if os.path.isfile(full_fileName) is True:
                f.write(full_fileName + "|" + "FILE" + "\n")
            else:
                f.write(full_fileName + "|" + "UNKOWN" + "\n")
        for fileName in directories:
            full_fileName = os.path.join(root, fileName)
            if os.path.isdir(full_fileName) is True:
                f.write(full_fileName + "|" + "DIRECTORY" + "\n")
            else:
                f.write(full_fileName + "|" + "UNKOWN" + "\n")



speranta("E:\\fuckultate\\python", "E:\\fuckultate\\python\\fisier.txt")