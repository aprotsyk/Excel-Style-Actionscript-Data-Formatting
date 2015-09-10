package com.serraview.constants
{
    import flash.globalization.LocaleID;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    use namespace flash_proxy;

    public dynamic class I18n extends Proxy
    {
        public static function get locale() : I18n
        {
            if (!_i18n)
                _i18n = new I18n();

            return _i18n;
        }

        public function I18n()
        {
            super();
        }

        flash_proxy override function getProperty(name : *) : *
        {
            return _locales[name] != undefined ? _locales[name] : LocaleID.DEFAULT;
        }

        flash_proxy override function setProperty(name : *, value : *) : void
        {
            _locales[name] = value;
        }

        private var _locales : Object = {
                en: 'en-US',
                fr: 'fr-FR',
                jp: 'ja-JP',
                ar: 'ar-SA',
                ua: 'uk-UA'
            };

        private static var _i18n : I18n;
    }
}
