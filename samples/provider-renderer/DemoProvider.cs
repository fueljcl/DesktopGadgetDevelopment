using System.Text.Json;
namespace DesktopGadget.SampleMultiSource;

// Entry point; all parsing lives in another source file.
public static class DemoProvider
{
    public static string Run(string input)
    {
        var number=SampleValues.Parse(input);
        return JsonSerializer.Serialize(new{Schema=1,Values=new[]{new{Field="demo.value",Label="Demo input",Value=number,Unit="%",
            Quality=number.HasValue?"Valid":"Unavailable",Reason=number.HasValue?null:"Demo input unavailable"}}});
    }
}
