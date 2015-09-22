package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.collections.HashMap;
    import com.excelstyledataformatting.constants.I18n;
    import com.excelstyledataformatting.constants.StyleNames;
    import com.excelstyledataformatting.core.IDataFormatter;

    import flash.globalization.LocaleID;

    import mx.formatters.IFormatter;
    import mx.styles.IStyleClient;

    public class DataFormatterBase implements IDataFormatter
    {
        public function DataFormatterBase()
        {
        }

        public function format(data : Object, format : String, locale : String = null) : String
        {
            var result : String;
            var resultCacheKey : String = getResultCacheKey(data, format, locale);

            if (cache.containsKey(resultCacheKey))
            {
                result = cache.getValue(resultCacheKey) as String;
            }

            return result;
        }

        protected function setLocale(formatter : IFormatter, locale : String) : void
        {
            if (formatter is IStyleClient)
            {
                IStyleClient(formatter).setStyle(StyleNames.LOCALE, I18n.locale[locale]);
            }
        }

        protected function getResultCacheKey(data : Object, format : String, locale : String) : String
        {
            return getFormatCacheKey(format, locale) + CACHE_SEPARATOR + data.toString();
        }

        protected function getFormatCacheKey(format : String, locale : String) : String
        {
            return format + CACHE_SEPARATOR + (locale || LocaleID.DEFAULT);
        }

        protected var cache : HashMap = new HashMap(true);

        protected const CACHE_SEPARATOR : String = '|';
    }
}
