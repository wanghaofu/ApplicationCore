package com.ultizen.farm.core
{

    public class FeedItem extends Object
    {
        private var _url:String;
        private var _imageUrl:String;

        public function FeedItem(url:String, imageUrl:String)
        {
			
            _url = "xml/" + url;
            _imageUrl = imageUrl;
            return;
        }// end function

        public function get imageUrl() : String
        {
            return _imageUrl;
        }// end function

        public function get url() : String
        {
            return _url;
        }// end function

    }
}
