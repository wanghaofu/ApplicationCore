package com.ultizen.farm.component.loading
{
    import flash.events.*;

    public class BackupURLLoaderItem extends URLLoaderItem
    {
        private var isBackup:Boolean;
        private var backupUrl:String;
        private var originalUrl:String;
        private static const ERROR_RESPONSE:String = "error";

        public function BackupURLLoaderItem(url:String, backupUrl:String, bytesTotal:uint = 0)
        {
            super(url, bytesTotal);
            this.originalUrl = url;
            this.backupUrl = backupUrl;
            return;
        }// end function

        override public function start() : void
        {
            _url = originalUrl;
            isBackup = false;
            super.start();
            return;
        }// end function

        override protected function loader_completeHandler(event:Event) : void
        {
            var feedXML:XML;
            var event:* = event;
            if (isBackup)
            {
                super.loader_completeHandler(event);
                return;
            }
            try
            {
                feedXML = XML(this.content);
                if (feedXML.name().toString().toLowerCase() == ERROR_RESPONSE)
                {
                    loadBackup();
                }
                else
                {
                    super.loader_completeHandler(event);
                }
            }
            catch (e:TypeError)
            {
                loadBackup();
            }
            return;
        }// end function

        override protected function loader_errorHandler(event:Event) : void
        {
            if (isBackup)
            {
                super.loader_errorHandler(event);
            }
            else
            {
                loadBackup();
            }
            return;
        }// end function

        private function loadBackup() : void
        {
            _url = backupUrl;
            isBackup = true;
            super.start();
            return;
        }// end function

    }
}
