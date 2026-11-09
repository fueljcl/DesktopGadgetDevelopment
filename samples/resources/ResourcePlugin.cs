using System.Linq;
using DesktopGadget.Product.Sdk;

namespace Example;
public static class ResourcePlugin
{
    public static string Run(string input)
    {
        var context=PluginResources.Read(input);
        var text=context.Resources.Single(r=>r.Id=="document"&&r.Operation=="file.text").Text;
        return context.Input+"\n"+text;
    }
}
