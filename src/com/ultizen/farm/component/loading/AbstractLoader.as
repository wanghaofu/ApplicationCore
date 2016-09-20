package com.ultizen.farm.component.loading
{
    import com.ultizen.farm.core.UnsupportedMethodException;
    
    import flash.events.EventDispatcher;
    import flash.system.LoaderContext;
    import flash.utils.getQualifiedClassName;

    public class AbstractLoader extends EventDispatcher
    {

        public function AbstractLoader(self:AbstractLoader)
        {
            if (self != this)
            {
                throw new ArgumentError(getQualifiedClassName(this) + " cannot be instantiated.");
            }
            return;
        }// end function

        public function get content():*
        {
            throw new UnsupportedMethodException();
        }// end function

        public function add(item:AbstractLoader) : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function stop() : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function remove(item:AbstractLoader) : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function getChild(index:int) : AbstractLoader
        {
            throw new UnsupportedMethodException();
        }// end function

        public function insert(item:AbstractLoader, index:int) : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function start() : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function get url() : String
        {
            throw new UnsupportedMethodException();
        }// end function

        public function get bytesLoaded() : uint
        {
            throw new UnsupportedMethodException();
        }// end function

        public function pause() : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function set loaderContext(value:LoaderContext) : void
        {
            throw new UnsupportedMethodException();
        }// end function

        public function get bytesTotal() : uint
        {
            throw new UnsupportedMethodException();
        }// end function

        public function get loaderContext() : LoaderContext
        {
            throw new UnsupportedMethodException();
        }// end function

        public function set url(value:String) : void
        {
            throw new UnsupportedMethodException();
        }// end function

    }
}
