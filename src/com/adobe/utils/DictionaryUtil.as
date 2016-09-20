package com.adobe.utils
{
    import flash.utils.*;

    public class DictionaryUtil extends Object
    {

        public function DictionaryUtil()
        {
            return;
        }// end function

        public static function getValues(d:Dictionary) : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            _loc_2 = new Array();
            for each (_loc_3 in d)
            {
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function getKeys(d:Dictionary) : Array
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            _loc_2 = new Array();
            for (_loc_3 in d)
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

    }
}
