package com.serraview.formatters
{
    import com.serraview.core.IDataFormatter;

    public class EmptyDataFormatter implements IDataFormatter
    {
        public function EmptyDataFormatter()
        {
        }

        public function format(data : Object, format : String, locale : String = null) : String
        {
            debug('ERROR: Format "' + format + '" not supported or data is not valid.')
            debug(data)

            return data != null ? data.toString() : '';
        }
    }
}
