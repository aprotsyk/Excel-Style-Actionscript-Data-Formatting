package com.serraview.utils
{

    public class FormatUtils
    {
        public static function isPercentage(format : String) : Boolean
        {
            var pattern : RegExp = /%/g;
            return !StringUtils.empty(format) && pattern.test(format);
        }

        public static function isCurrency(format : String) : Boolean
        {
            return false;
        }
    }
}
