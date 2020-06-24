/* use inside web browser. given a new line seperated list of extensions in a single string,
   like in the vscode extentions txt file, convert it into double quote and comma seperated
   list that can be pasted into the extensions.json*/
function convertList(extensions)
{
    extensions=extensions.split("\n");

    var res="";
    for (var x=0;x<extensions.length;x++)
    {
        res+=`"${extensions[x]}"`;

        if (x+1<extensions.length)
        {
            res+=",\n";
        }
    }

    return res;
}