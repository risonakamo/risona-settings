from subprocess import run
from shutil import which
from pprint import pprint
from json import dump
from os.path import realpath,dirname,join,isfile

from pydantic import BaseModel

HERE:str=dirname(realpath(__file__))
EXTENSIONS_FILE:str=join(HERE,"extensions.json")

class ExtensionsFile(BaseModel):
    extensions:list[str]

def findCodeCmd()->str:
    """find a code exe path"""

    codeExes:list[str]=[
        "code",
        "code.cmd"
    ]

    for codeExe in codeExes:
        codeExe:str

        whichRes:str|None=which(codeExe)
        if whichRes:
            return whichRes

    raise Exception("could not find code exe")

def getVscodeExtensions()->list[str]:
    """get vscode extensions as a list"""

    codeExe:str=findCodeCmd()
    res=run(f"{codeExe} --list-extensions",capture_output=True)

    return [
        x.decode("utf-8")
        for x in res.stdout.split()
    ]

def readExtensionsFile()->ExtensionsFile:
    """read extensions file into obj"""

    if not isfile(EXTENSIONS_FILE):
        return ExtensionsFile(
            extensions=[]
        )

    with open(EXTENSIONS_FILE,"r") as rfile:
        return ExtensionsFile.model_validate_json(rfile.read())

def outputExtensionsList(extensions:list[str])->None:
    """output given extension list as extension file json"""

    extensionFile:ExtensionsFile=ExtensionsFile(
        extensions=extensions
    )

    with open(EXTENSIONS_FILE,"w") as wfile:
        dump(
            extensionFile.model_dump(),
            wfile,
            indent=4
        )

if __name__=="__main__":
    extensions:list[str]=getVscodeExtensions()

    extensions.sort()

    print(len(extensions),"extensions")

    outputExtensionsList(extensions)
    print("completed")