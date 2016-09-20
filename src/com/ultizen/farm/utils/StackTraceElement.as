package com.ultizen.farm.utils
{
    import com.ultizen.farm.utils.text.*;

    public class StackTraceElement extends Object
    {
        private var _lineNumber:int = -1;
        private var _fileName:String;
        private var _isStaticMethod:Boolean = false;
        private var _className:String;
        private var _methodName:String;
        private var element:String;
        private var _nativeMethod:Boolean = false;
       public static const METHOD_NAME:RegExp = /((?<=\/)(.*\:\:)?\w+|<\w+>)(?=\(\))/;
	   public static const CLASS_NAME:RegExp = /^((\w+\.)*(\w+\:\:))?\w+(?=\$?\/[\w\:\/]+\(\))/;
	   public static const LINE_NUMBER:RegExp = /(?<=\:)\d+(?=\]$)/;
	   public static const IS_STATIC_METHOD:RegExp = /\$(?=\/\w+\(\))/;
	   public  static const FILE_NAME:RegExp = /(?<=\[).+(?=\:\d+\]$)/;

        public function StackTraceElement(element:String)
        {
            _className = StringConst.EMPTY;
            _methodName = StringConst.EMPTY;
            _fileName = StringConst.EMPTY;
            if (element == null)
            {
                throw new Error("Element string cannot be null.");
            }
            this.element = element;
            _className = parseClassName(element);
            _fileName = parseFileName(element);
            _isStaticMethod = parseIsStaticMethod(element);
            _lineNumber = parseLineNumber(element);
            _methodName = parseMethodName(element);
            _nativeMethod = parseNativeMethod(element);
            return;
        }// end function

        private function parseIsStaticMethod(element:String) : Boolean
        {
            return element.search(IS_STATIC_METHOD) != -1;
        }// end function

        private function parseLineNumber(element:String) : int
        {
            var _loc_2:* = element.match(LINE_NUMBER);
            if (_loc_2)
            {
            }
            if (_loc_2.length == 0)
            {
                return -1;
            }
            return int(_loc_2[0]);
        }// end function

        public function get methodName() : String
        {
            return _methodName;
        }// end function

        public function get lineNumber() : int
        {
            return _lineNumber;
        }// end function

        public function get nativeMethod() : Boolean
        {
            return _nativeMethod;
        }// end function

        public function get className() : String
        {
            return _className;
        }// end function

        private function parseMethodName(element:String) : String
        {
            var _loc_2:* = element.match(METHOD_NAME);
            if (_loc_2)
            {
            }
            if (_loc_2.length == 0)
            {
                return StringConst.EMPTY;
            }
            return _loc_2[0];
        }// end function

        public function get fileName() : String
        {
            return _fileName;
        }// end function

        public function toString() : String
        {
            return element;
        }// end function

        private function parseClassName(element:String) : String
        {
            var _loc_2:* = element.match(CLASS_NAME);
            if (_loc_2)
            {
            }
            if (_loc_2.length == 0)
            {
                return StringConst.EMPTY;
            }
            return _loc_2[0];
        }// end function

        private function parseNativeMethod(element:String) : Boolean
        {
            return element.indexOf("builtin::") != -1;
        }// end function

        public function get isStaticMethod() : Boolean
        {
            return _isStaticMethod;
        }// end function

        private function parseFileName(element:String) : String
        {
            var _loc_2:* = element.match(FILE_NAME);
            if (_loc_2)
            {
            }
            if (_loc_2.length == 0)
            {
                return StringConst.EMPTY;
            }
            return _loc_2[0];
        }// end function

    }
}
