package com.ultizen.farm.core
{
    import com.ultizen.farm.logging.LogSettings;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.EventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.system.Capabilities;
    import flash.system.Security;
    import flash.system.SecurityDomain;
    import flash.utils.Dictionary;

    public class ApplicationConfig extends EventDispatcher
    {
        private var _clientPlayerSupported:Boolean = false;
        private var _headImg:String = "";
        private var hasFullScreen:Boolean = false;
        private var _feeds:Dictionary;
        private var _projectSettings:Dictionary;
        private var _assets:Dictionary;
        private var _language:String = "";
        private var _baseSiteDomain:String = "";
        private var _userID:String = "";
        private var _baseImagePath:String = "";
        private var _externalConfigPath:String = "";
        private var applicationRoot:DisplayObjectContainer = null;
        private var applicationStartTime:Date;
        private var _config:XML = null;
        private var externalConfig:XML;
        private var _baseContentPath:String = "";
        private var _nickName:String = "";
        private var _maps:Dictionary;
        private var _baseSwfPath:String = "";
        private static var _instance:ApplicationConfig;

        public function ApplicationConfig()
        {
            externalConfig = new XML();
            applicationStartTime = new Date();
            _feeds = new Dictionary();
            _maps = new Dictionary();
            _assets = new Dictionary();
            _projectSettings = new Dictionary();
            return;
        }// end function

        public function get clientPlayerSupported() : Boolean
        {
            return _clientPlayerSupported;
        }// end function

        public function getFlashVar(name:String, required:Boolean = true) : String
        {
            var _confVar:* = flashVars[name];
            if (required)
            {
            }
            if (_confVar == null)
            {
                throw new Error("Missing required Flashvar: " + name);
            }
            return _confVar;
        }// end function

        public function get externalSettings() : XML
        {
            return externalConfig;
        }// end function

        public function get upTime() : uint
        {
            return new Date().time - applicationStartTime.time;
        }// end function

        public function initialize(context:DisplayObjectContainer) : void
        {
            if (applicationRoot)
            {
                throw new Error("Application cannot be initialized more than once.");
            }
            applicationRoot = context; //？
            return;
        }// end function

		//介些xml的值给对象赋值 之前是都没有给到值
        public function applySecuritySettings(securitySettings:XMLList) : void
        {
            var _loc_2:XML = null;
            var _loc_3:XML = null;
            if (securitySettings)
            {
				//一行xml纪录 循环遍历
                for each (_loc_2 in securitySettings.crossDomainPolicies.children())
                {
                    
                    if (_loc_2.@value != "") //取值 一行纪录的值 单个标签内部的属性
                    {
                        Security.loadPolicyFile(_loc_2.@value);
                    }
                }
                for each (_loc_3 in securitySettings.allowedDomains.children())
                {
                    
                    if (_loc_3.@value != "")
                    {
                        Security.allowDomain(_loc_3.@value);
                    }
                }
            }
            return;
        }// end function

        public function get assets() : Dictionary
        {
            return _assets;
        }// end function

        public function get maps() : Dictionary
        {
            return _maps;
        }// end function

		//设置文件的完整路径信息！ 如果没有设置好后边可能会有问题
        private function populateExternalSettings() : void
        {
            var _loc_1:* = buildFeedsDictionary("name", "url", "backupUrl", externalSettings.feeds.feed);
            var _loc_2:* = buildFeedsDictionary("name", "dataUrl", "imageUrl", externalSettings.maps.map);
            var _loc_3:* = buildDictionary("name", "url", externalSettings.assets.asset);
            var _loc_4:* = buildDictionary("key", "value", externalSettings.projectSettings.item);
            setDictionaries(_loc_1, _loc_2, _loc_3, _loc_4);
            return;
        }// end function

        public function get baseSiteDomain() : String
        {
            return _baseSiteDomain;
        }// end function

        public function get userID() : String
        {
            return _userID;
        }// end function

		//构造的具体实现
        private function buildDictionary(key:String, value:String, list:XMLList) : Dictionary
        {
            var _loc_4:* = new Dictionary();
            var _loc_5:int = 0;
            var _loc_6:* = list.length();
            while (_loc_5 < _loc_6)
            {
                
                _loc_4[String(list[_loc_5].@[key])] = String(list[_loc_5].@[value]);
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

        public function get baseContentPath() : String
        {
            return _baseContentPath;
        }// end function

        public function get nickName() : String
        {
            return _nickName;
        }// end function

        public function get externalConfigPath() : String
        {
            if (_config)
            {
                return getFlashVarPathFromConfig(XML(_config.appSettings.externalConfigPath));
            }
            return null;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            return applicationRoot.loaderInfo.applicationDomain;
        }// end function

        public function get currentDomain() : SecurityDomain
        {
            return SecurityDomain.currentDomain;
        }// end function

        private function setDictionaries(feeds:Dictionary, maps:Dictionary, assets:Dictionary, projectSettings:Dictionary) : void
        {
            _feeds = feeds;
            _maps = maps;
            _assets = assets;
            _projectSettings = projectSettings;
            return;
        }// end function

        public function get flashVars() : Object
        {
            return applicationRoot.loaderInfo.parameters;
        }// end function

        private function buildFeedsDictionary(key:String, url:String, imageUrl:String, list:XMLList) : Dictionary
        {
            var _loc_5:* = new Dictionary(); //保存一个关联对象
            var _loc_6:int = 0;
            var _loc_7:* = list.length();
            while (_loc_6 < _loc_7)
            {
				var tKey:String = list[_loc_6].@[key];
				var tUrl:String = list[_loc_6].@[url];
				var tImageUrl:String = list[_loc_6].@[imageUrl];
				
                _loc_5[tKey] = new FeedItem(tUrl, tImageUrl);
                _loc_6 = _loc_6 + 1;
            }
            return _loc_5;
        }// end function

        public function get headImg() : String
        {
            return _headImg;
        }// end function

        public function config(configuration:XML) : void
        {
            var securitySettings:XMLList;
            var configuration:* = configuration;
            _config = configuration;
            if (_config)
            {
            }
            if (_config.appSettings.hasComplexContent())
            {
                try
                {
                    externalConfig = XML(_config.externalSettings[0]);
                    if (_config.appSettings.logging.hasComplexContent())
                    {
                        _config.appSettings.logging.hasComplexContent();
                        var _loc_4:int = 0;
                        var _loc_5:* = _config.appSettings.logging.filter; //loging 
                        var _loc_3:* = new XMLList();  //存储变量
						var _loc_6:String; //tony add
                        for each (_loc_6 in _loc_5)
                        {
                            with (_loc_5[_loc_4])
                            {
                                if (@classname == "*")
                                {
                                    _loc_3 = _loc_5[_loc_4];
                                }
                            }
                        }
                    }
					if( _config.appSettings.logging.hasComplexContent() && _loc_3.@level != "")
                    {
                        LogSettings.instance.configure(XML(_config.appSettings.logging[0]));
                    }
                    else
                    {
                        throw new ApplicationError("The global wildcard (*) log filter " + "must be defined in logging node.", ApplicationError.MISSING_LOGGING_FILTERS);
                    }
                    _language = String(_config.appSettings.language);
                    _userID = getFlashVarPathFromConfig(XML(_config.appSettings.userID));
                    _nickName = getFlashVarPathFromConfig(XML(_config.appSettings.nickName));
                   // _headImg = getFlashVarPathFromConfig(XML(_config.appSettings.headImg));
                    _baseSiteDomain = getFlashVarPathFromConfig(XML(_config.appSettings.baseSiteDomain));
                    _baseSwfPath = getFlashVarPathFromConfig(XML(_config.appSettings.baseSwfPath));
                    _baseContentPath = getFlashVarPathFromConfig(XML(_config.appSettings.baseContentPath));
                    _baseImagePath = getFlashVarPathFromConfig(XML(_config.appSettings.baseImagePath));
                    securitySettings = _config.appSettings.security;
                    applySecuritySettings(securitySettings);
                    populateExternalSettings();
                }
                catch (e:Error)
                {
                    throw new Error("Application has encountered " + "a malformed Configuration setting. Aborting " + "Application initialization. " + e);
                }
            }
            else
            {
                throw new Error("Application Configuration is " + "invalid. Aborting Application initialization.");
            }
            return;
        }// end function

        public function get playerType() : String
        {
            return Capabilities.playerType;
        }// end function

        public function set userID(value:String) : void
        {
            _userID = value;
            return;
        }// end function

        public function get baseSwfPath() : String
        {
            return _baseSwfPath;
        }// end function

        public function get baseImagePath() : String
        {
            return _baseImagePath;
        }// end function

        public function get fullscreenAvailable() : Boolean
        {
            return hasFullScreen;
        }// end function

        public function get language() : String
        {
            return _language;
        }// end function

        public function get feeds() : Dictionary
        {
            return _feeds;
        }// end function

        public function get projectSettings() : Dictionary
        {
            return _projectSettings;
        }// end function

        public function get url() : String
        {
            return applicationRoot.loaderInfo.url;
        }// end function

        public function get nominalFrameRate() : uint
        {
            return applicationRoot.loaderInfo.frameRate;
        }// end function

        public function get frameRate() : uint
        {
            return applicationRoot.stage.frameRate;
        }// end function

        private function getFlashVarPathFromConfig(node:XML) : String
        {
            var _loc_2:String = "";
            if (node.@flashVar != "")
            {
                _loc_2 = flashVars[node.@flashVar];
                if (_loc_2 == null)
                {
                    _loc_2 = node.@defaultValue;
                    if (_loc_2 == null)
                    {
                        throw new Error("Error " + ": Missing required Flashvar: " + node.@flashVar);
                    }
                }
            }
            else
            {
                _loc_2 = node.@defaultValue;
            }
            return _loc_2;
        }// end function

        public static function get instance() : ApplicationConfig
        {
			//modify tony
			if( _instance  is ApplicationConfig )
		    {
				return _instance;
						
		   }else{
			   var _loc_1:* = new ApplicationConfig;
			   _instance = _loc_1;
			   return _instance;
		   }
        }// end function

    }
}
