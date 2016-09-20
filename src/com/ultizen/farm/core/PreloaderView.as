package com.ultizen.farm.core
{
	import flash.events.IEventDispatcher;
	
    public interface PreloaderView extends IEventDispatcher
    {

        public function PreloaderView();

        function onComplete() : void;

        function updatePercent(percent:Number) : void;

    }
}
