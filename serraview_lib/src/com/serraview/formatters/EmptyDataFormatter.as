package com.serraview.formatters
{
    import com.serraview.core.IDataFormatter;
    import com.serraview.utils.ObjectUtils;

    public class EmptyDataFormatter implements IDataFormatter
    {
        public function EmptyDataFormatter()
        {
        }

        public function format(data : Object, format : String, locale : String = null) : String
        {
            trace('ERROR: Format "' + format + '" not supported or data is not valid.')
            trace('DEBUG: ');
            trace(ObjectUtils.toDebugString(data));

            return data != null ? data.toString() : '';
        }
    }
}
