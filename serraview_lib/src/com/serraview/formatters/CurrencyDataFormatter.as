package com.serraview.formatters
{


    public class CurrencyDataFormatter extends NumberDataFormatter
    {
        public function CurrencyDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            return 'currency';
        }
    }
}
