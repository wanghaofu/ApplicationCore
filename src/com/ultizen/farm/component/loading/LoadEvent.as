package com.ultizen.farm.component.loading
{
    import flash.events.*;

    public class LoadEvent extends Event
    {
        public static const LOAD_ERROR:String = "loadError";

        public function LoadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            return;
        }// end function

    }
}
