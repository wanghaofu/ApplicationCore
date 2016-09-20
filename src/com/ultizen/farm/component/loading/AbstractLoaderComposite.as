package com.ultizen.farm.component.loading
{
    import flash.utils.*;

    public class AbstractLoaderComposite extends AbstractLoader
    {
        public var _name:String;
        protected var loadQueue:LoaderCollection;
        protected var isLoading:Boolean = false;
        protected var isRunning:Boolean = false;
        public static const IDLE:Boolean = false;
        public static const RUNNING:Boolean = true;

        public function AbstractLoaderComposite(self:AbstractLoaderComposite)
        {
            loadQueue = new LoaderCollection();
            super(this);
            if (self != this)
            {
                throw new ArgumentError(getQualifiedClassName(this) + " cannot be instantiated.");
            }
            return;
        }// end function

        override public function add(loader:AbstractLoader) : void
        {
            this.loadQueue.add(loader);
            return;
        }// end function

        public function get length() : uint
        {
            return this.loadQueue.count;
        }// end function

        override public function getChild(index:int) : AbstractLoader
        {
            return AbstractLoader(this.loadQueue.getItem(index));
        }// end function

        public function reset() : void
        {
            this.loadQueue.clear();
            return;
        }// end function

        override public function insert(loader:AbstractLoader, index:int) : void
        {
            this.loadQueue.insert(index, loader);
            return;
        }// end function

        override public function remove(loader:AbstractLoader) : void
        {
            this.loadQueue.remove(loader);
            return;
        }// end function

    }
}
