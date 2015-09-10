package com.serraview.formatters
{
    import com.serraview.core.IDataFormatter;
    import com.serraview.utils.FormatUtils;
    import com.serraview.utils.StringUtils;

    public class DataFormatter implements IDataFormatter
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

        protected function get currencyFormatter() : IDataFormatter
        {
            if (!_currencyFormatter)
            {
                _currencyFormatter = new CurrencyDataFormatter();
            }
            return _currencyFormatter;
        }

        protected function get percentageFormatter() : IDataFormatter
        {
            if (!_percentageFormatter)
            {
                _percentageFormatter = new PercentageDataFormatter();
            }
            return _percentageFormatter;
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
        }

        public function format(data : Object, format : String, locale : String = null) : String
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
                if (FormatUtils.isPercentage(format))
                {
                    formatter = percentageFormatter;
                }
                else if (FormatUtils.isCurrency(format))
                {
                    formatter = currencyFormatter;
                }
                else
                {
                    formatter = numberFormatter;
                }
            }

            return formatter.format(data, format, locale);
        }

        private var _currencyFormatter : IDataFormatter;

        private var _numberFormatter : IDataFormatter;

        private var _dateTimeFormatter : IDataFormatter;

        private var _percentageFormatter : IDataFormatter;

        private var _emptyFormatter : IDataFormatter;
    }
}
