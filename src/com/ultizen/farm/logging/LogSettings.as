package com.ultizen.farm.logging
{
    import com.ultizen.farm.utils.text.*;

    public class LogSettings extends Object
    {

        public function LogSettings()
        {
            return;
        }// end function

        public function configure(settings:XML) : void
        {
            var filter:XML;
            var settings:* = settings;
            if (!settings)
            {
                throw new Error("Log settings XML cannot be null.");
            }
            if (!isXMLValid(settings))
            {
                throw new Error("Log settings XML is malformed");
            }
            Logger.instance.removeAllFilters();
            try
            {
                var _loc_3:int = 0;
                var _loc_4:* = settings.filter;
                while (_loc_4 in _loc_3)
                {
                    
                    filter = _loc_4[_loc_3];
                    Logger.instance.addFilter(Level.fromString(filter.@level.toUpperCase()), filter.@classname);
                }
            }
            catch (e:Error)
            {
                throw new Error("Log settings XML is invalid");
            }
            return;
        }// end function

        private function isXMLValid(xml:XML) : Boolean
        {
            var _loc_2:XML = null;
            if (xml)
            {
            }
            if (!xml.hasComplexContent())
            {
                return false;
            }
            if (XMLList(xml.filter).length() == 0)
            {
                return false;
            }
            for each (_loc_2 in xml.filter)
            {
                //tony
//                if (!isEmpty(_loc_2.@level))
//                {
//                    isEmpty(_loc_2.@level);
//                }
//                if (isEmpty(_loc_2.@classname))
				if(!_loc_2.@classsname)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function get instance() : LogSettings
        {
            return new LogSettings;
        }// end function

    }
}
