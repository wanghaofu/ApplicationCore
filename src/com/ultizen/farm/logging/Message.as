package com.ultizen.farm.logging
{

    final public class Message extends Object
    {
        private var _className:String;
        private var _upTime:int;
        private var level:Level;
        private var _cppValues:Array;
        private var _line:uint;
        private var _timeStamp:Date;
        private var _content:Array;

        public function Message(content:Array, level:Level, upTime:int, timeStamp:Date, className:String, line:uint)
        {
            this.level = level;
            _content = content;
            _upTime = upTime;
            _timeStamp = timeStamp;
            _className = className;
            _line = line;
            return;
        }// end function

        public function get logLevel() : Level
        {
            return this.level;
        }// end function

        public function get className() : String
        {
            return this._className;
        }// end function

        public function get upTime() : int
        {
            return _upTime;
        }// end function

        public function get timeStamp() : Date
        {
            return _timeStamp;
        }// end function

        public function get content() : Array
        {
            return _content;
        }// end function

        public function get line() : uint
        {
            return this._line;
        }// end function

    }
}
