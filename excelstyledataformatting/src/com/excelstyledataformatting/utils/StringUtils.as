package com.excelstyledataformatting.utils
{
    import mx.utils.StringUtil;

    public class StringUtils
    {
        public static const EMPTY : String = '';

        public static function empty(value : Object) : Boolean
        {
            return value == null || (value is String && trim(value as String) == EMPTY);
        }

        public static function trim(value : String) : String
        {
            return StringUtil.trim(value);
        }

        public static function substitute(str : String, ... rest) : String
        {
            return StringUtil.substitute(str, rest);
        }

        public static function toObject(value : String) : Object
        {
            var result : Object;

            if (!isNaN(parseFloat(value)))
            {
                result = parseFloat(value)
            }
            else if (!isNaN(Date.parse(value)))
            {
                result = new Date(Date.parse(value));
            }
            else
            {
                result = value;
            }

            return result;
        }

    }
}
