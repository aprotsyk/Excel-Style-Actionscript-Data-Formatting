package com.serraview.tests
{
    import com.serraview.formatters.DataFormatter;
    import com.serraview.utils.StringUtils;

    import flexunit.framework.TestCase;

    public class FormattersTestCase extends TestCase
    {

        [Test]
        public function testDateTimeFormat() : void
        {
            var tests : Array = [
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd/MM/yyyy H:mm', '3/01/2014 0:00'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd MMMM yyyy', '3 January 2014', 'en'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd MMMM yyyy', '3 janvier 2014', 'fr'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd MMMM yyyy', '٢ ربيع الأول ١٤٣٥', 'ar'],
                ['Fri Jan 3 11:00:00 GMT+1100 2014', 'd MMMM yyyy', '3 1月 2014', 'jp'],
                ['Fri Jan 5 13:20:40 GMT+0300 2015', 'H:mm:ss a', '10:20:40 AM'],
                [new Date(1983, 7, 23), 'dd MMM yyyy', '22 Aug 1983', 'en'],
                [new Date(1983, 7, 23), 'dd MMMM yyyy', '22 серпня 1983', 'ua']
                ];

            testFormat(tests);
        }

        [Test]
        public function testNumberFormat() : void
        {
            var tests : Array = [
                [1, '0.0', '1,0'],
                [143, '0.0#', '143,0'],
                [45.12, '0.0#', '45,12'],
                ['45.123', '0.0', '45,1'],
                [3.3, '###.###', '3,3'],
                [9322, '### .###', '9,322'],
                ['9322', '###.### ', '9,322'],
                ['-32', '#.????', '-32,0   ']
                ];

            testFormat(tests);
        }

        [Test]
        public function testPercentFormat() : void
        {
            var tests : Array = [
                [0.453, '0.0%', '45,3%'],
                [0.453, '0.0%%', '4530,0%%'],
                [53, '0.##%', '5300,0%'],
                ['432', '0.## %', '43,2%'],
                ['-10', '0%', '-1000%']
                ];

            testFormat(tests);
        }

        [Test]
        public function testCurrencyFormat() : void
        {
            var tests : Array = [
                [234, '$#,##0.00', '$234']
                ];

            testFormat(tests);
        }

        protected function testFormat(tests : Array) : void
        {
            for each (var data : Array in tests)
            {
                var locale : String = data.length == 4 ? data[3] : 'en';
                assertEquals(
                    StringUtils.substitute("DataFormatter.format('{0}', '{1}', '{2}')", data[0], data[1], locale),
                    DataFormatter.format(data[0], data[1], locale),
                    data[2]);
            }
        }
    }
}
