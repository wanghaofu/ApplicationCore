package com.adobe.utils
{

    public class ArrayUtil extends Object
    {

        public function ArrayUtil()
        {
            return;
        }// end function

        public static function arraysAreEqual(arr1:Array, arr2:Array) : Boolean
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            if (arr1.length != arr2.length)
            {
                return false;
            }
            _loc_3 = arr1.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (arr1[_loc_4] !== arr2[_loc_4])
                {
                    return false;
                }
                _loc_4 = _loc_4 + 1;
            }
            return true;
        }// end function

        public static function arrayContainsValue(arr:Array, value:Object) : Boolean
        {
            return arr.indexOf(value) != -1;
        }// end function

        public static function copyArray(arr:Array) : Array
        {
            return arr.slice();
        }// end function

        public static function removeValueFromArray(arr:Array, value:Object) : void
        {
            var _loc_3:uint = 0;
            var _loc_4:Number = NaN;
            _loc_3 = arr.length;
            _loc_4 = _loc_3;
            while (_loc_4 > -1)
            {
                
                if (arr[_loc_4] === value)
                {
                    arr.splice(_loc_4, 1);
                }
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        public static function createUniqueCopy(a:Array) : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            var _loc_5:uint = 0;
            _loc_2 = new Array();
            _loc_3 = a.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = a[_loc_5];
                if (arrayContainsValue(_loc_2, _loc_4))
                {
                }
                else
                {
                    _loc_2.push(_loc_4);
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_2;
        }// end function

    }
}
