const execa=require("execa");
const fs=require("fs");
const union=require("lodash.union");

const _vscodepath="C:/Users/ngokn1/Documents/other programs/vscode/bin/code";

function main()
{
    var installextensions=getVsCodeExtensions(_vscodepath);
    var extensionsfile=getExtensionFile();

    console.log(installextensions.length);
    console.log(extensionsfile.length);
    console.log(unionSort(installextensions,extensionsfile));
}

// retrive list of currently installed vscode extensions
// (vscodepath:string):string[]
function getVsCodeExtensions(vscodepath)
{
    return execa.sync(vscodepath,["--list-extensions"]).stdout.split("\n");
}

// retrive extensions from extensions.json
// ():string[]
function getExtensionFile()
{
    if(!fs.existsSync("extensions.json"))
    {
        return [];
    }

    return JSON.parse(fs.readFileSync("extensions.json")).recommendations;
}

// union and sort given string arrays
// (array1:string[],array2:string[]):string[]
function unionSort(array1,array2)
{
    var merged=union(array1,array2);

    // a:string,b:string
    merged.sort((a,b)=>{
        var alower=a.toLowerCase();
        var blower=b.toLowerCase();
        if (alower>blower)
        {
            return 1;
        }

        if (alower<blower)
        {
            return -1;
        }

        return 0;
    });

    return merged;
}

// given list of extensions, output vscode extensions.json file
// (extensions:string):void
function outputExtensionsJson(extensions)
{
    fs.writeFile("extensions.json",JSON.stringify({
        recommendations:extensions
    }));
}

main();