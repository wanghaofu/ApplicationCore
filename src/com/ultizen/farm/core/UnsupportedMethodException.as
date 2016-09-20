package com.ultizen.farm.core
{
    public class UnsupportedMethodException extends Error
    {
        public function UnsupportedMethodException(message:String = "", id:int = 0)
        {
            super(message, id);
            return;
        }// end function
    }
}
