package com.excelstyledataformatting.collections
{
    import com.excelstyledataformatting.core.IMap;

    import flash.utils.Dictionary;

    public class HashMap implements IMap
    {
        protected function get map() : Object
        {
            return _map;
        }

        public function HashMap(useWeakReference : Boolean = false)
        {
            _map = new Dictionary(useWeakReference);
        }

        public function add(key : String, value : Object) : void
        {
            map[key] = value;
        }


        public function remove(key : String) : Object
        {
            var value : Object = map[key];

            delete map[key];

            return value;
        }

        public function containsKey(key : String) : Boolean
        {
            return key in map;
        }

        public function containsValue(value : Object) : Boolean
        {
            var result : Boolean = false;
            for (var key : String in map)
            {
                if (getValue(key) == value)
                {
                    result = true;
                    break;
                }
            }
            return result;
        }

        public function getKey(value : Object) : String
        {
            var result : String;
            for (var key : String in map)
            {
                if (getValue(key) == value)
                {
                    result = key;
                    break;
                }
            }

            return result;
        }

        public function getValue(key : String) : Object
        {
            return map[key];
        }

        public function getKeys() : Array
        {
            var result : Array = [];
            for (var key : String in map)
            {
                result.push(key);
            }
            return result;
        }

        public function getValues() : Array
        {
            var result : Array = [];
            for (var key : String in map)
            {
                result.push(getValue(key));
            }
            return result;
        }

        public function length() : int
        {
            var result : int = 0;
            for (var key : String in map)
            {
                result++;
            }
            return result;
        }

        public function empty() : Boolean
        {
            return length() == 0;
        }

        public function clear() : void
        {
            for (var key : String in map)
            {
                remove(key);
            }
        }

        public function clone() : IMap
        {
            var result : IMap = new HashMap();
            var keys : Array = getKeys();
            for each (var key : String in keys)
            {
                result.add(key, getValue(key));
            }
            return result;
        }

        private var _map : Dictionary;
    }
}
