package com.serraview.utils
{
    import mx.utils.ObjectUtil;
    import mx.utils.URLUtil;

    public class ObjectUtils
    {
        public static function toString(obj : Object, separator : String = ';') : String
        {
            return URLUtil.objectToString(obj, separator, false);
        }

        public static function toDebugString(obj : Object) : String
        {
            var classInfo : Object = ObjectUtil.getClassInfo(obj);
            var debugInfo : String = '';
            if (obj != null)
            {
                debugInfo = 'toString() is ' + obj.toString() + "\n";
                debugInfo += classInfo.name + ":\n";
                for each (var propName : String in classInfo.properties)
                {
                    if (obj[propName])
                    {
                        debugInfo += "\t" + propName.toUpperCase() + " = " + obj[propName] + "\n";
                    }
                }
            }
            else
            {
                debugInfo = 'OBJECT IS NULL';
            }

            return debugInfo;
        }
    }
}
