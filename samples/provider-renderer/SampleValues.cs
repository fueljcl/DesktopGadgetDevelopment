using System;
using System.Globalization;
namespace DesktopGadget.SampleMultiSource;

// Synthetic input only; no file, sensor, network, process or key access.
internal static class SampleValues
{
    internal static double? Parse(string input)
    {
        if(input=="missing")return null;
        var value=string.IsNullOrWhiteSpace(input)?42:double.Parse(input,NumberStyles.Float,CultureInfo.InvariantCulture);
        if(!double.IsFinite(value)||value<0||value>100)throw new ArgumentException("Enter a finite number from 0 to 100.");
        return value;
    }
}
