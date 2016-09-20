package com.ultizen.farm.component.loading
{
    import com.ultizen.farm.component.collection.*;
    import com.ultizen.farm.core.*;
    import com.ultizen.farm.events.*;
    import flash.events.*;

    public class ConcurrentLoader extends AbstractLoaderComposite
    {
        private var numFinished:uint = 0;

        public function ConcurrentLoader()
        {
            super(this);
            return;
        }// end function

        override public function add(loader:AbstractLoader) : void
        {
            super.add(loader);
            if (this.isRunning)
            {
                loader.start();
            }
            return;
        }// end function

        override public function start() : void
        {
            dispatchEvent(new Event(Event.INIT));
            this.isRunning = RUNNING;
            if (this.loadQueue.count > 0)
            {
                load();
            }
            else
            {
                dispatchComplete();
            }
            return;
        }// end function

        protected function load() : void
        {
            var _loc_1:* = this.loadQueue.getEnumerator();
            while (_loc_1.moveNext())
            {
                
                addItemListeners(AbstractLoader(_loc_1.current));
                AbstractLoader(_loc_1.current).start();
            }
            return;
        }// end function

        private function removeItemListeners(loadItem:AbstractLoader) : void
        {
            loadItem.removeEventListener(Event.COMPLETE, completeHandler);
            loadItem.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorEventHandler);
            loadItem.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorEventHandler);
            loadItem.removeEventListener(IOErrorEvent.NETWORK_ERROR, ioErrorEventHandler);
            loadItem.removeEventListener(IOErrorEvent.DISK_ERROR, ioErrorEventHandler);
            loadItem.removeEventListener(IOErrorEvent.VERIFY_ERROR, ioErrorEventHandler);
            loadItem.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            return;
        }// end function

        override public function stop() : void
        {
            this.isRunning = IDLE;
            var _loc_1:* = this.loadQueue.getEnumerator();
            while (_loc_1.moveNext())
            {
                
                AbstractLoader(_loc_1.current).stop();
            }
            return;
        }// end function

        private function addItemListeners(loadItem:AbstractLoader) : void
        {
            loadItem.addEventListener(Event.COMPLETE, completeHandler);
            loadItem.addEventListener(IOErrorEvent.IO_ERROR, ioErrorEventHandler);
            loadItem.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorEventHandler);
            loadItem.addEventListener(IOErrorEvent.NETWORK_ERROR, ioErrorEventHandler);
            loadItem.addEventListener(IOErrorEvent.DISK_ERROR, ioErrorEventHandler);
            loadItem.addEventListener(IOErrorEvent.VERIFY_ERROR, ioErrorEventHandler);
            loadItem.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            return;
        }// end function

        private function calcBytesTotal() : uint
        {
            var _loc_1:uint = 0;
            var _loc_2:* = this.loadQueue.getEnumerator();
            while (_loc_2.moveNext())
            {
                
                _loc_1 = _loc_1 + AbstractLoader(_loc_2.current).bytesTotal;
            }
            return _loc_1;
        }// end function

        private function completeHandler(event:Event) : void
        {
            removeItemListeners(AbstractLoader(event.currentTarget));
            checkIfAllComplete();
            return;
        }// end function

        private function ioErrorEventHandler(event:Event) : void
        {
            removeItemListeners(AbstractLoader(event.currentTarget));
            checkIfAllComplete();
            return;
        }// end function

        private function checkIfAllComplete() : void
        {
//            var loc1:String=this;
			var loc1:ConcurrentLoader=this;
            var loc2:* = this.numFinished+1;
           loc1.numFinished = loc2;
            if (this.loadQueue.count == this.numFinished)
            {
                dispatchComplete();
            }
            return;
        }// end function

        override public function pause() : void
        {
            this.isRunning = IDLE;
            var _loc_1:* = this.loadQueue.getEnumerator();
            while (_loc_1.moveNext())
            {
                
                pauseChildComponent(AbstractLoader(_loc_1.current));
            }
            return;
        }// end function

        private function pauseChildComponent(component:AbstractLoader) : void
        {
            var component:* = component;
            try
            {
                component.pause();
            }
            catch (e:UnsupportedMethodException)
            {
            }
            return;
        }// end function

        override public function get bytesTotal() : uint
        {
            return calcBytesTotal();
        }// end function

        private function dispatchComplete() : void
        {
            this.isLoading = IDLE;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function calcBytesLoaded() : uint
        {
            var _loc_1:uint = 0;
            var _loc_2:* = this.loadQueue.getEnumerator();
            while (_loc_2.moveNext())
            {
                
                _loc_1 = _loc_1 + AbstractLoader(_loc_2.current).bytesLoaded;
            }
            return _loc_1;
        }// end function

        private function progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:* = new ProgressEvent(ProgressEvent.PROGRESS);
            _loc_2.bytesLoaded = calcBytesLoaded();
            _loc_2.bytesTotal = calcBytesTotal();
            dispatchEvent(new AssetTotalBytesEvent(AssetTotalBytesEvent.CHANGE, this.bytesTotal));
            dispatchEvent(_loc_2);
            return;
        }// end function

        override public function get bytesLoaded() : uint
        {
            return calcBytesLoaded();
        }// end function

    }
}
