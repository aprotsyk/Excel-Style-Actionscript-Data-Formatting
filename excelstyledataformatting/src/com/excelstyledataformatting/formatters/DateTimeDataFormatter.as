package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.utils.StringUtils;

    import spark.formatters.DateTimeFormatter;

    public class DateTimeDataFormatter extends DataFormatterBase
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
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            var result : String = super.format(data, format, locale);

            if (StringUtils.empty(result))
            {
                setLocale(formatter, locale);

                var formatCacheKey : String = getFormatCacheKey(format, locale);

                if (!cache.containsKey(formatCacheKey))
                {
                    format = format.replace(/m/g, 'M')
                    format = format.replace(/(h+.*m+)|(m+[^m]*s+)/gi, function() : String {return arguments[1].replace(/M/g, 'm')});
                    format = format.replace(/(am\/pm)|(a\/p)/gi, 'a');
                    format = format.replace(/\[h\]/g, 'k');
                    format = format.replace(/h/g, 'H');

                    cache.add(formatCacheKey, format);
                }
                else
                {
                    format = cache.getValue(formatCacheKey) as String;
                }

                formatter.dateTimePattern = format;

                result = formatter.format(data);

                cache.add(getResultCacheKey(data, format, locale), result);
            }

            return result;
        }

        private var _formatter : DateTimeFormatter;
    }
}
