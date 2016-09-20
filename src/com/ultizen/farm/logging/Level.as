package com.ultizen.farm.logging
{
    import flash.errors.*;

    final public class Level extends Object
    {
        private var _value:int;
        private var _name:String;
        public static const ALL:Level = new Level(0, "ALL");
        public static const FATAL:Level = new Level(5, "FATAL");
        public static const ERROR:Level = new Level(4, "ERROR");
        private static var lock:Boolean = false;
        public static const WARN:Level = new Level(3, "WARN");
        public static const INFO:Level = new Level(2, "INFO");
        public static const DEBUG:Level = new Level(1, "DEBUG");
        public static const OFF:Level = new Level(6, "OFF");

        public function Level(value:int, name:String)
        {
            if (lock)
            {
                throw new IllegalOperationError("Invalid enum construction.");
            }
            _value = value;
            _name = name;
            return;
        }// end function

        public function get value() : int
        {
            return _value;
        }// end function

        public function toString() : String
        {
            return name;
        }// end function

        public function get name() : String
        {
            return _name;
        }// end function

        public static function fromString(evalString:String) : Level
        {
            evalString = evalString.toUpperCase();
            if (Level[evalString] is Level)
            {
                return Level[evalString];
            }
            throw new Error("\"" + evalString + "\" is not a valid log level.");
        }// end function

        lock = true;
    }
}
