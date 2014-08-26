package
{
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.paipai.FrameTimer;
	import com.paipai.GameEvent;
	import com.paipai.IFrame;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.Dictionary;
	
	[SWF(width="990", height="600", frameRate="30",backgroundColor="0x00000000")]
	public class run extends Sprite implements IFrame
	{
		private var loader:XMLLoader;
		private var _loaderMax:LoaderMax;
		
		private var swf:Object;
		
		private var swfPeople:SWFLoader;		//人物swf
		private var swfBg:DisplayObject;			//背景swf
		private var bgMoveEndX:Number;				//背景移动的最终距离
		private var enterFRAME:Dictionary;
		private var people:MovieClip;				//用户
		
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
			//监听事件
			stage.addEventListener(GameEvent.GameStart, GameStart);
        }
		
		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		
		private function GameStart(e:GameEvent):void{
			trace('接收事件')
			swf.dispose();
			removeChild(swf as DisplayObject);
			swf = null;
			//取得xml文件中名字为"queue2"的LoaderMax开始加载
			var queue2:LoaderMax = LoaderMax.getLoader("queue2"); 
			queue2.addEventListener(LoaderEvent.COMPLETE, queue2CompleteHandler); 
			queue2.load(); 
			
		}
		
		private function queue2CompleteHandler(event:LoaderEvent):void {
			//开始time
			FrameTimer.init();
			FrameTimer.add(this);
			enterFRAME = new Dictionary(true);
			trace("queue2 loaded!"); 
			//加载场景2
			swfBg = LoaderMax.getContent("part1SWF").rawContent;
			swfBg.y = -610;
			addChild(swfBg);
			TweenMax.to(swfBg, 1, {alpha:1, y:100, ease:Back.easeOut});
			
			swfPeople = LoaderMax.getLoader("boySWF");				//取得swf
			var _class:Class =swfPeople.getClass("People");
			people = new _class();
			people.x = 118;
			people.y = 510;
			//加载场景元素
			addChild(people);
			
			
			
			//背景移动
			bgMoveEndX = -665;
			addEnterFrame('bgMove',bgMove);
//			addChild(swf as DisplayObject); 
		}
		
		/**
		 * 接口方法
		 */
		public function action():void
		{
			for each(var fun:Function in enterFRAME)
			{
				fun.call();
			}	
		}
		
		/**
		 * 添加字典到循环体内 
		 */
		private function addEnterFrame(key:Object,fun:Function):void{
			if(!enterFRAME.hasOwnProperty(key)){
				enterFRAME[key]=fun;
			}
		}
		
		/**
		 * 从循环体内删除字典 停止监控
		 */
		private function removeEnterFrame(key:Object):void{
			if(enterFRAME.hasOwnProperty(key)){
				delete enterFRAME[key];
			}
		}
		
		/**
		 * 背景移动
		 */
		private function bgMove():void{
			swfBg.x -= 5;
			swfBg.y += 2.7;
			people.x +=1.2;
//			people.y -=0.1;
			trace(swfBg.x,bgMoveEndX)
			//该停止了
			if(swfBg.x < bgMoveEndX){
				removeEnterFrame("bgMove");
				//换人
				var x:Number = people.x;
				var y:Number = people.y;
				removeChild(people);
				var _class:Class =swfPeople.getClass("PeopleSanding");
				people = new _class();
				people.x = x;
				people.y = y;
				//换成站立的人
				addChild(people);
				//
			}
		}
		
		/**
		 * 显示选择pop
		 */
		private function showChoosePop():void{
			
		}
		
	}
}