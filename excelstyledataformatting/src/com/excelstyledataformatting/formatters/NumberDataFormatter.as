package com.excelstyledataformatting.formatters
{
    import com.excelstyledataformatting.utils.StringUtils;

    import spark.formatters.NumberFormatter;

    public class NumberDataFormatter extends DataFormatterBase
    {
        protected function get formatter() : NumberFormatter
        {
            if (!_formatter)
            {
                _formatter = new NumberFormatter();
                _formatter.useGrouping = false;
                _formatter.decimalSeparator = ',';
                _formatter.groupingSeparator = ' ';
            }

            return _formatter;
        }

        public function NumberDataFormatter()
        {
            super();
        }

        override public function format(data : Object, format : String, locale : String = null) : String
        {
            var result : String = super.format(data, format, locale);
            ;

            if (StringUtils.empty(result))
            {
                setLocale(formatter, locale);

                var value : Number = Number(data);
                var percentageSuffix : String = '';

                format = format.replace(_percentRegExp, function() : String {
                    value *= Math.pow(100, arguments[1].length);
                    percentageSuffix = arguments[1];
                    return '';
                });

                format = format.replace(_spacesRegExp, function() : String {
                    value /= Math.pow(1000, arguments[1].length);
                    return '';
                });

                var integerPattern : String = format;
                var decimalPattern : String = '';

                var integerValue : int = value;
                var decimalValue : int = 0;

                var patterns : Array = format.match(/(.*?)\.(.*)/);
                if (patterns != null)
                {
                    integerPattern = patterns[1];
                    decimalPattern = patterns[2];

                    integerPattern = integerPattern.replace(_spacesRegExp, function() : String {
                        value /= Math.pow(1000, arguments[1].length);
                        return '';
                    });

                    integerValue = int(value);
                    decimalValue = Math.round((value - integerValue) * Math.pow(10, decimalPattern.match(/0|\?|#/g).length));
                }
                else
                {
                    integerValue = Math.round(value);
                }

                var formattedIntegerValue : String = formatIntegerPart(integerValue, integerPattern);
                var formattedDecimalValue : String = formatDecimalPart(decimalValue, decimalPattern);

                result = formattedIntegerValue;

                if (!StringUtils.empty(formattedDecimalValue))
                {
                    result += formatter.decimalSeparator + formattedDecimalValue;
                }

                if (!StringUtils.empty(percentageSuffix))
                {
                    result += percentageSuffix;
                }

                cache.add(getResultCacheKey(data, format, locale), result);
            }

            return result;
        }

        protected function formatIntegerPart(value : int, pattern : String) : String
        {
            var result : String = '';
            var ref : String;
            var i : int, j : int;
            var mostLeftDigit : int = -1;
            var stringValue : String = value.toString();
            var separateThousands : Boolean = false;

            pattern = pattern.replace(/(0|#|\?)(,+?)(0|#|\?)/g, function() : String {
                separateThousands = true;
                return arguments[1] + arguments[3];
            });

            if (separateThousands)
            {
                j = stringValue.length - 3;
                while ((stringValue.charAt(0) == '-' ? j > 1 : j > 0))
                {
                    stringValue = stringValue.substr(0, j) + formatter.groupingSeparator + stringValue.substr(j);
                    j -= 3;
                }
            }

            j = stringValue.length - 1;
            i = pattern.length;
            while (i--)
            {
                ref = null

                if (stringValue.charAt(j) == formatter.groupingSeparator)
                {
                    ref = stringValue.charAt(j);
                    result = ref + result;
                    j--;
                }

                switch (pattern.charAt(i))
                {
                    case '0':
                        result = (!StringUtils.empty(ref = stringValue.charAt(j)) ? ref : '0') + result;
                        mostLeftDigit = i;
                        j--;
                        break;
                    case '#':
                        result = (!StringUtils.empty(ref = stringValue.charAt(j)) ? ref : '') + result;
                        mostLeftDigit = i;
                        j--;
                        break;
                    case '?':
                        result = (!StringUtils.empty(ref = stringValue.charAt(j)) ? ref : ' ') + result;
                        mostLeftDigit = i;
                        j--;
                        break;
                    case ']':
                        while (i > 0 && pattern.charAt(i) !== '[')
                        {
                            result = pattern.charAt(i) + result;
                            i--;
                        }
                        i++;
                        break;
                    default:
                        result = pattern.charAt(i) + result;
                }
            }


            if (j >= 0 && mostLeftDigit != -1)
            {
                result = result.substr(0, mostLeftDigit) + stringValue.substr(0, j + 1) + result.substr(mostLeftDigit);
            }

            return result;
        }

        protected function formatDecimalPart(value : int, pattern : String) : String
        {
            var result : String = '';
            var ref : String;
            var stringValue : String = value.toString().replace(/0+$/g, '');
            var i : int = -1, j : int = 0;
            var totalLength : int = pattern.length;

            while (++i < totalLength)
            {
                ref = null;
                switch (pattern.charAt(i))
                {
                    case '0':
                        result += !StringUtils.empty(ref = stringValue.charAt(j)) ? ref : '0';
                        j++;
                        break;
                    case '#':
                        result += !StringUtils.empty(ref = stringValue.charAt(j)) ? ref : '';
                        j++;
                        break;
                    case '?':
                        result += !StringUtils.empty(ref = stringValue.charAt(j)) ? ref : ' ';
                        j++;
                        break;
                    case '[':
                        while (i < pattern.length && pattern.charAt(i) !== ']')
                        {
                            result += pattern.charAt(i);
                            i++;
                        }
                        i--;
                        break;
                    default:
                        result += pattern.charAt(i);
                }
            }
            return result;
        }

        private var _formatter : NumberFormatter;

        private const _spacesRegExp : RegExp = /([,_\s]*)$/;

        private const _percentRegExp : RegExp = /(%+)/g
    }
}
