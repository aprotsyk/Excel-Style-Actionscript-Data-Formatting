package com.excelstyledataformatting.core
{

    public interface IDataFormatter
    {
        function format(data : Object, format : String, locale : String = null) : String;
    }
}
