package tests
{
    import com.excelstyledataformatting.formatters.DataFormatter;
    import com.excelstyledataformatting.utils.StringUtils;

    import flexunit.framework.TestCase;

    public class FormattersTestCase extends TestCase
    {

        [Test]
        public function testDateTimeFormat() : void
        {
            var asserts : Array = [
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd/mm/yyyy h:mm', '3/01/2014 0:00'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'dd mmm h:mm', '03 Jan 0:00'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd mmmm yyyy', '3 January 2014', 'en'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd mmmm yyyy', '3 janvier 2014', 'fr'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd mmmm yyyy', '٢ ربيع الأول ١٤٣٥', 'ar'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd mmmm yyyy', '3 1月 2014', 'jp'],
                ['Fri Jan 5 13:20:40 GMT+0300 2015', 'h:mm:ss am/pm', '10:20:40 AM'],
                ['Fri Jan 5 13:20:40 GMT+0300 2015', 'h:mm:ss A/M', '10:20:40 AM'],
                ['Fri Jan 5 13:20:40 GMT+0300 2015', 'h:mm:ss A/M', '10:20:40 AM'],
                [new Date(1983, 7, 23), 'dd mmm yyyy', '22 Aug 1983', 'en'],
                [new Date(1983, 7, 24), 'dd mmm yyyy', '23 Aug 1983', 'en'],
                [new Date(1983, 7, 23), 'dd mmmm yyyy', '22 серпня 1983', 'ua'],
                [new Date(1983, 7, 23), 'dd mmmm yyyy', '22 серпня 1983', 'ua']
                ];

            testFormat(asserts);
        }

        [Test]
        public function testNumberFormat() : void
        {
            var asserts : Array = [
                [1, '0.0', '1,0'],
                [143, '0.0#', '143,0'],
                [45.12, '0.0#', '45,12'],
                ['45.123', '0.0', '45,1'],
                [3.3, '###.###', '3,3'],
                [9322, '### .###', '9,322'],
                ['9322', '###.### ', '9,322'],
                ['9322', '###.###_', '9,322'],
                ['-32', '#.0???', '-32,0   '],
                [12000, '#,###', '12 000'],
                [12000, '#_', '12'],
                [12200000, '0.0__', '12,2'],
                [12200.909, '-#,##0.00', '-12 200,91']
                ];

            testFormat(asserts);
        }

        [Test]
        public function testPercentFormat() : void
        {
            var asserts : Array = [
                [0.453, '0.0%', '45,3%'],
                [0.453, '0.0%%', '4530,0%%'],
                [53, '0.0#%', '5300,0%'],
                ['432', '0.## %', '43,2%'],
                ['-10', '0%', '-1000%']
                ];

            testFormat(asserts);
        }

        [Test]
        public function testCurrencyFormat() : void
        {
            var asserts : Array = [
                [2340, '$#,##0.00', '$2 340,00'],
                [2340, '[$¥-411]#,##0.0', '[$¥-411]2 340,0'],
                ];

            testFormat(asserts);
        }

        protected function testFormat(asserts : Array) : void
        {
            for each (var data : Array in asserts)
            {
                var locale : String = data.length == 4 ? data[3] : 'en';
                var label : String = StringUtils.substitute("DataFormatter.format('{0}', '{1}', '{2}')", data[0], data[1], locale);
                var formattedResult : String = DataFormatter.format(data[0], data[1], locale);
                var expectedResult : String = data[2];

                assertEquals(label, expectedResult, formattedResult);

                debug(label, {expected: expectedResult, result: formattedResult});
            }
        }
    }
}
