package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.core.IDataFormatter;
    import com.excelstyledataformatting.utils.StringUtils;

    public class DataFormatter extends DataFormatterBase
    {
        public static const formatter : IDataFormatter = new DataFormatter();

        public static function format(data : Object, format : String, locale : String = null) : String
        {
            return formatter.format(data, format, locale);
        }

        protected function get dateTimeFormatter() : IDataFormatter
        {
            if (!_dateTimeFormatter)
            {
                _dateTimeFormatter = new DateTimeDataFormatter();
            }
            return _dateTimeFormatter;
        }

        protected function get numberFormatter() : IDataFormatter
        {
            if (!_numberFormatter)
            {
                _numberFormatter = new NumberDataFormatter();
            }
            return _numberFormatter;
        }

        protected function get emptyFormatter() : IDataFormatter
        {
            if (!_emptyFormatter)
            {
                _emptyFormatter = new EmptyDataFormatter();
            }
            return _emptyFormatter;
        }


        public function DataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            var formatter : IDataFormatter = emptyFormatter;

            if (data is String)
            {
                data = StringUtils.toObject(String(data));
            }

            if (data is Date)
            {
                formatter = dateTimeFormatter;
            }
            else if (data is Number)
            {
                formatter = numberFormatter;
            }

            return formatter.format(data, format, locale);
        }

        private var _numberFormatter : IDataFormatter;

        private var _dateTimeFormatter : IDataFormatter;

        private var _emptyFormatter : IDataFormatter;
    }
}
