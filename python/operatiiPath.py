import os


def operatiiPath(path):
    try:
        if os.path.isfile(path) is True:
            f = open(path,"rb").read(4049)
            print(f)
        if os.path.isdir(path) is True:
            for (root, directories, files) in os.walk("."):
                for fileName in files:
                    full_fileName = os.path.join(root, fileName)
                    print(full_fileName)
        if os.path.exists(path) is False:
            raise Exception("path nu bun")
    except Exception as e:
        print(e)


operatiiPath("asdasd")