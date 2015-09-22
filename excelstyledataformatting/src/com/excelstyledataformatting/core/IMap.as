package com.excelstyledataformatting.core
{

    public interface IMap
    {
        function add(key : String, value : Object) : void;

        function remove(key : String) : Object;

        function containsKey(key : String) : Boolean;

        function containsValue(value : Object) : Boolean;

        function getKey(value : Object) : String;

        function getValue(key : String) : Object;

        function getKeys() : Array;

        function getValues() : Array;

        function length() : int;

        function clear() : void;

        function clone() : IMap;

        function empty() : Boolean;
    }
}
