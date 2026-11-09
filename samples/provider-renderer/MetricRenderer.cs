using System;
using System.Globalization;
using System.Text.Json;
namespace DesktopGadget.SampleMultiSource;

// Accepts one value in the documented Provider JSON format. The host independently
// validates both documents; this sample never grants permission or signs a work.
public static class MetricRenderer
{
    public static string Run(string input)
    {
        if(input.Length>16384)throw new ArgumentException("Input limit.");
        using var document=JsonDocument.Parse(input);var root=document.RootElement;
        if(root.GetProperty("Schema").GetInt32()!=1||root.GetProperty("Values").GetArrayLength()!=1)throw new ArgumentException("Exactly one Provider value is required.");
        var value=root.GetProperty("Values")[0];var label=value.GetProperty("Label").GetString()??"";var unit=value.GetProperty("Unit").GetString()??"";
        var valid=value.GetProperty("Quality").GetString()=="Valid";double width=0;string text;
        if(valid)
        {
            var number=value.GetProperty("Value").GetDouble();if(!double.IsFinite(number))throw new ArgumentException("Finite value required.");
            width=Math.Clamp(number,0,100)*2;text=label+": "+number.ToString("R",CultureInfo.InvariantCulture)+" "+unit;
        }
        else
        {
            if(value.GetProperty("Value").ValueKind!=JsonValueKind.Null)throw new ArgumentException("Unavailable values must be null.");
            text=label+": "+(value.GetProperty("Reason").GetString()??"Unavailable");
        }
        return JsonSerializer.Serialize(new{Schema=1,Width=240,Height=120,Label="Demo value",Description="One explicit Provider result",Elements=new object[]{
            new{Kind="rect",X=0,Y=0,Color="#1B2736",A=240,B=120},
            new{Kind="rect",X=10,Y=70,Color="#70E0BD",A=width,B=24},
            new{Kind="text",X=10,Y=32,Color="#EAF0F5",Size=16,Text=text}}});
    }
}
