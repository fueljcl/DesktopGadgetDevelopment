using System.Text;
using DesktopGadget.Product.Sdk;

public static class BundledPlugin
{
    public static string Run(string input) => input + "\n" + Encoding.UTF8.GetString(PluginAssets.Read("message.txt"));
}
