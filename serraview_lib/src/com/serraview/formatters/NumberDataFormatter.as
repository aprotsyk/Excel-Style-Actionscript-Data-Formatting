package com.serraview.formatters
{
    import com.serraview.constants.I18n;
    import com.serraview.constants.StyleNames;
    import com.serraview.core.IDataFormatter;

    import spark.formatters.NumberFormatter;

    public class NumberDataFormatter implements IDataFormatter
    {
        protected function get formatter() : NumberFormatter
        {
            if (!_formatter)
            {
                _formatter = new NumberFormatter();
            }

            return _formatter;
        }

        public function NumberDataFormatter()
        {
        }

        public function format(data : Object, format : String, locale : String = null) : String
        {
            formatter.setStyle(StyleNames.LOCALE, I18n.locale[locale]);
            return formatter.format(data);
        }

        private var _formatter : NumberFormatter;
    }
}
