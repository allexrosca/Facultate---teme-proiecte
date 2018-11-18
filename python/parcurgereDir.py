import os

def parcurgere(path):
    try:
        for i in os.listdir(path):
            full_fileName = os.path.join(path, i)
            if os.path.isfile(full_fileName):
                print (full_fileName)
            elif os.path.isdir(full_fileName):
                print (full_fileName)
                parcurgere(full_fileName)
            else:
                raise Exception
    except Exception as e:
        print(e)



parcurgere("E:\\Deadpool")