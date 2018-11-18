import os
def scriere():
    try:
        path = input("va rog introduceti pizda lu mama ")
        if os.path.exists(path):
            raise Exception("puli")
        f = open(path,"w")
        for key in os.environ:
            f.write(str(key) + "\t" + str(os.environ[key]) + "\n")
    except Exception as e:
        print(e)

scriere()