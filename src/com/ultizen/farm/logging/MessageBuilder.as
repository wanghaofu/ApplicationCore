package com.ultizen.farm.logging
{
    import com.adobe.utils.*;
    import com.ultizen.farm.core.*;
    import com.ultizen.farm.utils.*;
    import com.ultizen.farm.utils.text.*;
    import flash.system.*;
    import flash.utils.*;

  public  class MessageBuilder extends Object
    {
        private var stackElement:StackTraceElement = null;

        function MessageBuilder()
        {
            return;
        }// end function

        private function isMessageLevelLessThanFilterLevel(level:Level, filters:Dictionary) : Boolean
        {
            var _loc_3:String = null;
            var _loc_4:Level = null;
            if (filters)
            {
            }
            if (isDebugPlayer)
            {
                if (!stackElement)
                {
                }
                stackElement = findCallerElementInStack();
                _loc_3 = stackElement.className.replace("::", ".");
                _loc_4 = findClassOrPackageFilter(_loc_3, filters);
                if (_loc_4)
                {
                    return level.value < _loc_4.value;
                }
            }
            else
            {
                if (filters)
                {
                }
                if (filters.hasOwnProperty("*"))
                {
                    return level.value < Level(filters["*"]).value;
                }
            }
            return true;
        }// end function

        private function findCallerElementInStack() : StackTraceElement
        {
            return StackTraceParser.instance.parseElementAt(new Error().getStackTrace(), 5);
        }// end function

        private function buildMessage(level:Level, parts:Array) : Message
        {
            var _loc_3:* = StringConst.EMPTY;
            var _loc_4:int = -1;
            if (isDebugPlayer)
            {
                if (!stackElement)
                {
                }
                stackElement = findCallerElementInStack();
                _loc_3 = stackElement.className;
                _loc_4 = stackElement.lineNumber;
            }
            return new Message(parts, level, ApplicationConfig.instance.upTime, new Date(), _loc_3, _loc_4);
        }// end function

        private function get isDebugPlayer() : Boolean
        {
            return Capabilities.isDebugger;
        }// end function

        public function createMessage(level:Level, parts:Array, filters:Dictionary) : Message
        {
            if (DictionaryUtil.getKeys(filters).length != 0)
            {
            }
            if (isMessageLevelLessThanFilterLevel(level, filters))
            {
                return null;
            }
            return buildMessage(level, parts);
        }// end function

        private function findClassOrPackageFilter(target:String, filters:Dictionary) : Level
        {
            if (filters.hasOwnProperty(target))
            {
                return Level(filters[target]);
            }
            if (target == "*")
            {
                return null;
            }
            return findClassOrPackageFilter(target.replace(/\w+(\.\*)?$|^$/, "*"), filters);
        }// end function

        public static function get instance() : MessageBuilder
        {
            return new MessageBuilder;
        }// end function

    }
}
