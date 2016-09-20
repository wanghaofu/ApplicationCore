package com.ultizen.farm.component.collection
{

    public interface List extends Collection, Enumerable
    {

        public function List();

        function add(obj:Object) : int;

        function remove(obj:Object) : void;

        function indexOf(obj:Object) : int;

        function get isFixedSize() : Boolean;

        function get isReadOnly() : Boolean;

        function clear() : void;

        function getItem(index:int) : Object;

        function setItem(index:int, obj:Object) : void;

        function removeAt(index:int) : void;

        function insert(index:int, obj:Object) : void;

        function contains(obj:Object) : Boolean;

    }
}
