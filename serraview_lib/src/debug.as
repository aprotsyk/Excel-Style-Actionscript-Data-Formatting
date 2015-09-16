package
{
    import com.serraview.utils.ObjectUtils;
    import com.serraview.utils.StringUtils;

    public function debug(... args) : void
    {
        var message : String = '';
        for each (var argument : Object in args)
        {
            if (!argument)
            {
                continue;
            }

            if (argument is String || argument is Number || argument is Boolean)
            {
                if (!StringUtils.empty(message))
                {
                    message += "\t";
                }
                message += argument;
            }
            else
            {
                if (!StringUtils.empty(message))
                {
                    message += "\n";
                }

                message += ObjectUtils.toDebugString(argument);
            }
        }

        trace('[DEBUG]:' + message);
    }
}
