package com.ultizen.farm.component.loading
{
    import com.ultizen.farm.events.*;
    import flash.events.*;
    import flash.net.*;

    public class URLLoaderItem extends AbstractLoader
    {
        private var _loader:URLLoader;
        private var request:URLRequest;
        private var _bytesTotal:uint;

        public function URLLoaderItem(url:String, bytesTotal:uint = 0)
        {
            super(this);
            request = url ? (new URLRequest(url)) : (null);
            _bytesTotal = bytesTotal;
            return;
        }// end function

        protected function set _url(value:String) : void
        {
            request.url = value;
            return;
        }// end function

        override public function start() : void
        {
            if (request == null)
            {
                throw new Error("Invalid loader state -- " + "target url is null or undefined.");
            }
            addLoaderListeners();
            loader.load(request);
            return;
        }// end function

        private function addLoaderListeners() : void
        {
            loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            loader.addEventListener(Event.INIT, loader_startHandler);
            loader.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
            loader.addEventListener(IOErrorEvent.NETWORK_ERROR, loader_errorHandler);
            loader.addEventListener(IOErrorEvent.DISK_ERROR, loader_errorHandler);
            loader.addEventListener(IOErrorEvent.VERIFY_ERROR, loader_errorHandler);
            return;
        }// end function

        protected function loader_completeHandler(event:Event) : void
        {
            dispatchEventAndRemoveListeners(event);
            return;
        }// end function

        override public function get url() : String
        {
            return request.url;
        }// end function

        private function removeLoaderListeners() : void
        {
            loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
            loader.removeEventListener(Event.INIT, loader_startHandler);
            loader.removeEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
            loader.removeEventListener(IOErrorEvent.NETWORK_ERROR, loader_errorHandler);
            loader.removeEventListener(IOErrorEvent.DISK_ERROR, loader_errorHandler);
            loader.removeEventListener(IOErrorEvent.VERIFY_ERROR, loader_errorHandler);
            return;
        }// end function

        public function set dataFormat(value:String) : void
        {
            loader.dataFormat = value;
            return;
        }// end function

        private function dispatchEventAndRemoveListeners(event:Event) : void
        {
            dispatchEvent(event);
            removeLoaderListeners();
            return;
        }// end function

        protected function loader_errorHandler(event:Event) : void
        {
            dispatchEventAndRemoveListeners(event);
            return;
        }// end function

        protected function createLoader() : URLLoader
        {
            return new URLLoader();
        }// end function

        override public function stop() : void
        {
            removeLoaderListeners();
            try
            {
                loader.close();
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        private function get loader() : URLLoader
        {
            if (!_loader)
            {
            }
            var _loc_1:* = createLoader();
            _loader = createLoader();
            return _loc_1;
        }// end function

        private function loader_startHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        override public function get bytesLoaded() : uint
        {
            return loader.bytesLoaded;
        }// end function

        private function loader_progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:AssetTotalBytesEvent = null;
            if (event.bytesTotal != _bytesTotal)
            {
                _bytesTotal = event.bytesTotal;
                _loc_2 = new AssetTotalBytesEvent(AssetTotalBytesEvent.CHANGE, _bytesTotal);
                dispatchEvent(_loc_2);
            }
            dispatchEvent(event);
            return;
        }// end function

        override public function get content()
        {
            return loader.data;
        }// end function

        override public function get bytesTotal() : uint
        {
            return _bytesTotal;
        }// end function

        public static function createWithRequest(request:URLRequest, estimatedBytesTotal:int = 0) : URLLoaderItem
        {
            var _loc_3:* = new URLLoaderItem(null, estimatedBytesTotal);
            _loc_3.request = request;
            return _loc_3;
        }// end function

    }
}
