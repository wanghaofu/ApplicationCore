package com.ultizen.farm.component.loading
{
    import com.ultizen.farm.events.AssetTotalBytesEvent;
    
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;

    public class LoaderItem extends AbstractLoader
    {
        private var _loaderContext:LoaderContext;
        private var _url:String;
        private var _loader:Loader;
        private var _bytesTotal:uint;

        public function LoaderItem(url:String, bytesTotal:uint = 0)
        {
            super(this);
            _url = url;
            _bytesTotal = bytesTotal;
            _loaderContext = null;
            return;
        }// end function

        protected function get contentDispatcher() : IEventDispatcher
        {
            return this.loader.contentLoaderInfo;
        }// end function

        private function dispatcher_errorHandler(event:Event) : void
        {
            dispatchEventAndRemoveListeners(event);
            return;
        }// end function

        override public function stop() : void
        {
            removeAllListeners();
            try
            {
                this.loader.close();
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        private function dispatcher_progressHandler(event:ProgressEvent) : void
        {
            if (event.bytesTotal != this.bytesTotal)
            {
                _bytesTotal = event.bytesTotal;
                dispatchEvent(new AssetTotalBytesEvent(AssetTotalBytesEvent.CHANGE, _bytesTotal));
            }
            dispatchEvent(event);
            return;
        }// end function

        private function dispatcher_completeHandler(event:Event) : void
        {
            dispatchEventAndRemoveListeners(event);
            return;
        }// end function

        private function removeAllListeners() : void
        {
            removeListener(Event.COMPLETE, dispatcher_completeHandler);
            removeListener(Event.INIT, dispatcher_initHandler);
            removeListener(ProgressEvent.PROGRESS, dispatcher_progressHandler);
            removeListener(IOErrorEvent.IO_ERROR, dispatcher_errorHandler);
            removeListener(IOErrorEvent.NETWORK_ERROR, dispatcher_errorHandler);
            removeListener(IOErrorEvent.DISK_ERROR, dispatcher_errorHandler);
            removeListener(IOErrorEvent.VERIFY_ERROR, dispatcher_errorHandler);
            removeListener(SecurityErrorEvent.SECURITY_ERROR, dispatcher_errorHandler);
            return;
        }// end function

        override public function get bytesLoaded() : uint
        {
            return this.loader.contentLoaderInfo.bytesLoaded;
        }// end function

        private function dispatcher_initHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function get loader() : Loader
        {
            if (_loader is Loader)
            {
				return _loader
               
            }else{
				_loader = createLoader();
			}
				
            return _loader;
        }// end function

        private function removeListener(type:String, listener:Function) : void
        {
            this.contentDispatcher.removeEventListener(type, listener);
            return;
        }// end function

        override public function get bytesTotal() : uint
        {
            return _bytesTotal;
        }// end function

        override public function get loaderContext() : LoaderContext
        {
            return _loaderContext;
        }// end function

        private function addAllListeners() : void
        {
            addListener(Event.COMPLETE, dispatcher_completeHandler);
            addListener(Event.INIT, dispatcher_initHandler);
            addListener(ProgressEvent.PROGRESS, dispatcher_progressHandler);
            addListener(IOErrorEvent.IO_ERROR, dispatcher_errorHandler);
            addListener(IOErrorEvent.NETWORK_ERROR, dispatcher_errorHandler);
            addListener(IOErrorEvent.DISK_ERROR, dispatcher_errorHandler);
            addListener(IOErrorEvent.VERIFY_ERROR, dispatcher_errorHandler);
            addListener(SecurityErrorEvent.SECURITY_ERROR, dispatcher_errorHandler);
            return;
        }// end function

        override public function start() : void
        {
            addAllListeners();
            this.loader.load(new URLRequest(this.url), _loaderContext);
            return;
        }// end function

        private function dispatchEventAndRemoveListeners(event:Event) : void
        {
            dispatchEvent(event);
            removeAllListeners();
            return;
        }// end function

        override public function get url() : String
        {
            return _url;
        }// end function

        private function addListener(type:String, listener:Function) : void
        {
            this.contentDispatcher.addEventListener(type, listener);
            return;
        }// end function

        protected function createLoader() : Loader
        {
            return new Loader();
        }// end function

        override public function set loaderContext(value:LoaderContext) : void
        {
            _loaderContext = value;
            return;
        }// end function

        override public function get content():*
        {
            return this.loader;
        }// end function

    }
}
