package com.serraview.formatters
{
    import com.serraview.constants.I18n;
    import com.serraview.constants.StyleNames;
    import com.serraview.core.IDataFormatter;

    import spark.formatters.DateTimeFormatter;

    public class DateTimeDataFormatter implements IDataFormatter
    {
        protected function get formatter() : DateTimeFormatter
        {
            if (!_formatter)
            {
                _formatter = new DateTimeFormatter();
                _formatter.useUTC = true;
            }

            return _formatter;
        }

        public function DateTimeDataFormatter()
        {
        }

        public function format(data : Object, format : String, locale : String = null) : String
        {
            formatter.setStyle(StyleNames.LOCALE, I18n.locale[locale]);

            format = format.replace(/m/g, 'M')
            format = format.replace(/(h+.*m+)|(m+[^m]*s+)/gi, function() : String {return arguments[1].replace(/M/g, 'm')});
            format = format.replace(/(am\/pm)|(a\/p)/gi, 'a');
            format = format.replace(/\[h\]/g, 'k');
            format = format.replace(/h/g, 'H');

            formatter.dateTimePattern = format;

            return formatter.format(data);
        }

        private var _formatter : DateTimeFormatter;
    }
}
