package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.constants.I18n;
    import com.excelstyledataformatting.utils.StringUtils;
    
    import flash.globalization.DateTimeFormatter;

    public class DateTimeDataFormatter extends DataFormatterBase
    {
        public function DateTimeDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            var result : String = super.format(data, format, locale);

            if (StringUtils.empty(result))
            {
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

                var formatter : DateTimeFormatter = getFormatterByLocale(locale);
                formatter.setDateTimePattern(format);

                result = formatter.formatUTC(data as Date);

                cache.add(getResultCacheKey(data, format, locale), result);
            }

            return result;
        }

        protected function getFormatterByLocale(locale : String) : DateTimeFormatter
        {
            locale = I18n.locale[locale];

            var formatter : DateTimeFormatter;
            var formatterCacheKey : String = getFormatterCacheKey(locale);

            if (cache.containsKey(formatterCacheKey))
            {
                formatter = cache.getValue(formatterCacheKey) as DateTimeFormatter;
            }
            else
            {
                formatter = new DateTimeFormatter(locale);

                cache.add(formatterCacheKey, formatter);
            }

            return formatter;
        }

        protected function getFormatterCacheKey(locale : String) : String
        {
            return 'formatter' + CACHE_SEPARATOR + locale;
        }
    }
}
