package com.ultizen.farm.component.collection
{

    public interface Enumerator
    {

        public function Enumerator();

        function get current() : Object;

        function moveNext() : Boolean;

        function reset() : void;

    }
}
