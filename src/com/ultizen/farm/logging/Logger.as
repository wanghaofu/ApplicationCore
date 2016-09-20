package com.ultizen.farm.logging
{
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    public class Logger extends Object
    {
        private static var _instance:Logger;
           private static var handlers:Dictionary = new Dictionary();
        private static var filters:Dictionary = new Dictionary();

        public function Logger()
        {
            return;
        }// end function

        public function notify(level:Level, parts:Array) : void
        {
            var _loc_4:LogHandler = null;
            var _loc_3:* = MessageBuilder.instance.createMessage(level, parts, filters);
            if (_loc_3)
            {
                for each (_loc_4 in handlers)
                {
                    
                    _loc_4.notify(_loc_3);
                }
            }
            return;
        }// end function

        public function addLogger(logger:LogHandler) : void
        {
            var _loc_2:* = getQualifiedClassName(logger);
            var _loc_3:* = getDefinitionByName(_loc_2) as Class;
            if (handlers[_loc_3])
            {
                throw new ArgumentError(getQualifiedClassName(logger) + " instance already added to Log.");
            }
            handlers[_loc_3] = logger;
            return;
        }// end function

        public function removeLogger(loggerType:Class) : LogHandler
        {
            var _loc_2:LogHandler = null;
            if (handlers[loggerType])
            {
                _loc_2 = handlers[loggerType];
                delete handlers[loggerType];
                return _loc_2;
            }
            return null;
        }// end function

        public function getFilter(pkg:String) : Level
        {
            return filters[pkg];
        }// end function

        public function getLogger(loggerType:Class) : LogHandler
        {
            if (handlers[loggerType])
            {
                return handlers[loggerType];
            }
            return null;
        }// end function

        public function addFilter(level:Level, pkg:String) : void
        {
            filters[pkg] = level;
            return;
        }// end function

        public function removeFilter(pkg:String) : void
        {
            delete filters[pkg];
            return;
        }// end function

        public function removeAllFilters() : void
        {
            filters = new Dictionary();
            return;
        }// end function

        public static function get instance() : Logger
        {
            if (_instance is Logger)
            {
				return _instance;
				
            } else
			{
				var _loc_1:* = new Logger;
				_instance =  _loc_1;
				return _instance;
			}
           
        }// end function

    }
}
