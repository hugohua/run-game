package
{
	
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	
	
	[SWF(width="990", height="600", frameRate="30",backgroundColor="0x00000000")]
	public class run extends Sprite
	{
		private var loader:XMLLoader;
		private var _loaderMax:LoaderMax;
		private var swf:Object ;
		
		public function run()
		{
			if(!stage)
				addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			else 
				addedToStageHandler(); 
		}
		
		protected function addedToStageHandler(e:Event = null):void{
			//移除事件
			if(hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			Security.allowDomain('*');
			loadSrc();
		}
		
		/**
		 * 加载资源
		 */
		private function loadSrc():void{
			
			LoaderMax.activate([SWFLoader,ImageLoader]);	//引入swfloader类 
			loader = new XMLLoader('data.xml',{name:"xmlDoc", onComplete:completeHandler,onError:errorHandler,onProgress:progressHandler});
			loader.load();
				
		}

        private function completeHandler(event:LoaderEvent):void{
            trace('done'); 
			//加载开始
			swf = LoaderMax.getContent("startSWF").rawContent;		//取得真实内容
			addChild(swf as DisplayObject);
//			swf.mcMan.visible = false;
//			swf.pubFunc();
        }
		
		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		
		//start
		private function addEvent(){
//			swf.mcMan
		}
		
	}
}