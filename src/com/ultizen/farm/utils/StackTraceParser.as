package com.ultizen.farm.utils
{
    import com.ultizen.farm.component.collection.*;

    public class StackTraceParser extends Object
    {

        public function StackTraceParser()
        {
            return;
        }// end function

        public function parse(stacktrace:String) : TypedArrayList
        {
            var _loc_4:String = null;
            var _loc_2:* = new TypedArrayList(StackTraceElement);
            var _loc_3:* = convertStacktraceToArrayOfElements(stacktrace);
            for each (_loc_4 in _loc_3)
            {
                
                _loc_2.add(new StackTraceElement(_loc_4));
            }
            return _loc_2;
        }// end function

        public function parseElementAt(stacktrace:String, level:uint) : StackTraceElement
        {
            return new StackTraceElement(convertStacktraceToArrayOfElements(stacktrace)[level]);
        }// end function

        private function convertStacktraceToArrayOfElements(stacktrace:String) : Array
        {
            var _loc_2:* = stacktrace.match(/(?<=^\tat ).*$/gm);
            if (_loc_2 != null)
            {
            }
            if (_loc_2.length == 0)
            {
                throw new ArgumentError("Stack trace contained no parsible elements.");
            }
            return _loc_2;
        }// end function

        public static function get instance() : StackTraceParser
        {
            return new StackTraceParser;
        }// end function

    }
}
