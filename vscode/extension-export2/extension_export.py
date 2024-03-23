from subprocess import run
from shutil import which
from pprint import pprint
from json import dump
from os.path import realpath,dirname,join,isfile
from devtools import debug

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

def readExtensionsFile(file:str)->ExtensionsFile:
    """read extensions file into obj"""

    if not isfile(file):
        return ExtensionsFile(
            extensions=[]
        )

    with open(file,"r") as rfile:
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

def mergeExtensionsList(list1:list[str],list2:list[str])->list[str]:
    """merge 2 extensions list. removes duplicates, and sorts in alpha order"""

    mergedList:list[str]=list(set(list1+list2))
    mergedList.sort()

    return mergedList

if __name__=="__main__":
    extensions:list[str]=getVscodeExtensions()
    currentExtensions:ExtensionsFile=readExtensionsFile(EXTENSIONS_FILE)
    mergedExtensions:list[str]=mergeExtensionsList(extensions,currentExtensions.extensions)

    print(len(mergedExtensions),"extensions")

    outputExtensionsList(mergedExtensions)
    print("completed")