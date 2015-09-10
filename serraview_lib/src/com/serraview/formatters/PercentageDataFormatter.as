package com.serraview.formatters
{

    public class PercentageDataFormatter extends NumberDataFormatter
    {
        public function PercentageDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            return 'percentage';
        }
    }
}
