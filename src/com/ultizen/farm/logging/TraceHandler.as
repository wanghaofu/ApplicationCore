package com.ultizen.farm.logging
{
    import com.ultizen.farm.utils.text.*;

    public class TraceHandler extends Object implements LogHandler
    {
        protected var _format:String;
        public static const MESSAGE:String = "{message}";
        public static const LOG_LEVEL:String = "{logLevel}";
        public static const TIME_STAMP:String = "{timeStamp}";
        public static const LINE_NUMBER:String = "{line}";
        public static const DEFAULT_FORMAT:String = "{logLevel} - {className}, " + "{line} - {message}";
        public static const UP_TIME:String = "{upTime}";
        public static const CLASS_NAME:String = "{className}";

        public function TraceHandler(format:String = null)
        {
            _format = DEFAULT_FORMAT;
            if (format != null)
            {
                _format = format;
            }
            return;
        }// end function

        public function formatDate(date:Date) : String
        {
            return (date.getHours() < 10 ? ("0" + date.getHours()) : (date.getHours())) + ":" + (date.getMinutes() < 10 ? ("0" + date.getMinutes()) : (date.getMinutes())) + ":" + (date.getSeconds() < 10 ? ("0" + date.getSeconds()) : (date.getSeconds())) + "." + date.getMilliseconds();
        }// end function

        public function get format() : String
        {
            return _format;
        }// end function

        public function notify(message:Message) : void
        {
            trace(hydrateLayout(_format, message));
            return;
        }// end function

        public function printContent(content:Array) : String
        {
            return content.join(StringConst.SPACE);
        }// end function

        public function hydrateLayout(messageLayout:String, message:Message) : String
        {
            return messageLayout.replace(new RegExp(MESSAGE, "g"), printContent(message.content)).replace(new RegExp(LOG_LEVEL, "g"), message.logLevel.name).replace(new RegExp(UP_TIME, "g"), message.upTime).replace(new RegExp(TIME_STAMP, "g"), formatDate(message.timeStamp)).replace(new RegExp(CLASS_NAME, "g"), message.className).replace(new RegExp(LINE_NUMBER, "g"), message.line);
        }// end function

        public function set format(value:String) : void
        {
            _format = value;
            return;
        }// end function

    }
}
