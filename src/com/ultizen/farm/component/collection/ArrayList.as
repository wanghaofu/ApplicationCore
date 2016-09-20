package com.ultizen.farm.component.collection
{

    public class ArrayList extends Object implements List
    {
        private var elements:Array;

        public function ArrayList()
        {
            elements = new Array();
            return;
        }// end function

        public function insert(index:int, obj:Object) : void
        {
            if (obj == null)
            {
                throw new Error();
            }
            if (index >= 0)
            {
            }
            if (index > this.elements.length)
            {
                throw new Error("Index " + index + " is out of range.");
            }
            this.elements.splice(index, 0, obj);
            return;
        }// end function

        public function getEnumerator() : Enumerator
        {
			return null;
            //return new ArrayEnumerator(this.elements);
        }// end function

        public function remove(obj:Object) : void
        {
            this.elements.splice(this.elements.indexOf(obj), 1);
            return;
        }// end function

        public function indexOf(obj:Object) : int
        {
            return this.elements.indexOf(obj);
        }// end function

        public function get isFixedSize() : Boolean
        {
            return false;
        }// end function

        public function getItem(index:int) : Object
        {
            if (index >= 0)
            {
            }
            if (index >= this.elements.length)
            {
                throw new Error("Index " + index + " is out of range.");
            }
            return this.elements[index];
        }// end function

        public function clear() : void
        {
            this.elements = new Array();
            return;
        }// end function

        public function setItem(index:int, obj:Object) : void
        {
            if (index >= 0)
            {
            }
            if (index >= this.elements.length)
            {
                throw new Error("Index " + index + " is out of range.");
            }
            this.elements[index] = obj;
            return;
        }// end function

        public function get count() : int
        {
            return elements.length;
        }// end function

        public function removeAt(index:int) : void
        {
            if (index >= 0)
            {
            }
            if (index >= this.elements.length)
            {
                throw new Error("Index " + index + " is out of range.");
            }
            this.elements.splice(index, 1);
            return;
        }// end function

        public function add(obj:Object) : int
        {
            if (obj == null)
            {
                throw new Error();
            }
            return elements.push(obj);
        }// end function

        public function toArray() : Array
        {
            return this.elements.concat();
        }// end function

        public function contains(obj:Object) : Boolean
        {
            return this.elements.indexOf(obj) != -1;
        }// end function

        public function get isReadOnly() : Boolean
        {
            return false;
        }// end function

    }
}
