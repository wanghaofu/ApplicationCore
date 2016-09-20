package com.ultizen.farm.component.collection
{
    import com.ultizen.farm.events.CollectionEvent;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.utils.Proxy;

    dynamic public class ProxyArray extends Proxy implements IEventDispatcher
    {
        private var items:Array;
        private var _dispatcher:IEventDispatcher = null;

        public function ProxyArray(... args)
        {
            items = [];
            this.items = args.concat();
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this.dispatcher.dispatchEvent(event);
        }// end function

//        override function nextValue(index:int)
	public	function nextValue(index:int):*
        {
            return this.items[(index - 1)];
        }// end function

        protected function get dispatcher() : IEventDispatcher
        {
            if (!_dispatcher)
            {
                var _loc_1:* = createDispatcher();
                _dispatcher = createDispatcher();
            }
            return _loc_1;
        }// end function

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
            this.dispatcher.removeEventListener(type, listener, useCapture);
            return;
        }// end function

//		override  public function getProperty(name)  //tony
		  public function getProperty(name)  :String
        {
            return this.items[name];
        }// end function

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
            this.dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
            return;
        }// end function

//        override function deleteProperty(name) : Boolean
		public function deleteProperty(name) : Boolean
        {
            var _loc_2:* = delete this.items[name];
            dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
            return _loc_2;
        }// end function

        protected function createDispatcher() : IEventDispatcher
        {
            return new EventDispatcher(this);
        }// end function

//        override public function nextNameIndex(index:int) : int
		public function nextNameIndex(index:int) : int
        {
            if (index < this.items.length)
            {
                return (index + 1);
            }
            return 0;
        }// end function

        public function willTrigger(type:String) : Boolean
        {
            return this.dispatcher.willTrigger(type);
        }// end function

//        override function setProperty(name, value) : void //tony
		public function setProperty(name, value) : void
        {
            this.items[name] = value;
            dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
            return;
        }// end function

//        override function callProperty(methodName, ... args)  //tony
		public function callProperty(methodName, ... args):*  //tony
        {
//           var args = false; //tony
            var _loc_4:* = items[methodName].apply(items, args);
            if (methodName is QName)
            {
                methodName = QName(methodName).localName;
            }
            switch(methodName)
            {
                case "pop":
                case "push":
                case "reverse":
                case "shift":
                case "sort":
                case "sortOn":
                case "splice":
                case "unshift":
                {
                    dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_4;
        }// end function

        public function hasEventListener(type:String) : Boolean
        {
            return this.dispatcher.hasEventListener(type);
        }// end function

//        override function nextName(index:int) : String
		public function nextName(index:int) : String
        {
            return this.items[(index - 1)];
        }// end function

    }
}
