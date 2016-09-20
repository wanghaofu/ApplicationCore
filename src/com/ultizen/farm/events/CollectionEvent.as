package com.ultizen.farm.events
{
    import flash.events.*;

    public class CollectionEvent extends Event
    {
        public static const COLLECTION_CHANGE:String = "collectionChange";

        public function CollectionEvent(type:String)
        {
            super(type, false, false);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("CollectionEvent", "type", "bubbles", "cancelable");
        }// end function

        override public function clone() : Event
        {
            return new CollectionEvent(this.type);
        }// end function

    }
}
