package com.serraview.utils
{

    public class FormatUtils
    {
        public static function get percentagePattern() : RegExp
        {
            PERCENTAGE_PATTERN.lastIndex = 0;
            return PERCENTAGE_PATTERN;
        }

        public static function isPercentage(format : String) : Boolean
        {
            return !StringUtils.empty(format) && percentagePattern.test(format);
        }

        public static function isCurrency(format : String) : Boolean
        {
            return false;
        }

        private static const PERCENTAGE_PATTERN : RegExp = /(.+?)(%+)/g;
    }
}
