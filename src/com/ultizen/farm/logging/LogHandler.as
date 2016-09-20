package com.ultizen.farm.logging
{

    public interface LogHandler
    {

        public function LogHandler();

        function notify(message:Message) : void;

    }
}
