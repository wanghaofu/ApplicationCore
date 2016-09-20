package com.ultizen.farm.core
{

    public class ApplicationError extends Error
    {
        public static const MISSING_REQUIRED_FLASHVAR:int = 9;
        public static const MISSING_LOGGING_FILTERS:int = 3;
        public static const MALFORMED_CONFIGURATION_SETTING:int = 8;
        public static const EXTERNAL_CONFIG_ERROR:int = 1;
        public static const ABSTRACT_METHOD_ERROR:int = 11;
        public static const MISSING_ENTRY_POINT:int = 4;
        public static const EXTERNAL_CONFIG_MALFORMED:int = 2;
        public static const INSUFFICIENT_PLAYER_VERSION:int = 7;
        public static const FAILED_TO_LOAD_MAIN_APP:int = 5;
        public static const MISSING_CALL_TO_INITIALIZE:int = 10;
        public static const FAILED_TO_LOAD_EXTERNAL_CONFIG:int = 6;

        public function ApplicationError(message:String = "", id:int = 0)
        {
            super(message, id);
            return;
        }// end function

    }
}
