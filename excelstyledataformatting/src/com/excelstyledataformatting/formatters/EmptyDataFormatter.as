package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.utils.StringUtils;


    public class EmptyDataFormatter extends DataFormatterBase
    {
        public function EmptyDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            debug('Format "' + format + '" not supported or data is not valid.')
            debug(data)

            return StringUtils.empty(data) ? '' : data.toString();
        }
    }
}
