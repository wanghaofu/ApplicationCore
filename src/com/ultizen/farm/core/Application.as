package com.ultizen.farm.core
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.utils.getDefinitionByName;
	import Main
    public class Application extends MovieClip
    {
        private var hasApplicationLoadStarted:Boolean = false;
        protected var documentClassName:String = "Main";
        private var _documentRoot:DisplayObjectContainer = null;
        private static var _stage:Stage;

        public function Application()
        {
            super.stop(); //what means
            return;
        }// end function

        private function initializeApplicationIfLoaded() : void
        {
            if (!hasApplicationSWFLoaded())
            {
                return;
            }
            onApplicationLoadComplete();
            nextFrame();
            createDocumentRoot();
            onApplicationInitBegin();
            return;
        }// end function

        private function loaderInfo_initHandler(event:Event) : void
        {
            onApplicationLoadInit();
            return;
        }// end function

        protected function onApplicationLoadProgress(bytesLoaded:int, bytesTotal:int) : void
        {
            return;
        }// end function

        private function loaderInfo_ioErrorHandler(event:Event) : void
        {
            removeLoaderEventHandlers();
            onApplicationLoadError(new ApplicationError("Failed to load main application", ApplicationError.FAILED_TO_LOAD_MAIN_APP));
            return;
        }// end function

        final protected function loadApplication(configuration:XML) : void
        {
            if (hasApplicationLoadStarted)
            {
                throw new Error("The load operation has already begun.");
            }
            hasApplicationLoadStarted = true;
            registerLoaderInfoEventHandlersIfSWFNotLoaded();
            doApplicationSetup(configuration);
            doImmediateInitializationIfRequired();
            return;
        }// end function

        private function loaderInfo_completeHandler(event:Event) : void
        {
            removeLoaderEventHandlers();
            initializeApplicationIfLoaded();
            return;
        }// end function

        protected function getPreloaderView() : PreloaderView
        {
            return null; //?
        }// end function

        private function loaderInfo_progressHandler(event:ProgressEvent) : void
        {
            onApplicationLoadProgress(event.bytesLoaded, event.bytesTotal);
            return;
        }// end function

        protected function onApplicationInitBegin() : void
        {
            startMainApplication();
            return;
        }// end function

        private function registerLoaderInfoEventHandlersIfSWFNotLoaded() : void
        {
			trace(hasApplicationSWFLoaded(),"hasApplicationSWFLoaded")
            if (hasApplicationSWFLoaded())
            {
                return;
            }
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
            loaderInfo.addEventListener(Event.INIT, loaderInfo_initHandler);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderInfo_ioErrorHandler);
            loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
            return;
        }// end function

        private function startMainApplication() : void
        {
            InjectPreloaderView(addChild(_documentRoot)).preloaderView = getPreloaderView();
            onApplicationInitComplete();
            _stage = _documentRoot.stage;
            return;
        }// end function

        protected function get bytesLoaded() : uint
        {
            return loaderInfo.bytesLoaded;
        }// end function

        protected function onApplicationLoadError(error:ApplicationError) : void
        {
            return;
        }// end function

        protected function get bytesTotal() : uint
        {
            return loaderInfo.bytesTotal;
        }// end function

        protected function onApplicationLoadComplete() : void
        {
            return;
        }// end function

        private function doImmediateInitializationIfRequired() : void
        {
            var enterFrameHandler:Function;
            enterFrameHandler = function (event:Event) : void
            {
                removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
                initializeApplicationIfLoaded();
                return;
            }// end function
            ;
            if (!hasApplicationSWFLoaded())
            {
                return;
            }
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            onApplicationLoadInit();
            return;
        }// end function

        protected function onApplicationLoadInit() : void
        {
            return;
        }// end function

        private function removeLoaderEventHandlers() : void
        {
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
            loaderInfo.removeEventListener(Event.INIT, loaderInfo_initHandler);
            loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loaderInfo_ioErrorHandler);
            loaderInfo.removeEventListener(Event.COMPLETE, loaderInfo_completeHandler);
            return;
        }// end function

        private function hasApplicationSWFLoaded() : Boolean
        {
            return bytesLoaded == bytesTotal;
        }// end function

        private function doApplicationSetup(configuration:XML) : void
        {
            var configuration:* = configuration;
            ApplicationConfig.instance.initialize(this);
            try
            {
                ApplicationConfig.instance.config(configuration);
            }
            catch (e:Error)
            {
                trace("application ", e);
            }
            return;
        }// end function

        private function createDocumentRoot() : void
        {
          var clazz:Class;
            try
            {
				
//				new com.Base(); //base is Object
//				var t:Class = getDefinitionByName("com.Base") as Class;
//				new t();  //base is Object
				
//				var o:Object = getDefinitionByName("p"+i+"_mc");
//				var pp:* = new o;
//				allNewObj[i] = pp
//				addChild (pp);
				
				new Main();
				var clazz:Class =getDefinitionByName(documentClassName) as Class;
				
//                clazz = Class(getDefinitionByName(documentClassName));
                _documentRoot = new clazz as DisplayObjectContainer;
            }
            catch (e:TypeError)
            {
                onApplicationLoadError(new ApplicationError("Entry point class was null pointer or not a " + "DisplayObjectContainer. Unable to start application ", ApplicationError.FAILED_TO_LOAD_MAIN_APP));
                return;
                ;
            }
            catch (e:ReferenceError)
            {
                onApplicationLoadError(new ApplicationError("Missing entry point class \'" + documentClassName + "\'. Unable to start application ", ApplicationError.MISSING_ENTRY_POINT));
                return;
            }
            return;
        }// end function

        protected function onApplicationInitComplete() : void
        {
            return;
        }// end function

        public static function get stage() : Stage
        {
            return _stage;
        }// end function

    }
}
