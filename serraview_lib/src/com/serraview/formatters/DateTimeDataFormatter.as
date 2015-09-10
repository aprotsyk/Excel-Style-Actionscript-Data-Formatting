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
            formatter.dateTimePattern = format;
            formatter.setStyle(StyleNames.LOCALE, I18n.locale[locale]);

            return formatter.format(data);
        }

        private var _formatter : DateTimeFormatter;
    }
}
