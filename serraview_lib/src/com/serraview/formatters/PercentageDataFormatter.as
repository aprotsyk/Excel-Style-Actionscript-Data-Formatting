package com.serraview.formatters
{
    import com.serraview.utils.FormatUtils;

    public class PercentageDataFormatter extends NumberDataFormatter
    {
        public function PercentageDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            var result : String = '';

            var m : Array = FormatUtils.percentagePattern.exec(format);
            if (m != null)
            {
                var numberFormat : String = m[1];
                var percentFormat : String = m[2];
                var numberValue : Number = Number(data) * Math.pow(100, percentFormat.length);

                result = super.format(numberValue, numberFormat, locale) + percentFormat;
            }
            else
            {
                //TODO: process incorrect format
            }

            return result;
        }
    }
}
