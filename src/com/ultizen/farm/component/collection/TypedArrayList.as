package com.ultizen.farm.component.collection
{
    import flash.utils.*;

    public class TypedArrayList extends ArrayList
    {
        private var _type:Class;

        public function TypedArrayList(type:Class)
        {
            _type = type;
            return;
        }// end function

        override public function add(obj:Object) : int
        {
            validateType(obj);
            return super.add(obj);
        }// end function

        override public function remove(obj:Object) : void
        {
            validateType(obj);
            super.remove(obj);
            return;
        }// end function

        override public function contains(obj:Object) : Boolean
        {
            validateType(obj);
            return super.contains(obj);
        }// end function

        override public function indexOf(obj:Object) : int
        {
            validateType(obj);
            return super.indexOf(obj);
        }// end function

        override public function insert(index:int, obj:Object) : void
        {
            validateType(obj);
            super.insert(index, obj);
            return;
        }// end function

        override public function setItem(index:int, obj:Object) : void
        {
            validateType(obj);
            super.setItem(index, obj);
            return;
        }// end function

        public function validateType(instance) : void
        {
            if (!(instance is type))
            {
                throw new TypeError(getQualifiedClassName(instance) + " is not of Type " + getQualifiedClassName(type));
            }
            return;
        }// end function

        public function get type() : Class
        {
            return _type;
        }// end function

    }
}
