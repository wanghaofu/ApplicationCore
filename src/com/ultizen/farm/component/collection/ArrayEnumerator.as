package com.ultizen.farm.component.collection
{
    import com.ultizen.farm.events.*;
    import flash.errors.*;
    import flash.events.*;

    public class ArrayEnumerator extends Object implements Enumerator
    {
        private var array:ProxyArray;
        private var _current:Object;
        private var pointer:int;
        private var isInvalidated:Boolean = false;

        public function ArrayEnumerator(array:ProxyArray)
        {
            reset();
            this.array = array;
            this.array.addEventListener(CollectionEvent.COLLECTION_CHANGE, array_collectionChangeHandler, false, 0, true);
            return;
        }// end function

        public function moveNext() : Boolean
        {
            if (isInvalidated)
            {
                throwInvalidationError();
            }
//            var _m:String = this;
			var _m:ArrayEnumerator = this;
            _m.pointer = this.pointer + 1;
            _current = this.array[++this.pointer];
            return _current != undefined;
        }// end function

        private function array_collectionChangeHandler(event:Event) : void
        {
            if (event is CollectionEvent)
            {
                isInvalidated = true;
            }
            return;
        }// end function

        public function reset() : void
        {
            if (isInvalidated)
            {
                throwInvalidationError();
            }
            this.pointer = -1;
            return;
        }// end function

        public function get current() : Object
        {
            if (this.array[this.pointer] == undefined)
            {
                throw new IllegalOperationError("Current pointer is undefined.");
            }
            return _current;
        }// end function

        private function throwInvalidationError() : void
        {
            throw new IllegalOperationError("Changes detected in collection.");
        }// end function

    }
}
