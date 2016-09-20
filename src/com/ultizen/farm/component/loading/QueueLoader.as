package com.ultizen.farm.component.loading
{
    import com.ultizen.farm.component.collection.*;
    import com.ultizen.farm.core.*;
    import com.ultizen.farm.events.*;
    import flash.events.*;

    public class QueueLoader extends AbstractLoaderComposite
    {
        private var loadItemIndex:uint = 0;
        public static const LOADING:Boolean = true;

        public function QueueLoader()
        {
            super(this);
            return;
        }// end function

        private function loadNext(loaderComponent:AbstractLoader) : void
        {
            removeItemListeners(loaderComponent);
//            var _loc_2:String = this;
			var _loc_2:QueueLoader =this;
            var _loc_3:* = this.loadItemIndex + 1;
            _loc_2.loadItemIndex = _loc_3;
            if (this.isRunning)
            {
                if (this.loadItemIndex == this.loadQueue.count)
                {
                    dispatchComplete();
                }
                else
                {
                    load();
                }
            }
            return;
        }// end function

        override public function add(loader:AbstractLoader) : void
        {
            super.add(loader);
            if (this.isRunning)
            {
            }
            if (!this.isLoading)
            {
                load();
            }
            return;
        }// end function

        override public function stop() : void
        {
            if (this.isRunning == LOADING)
            {
                getLoader(this.loadItemIndex).stop();
            }
            this.isRunning = IDLE;
            return;
        }// end function

        private function addItemListeners(loadItem:AbstractLoader) : void
        {
            loadItem.addEventListener(Event.COMPLETE, loadItem_completeHandler);
            loadItem.addEventListener(IOErrorEvent.IO_ERROR, loadItem_errorHandler);
            loadItem.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadItem_errorHandler);
            loadItem.addEventListener(IOErrorEvent.NETWORK_ERROR, loadItem_errorHandler);
            loadItem.addEventListener(IOErrorEvent.DISK_ERROR, loadItem_errorHandler);
            loadItem.addEventListener(IOErrorEvent.VERIFY_ERROR, loadItem_errorHandler);
            loadItem.addEventListener(ProgressEvent.PROGRESS, loadItem_progressHandler);
            loadItem.addEventListener(AssetTotalBytesEvent.CHANGE, loadItem_changeHandler);
            return;
        }// end function

        protected function load() : void
        {
            this.isLoading = LOADING;
            addItemListeners(getLoader(this.loadItemIndex));
            getLoader(this.loadItemIndex).start();
            return;
        }// end function

        override public function get bytesTotal() : uint
        {
            return calcBytesTotal();
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

        private function removeItemListeners(loadItem:AbstractLoader) : void
        {
            loadItem.removeEventListener(Event.COMPLETE, loadItem_completeHandler);
            loadItem.removeEventListener(IOErrorEvent.IO_ERROR, loadItem_errorHandler);
            loadItem.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadItem_errorHandler);
            loadItem.removeEventListener(IOErrorEvent.NETWORK_ERROR, loadItem_errorHandler);
            loadItem.removeEventListener(IOErrorEvent.DISK_ERROR, loadItem_errorHandler);
            loadItem.removeEventListener(IOErrorEvent.VERIFY_ERROR, loadItem_errorHandler);
            loadItem.removeEventListener(ProgressEvent.PROGRESS, loadItem_progressHandler);
            loadItem.removeEventListener(AssetTotalBytesEvent.CHANGE, loadItem_changeHandler);
            return;
        }// end function

        private function loadItem_completeHandler(event:Event) : void
        {
            loadNext(AbstractLoader(event.currentTarget));
            return;
        }// end function

        private function calcBytesTotal() : uint
        {
            var _loc_1:int = 0;
            var _loc_2:* = this.loadQueue.getEnumerator();
            while (_loc_2.moveNext())
            {
                
                _loc_1 = _loc_1 + AbstractLoader(_loc_2.current).bytesTotal;
            }
            return _loc_1;
        }// end function

        override public function reset() : void
        {
            stop();
            this.isLoading = IDLE;
            this.loadItemIndex = 0;
            super.reset();
            return;
        }// end function

        override public function get bytesLoaded() : uint
        {
            return calcBytesLoaded();
        }// end function

        private function loadItem_changeHandler(event:Event) : void
        {
            dispatchEvent(new AssetTotalBytesEvent(AssetTotalBytesEvent.CHANGE, calcBytesTotal()));
            return;
        }// end function

        override public function pause() : void
        {
            if (this.isRunning == LOADING)
            {
                try
                {
                    getLoader(this.loadItemIndex).pause();
                }
                catch (error:UnsupportedMethodException)
                {
                }
            }
            isRunning = IDLE;
            return;
        }// end function

        private function loadItem_errorHandler(event:Event) : void
        {
            loadNext(AbstractLoader(event.currentTarget));
            dispatchEvent(new LoadEvent(LoadEvent.LOAD_ERROR));
            return;
        }// end function

        private function getLoader(index:int) : AbstractLoader
        {
            return this.loadQueue.getItem(index) as AbstractLoader;
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

        private function loadItem_progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:* = new ProgressEvent(ProgressEvent.PROGRESS);
            _loc_2.bytesLoaded = calcBytesLoaded();
            _loc_2.bytesTotal = calcBytesTotal();
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
