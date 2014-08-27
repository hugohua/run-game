package
{
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Linear;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.plugins.TransformAroundCenterPlugin;
//	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.paipai.FrameTimer;
	import com.paipai.GameEvent;
	import com.paipai.IFrame;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.system.Security;
	import flash.utils.Dictionary;
	
	[SWF(width="990", height="600", frameRate="30",backgroundColor="0x00000000")]
	public class run extends Sprite implements IFrame
	{
		private var loader:XMLLoader;
		private var _loaderMax:LoaderMax;
		
		private var swf:Object;					//通用swf对象
		
		private var swfPeople:SWFLoader;			//人物swf
		private var swfRoadBg:SWFLoader;			//道路Background
		private var swfBg:DisplayObject;			//背景swf
		private var enterFRAME:Dictionary;
		private var people:MovieClip;				//用户
		private var popStart:MovieClip;			//弹出选择框
		private var toggledButton:SimpleButton;	//切换
		private var selectNum:String;				//选中的人物
		private var roadBg:MovieClip;				//用户
		private var tempArr:Array;					//
		private var _class:Class;					//临时对象
		private static const SPEED:Number = 30;
		private static const BGMOVEX:Number = -665;				//首屏背景移动的最终距离
		
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
			TweenPlugin.activate([TransformAroundCenterPlugin]);
			init();
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
		 * 加载资源
		 */
		private function init():void{
			//初始化
			tempArr =['p1','p2','p3','p4'];
			
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
			stage.removeEventListener(GameEvent.GameStart, GameStart);
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
			TweenMax.to(swfBg, 1, {alpha:1, y:0, ease:Linear.easeNone,onComplete:function(){
				swfPeople = LoaderMax.getLoader("boySWF");				//取得swf
				_class = swfPeople.getClass("People");
				people = new _class();
				people.x = 118;
				people.y = 510;
				//加载场景元素
				addChild(people);
				//背景移动
				addEnterFrame('bgMove',bgMove);
			}});
		}
		
		/**
		 * 背景移动
		 */
		private function bgMove():void{
			swfBg.x -= SPEED;
			swfBg.y += 2.7;
			people.x +=1.2;
			trace(swfBg.x,BGMOVEX)
			//该停止了
			if(swfBg.x < BGMOVEX){
				removeEnterFrame("bgMove");
				//换人
				var x:Number = people.x;
				var y:Number = people.y;
				removeChild(people);
				_class =swfPeople.getClass("PeopleSanding");
				people = new _class();
				people.x = x;
				people.y = y;
				//换成站立的人
				addChild(people);
				
				//1秒后弹窗
				_class =swfPeople.getClass("PopStart");
				popStart = new _class();
				popStart.x = 250;
				popStart.y = 140;
				popStart.scaleX = 0.5;
				popStart.scaleY = 0.5;
				//加载场景元素
				addChild(popStart);
				TweenMax.to(popStart, 1, {transformAroundCenter:{scaleX:1, scaleY:1}, ease:Bounce.easeOut,onComplete:function(){
					trace("popStart onComplete");
					//添加选中事件
					for(var i = 0,len = tempArr.length;i<len;i++){
						popStart[tempArr[i]].addEventListener(MouseEvent.CLICK, clickEvent);
					}
					//背景移动
					popStart.go.addEventListener(MouseEvent.CLICK, goEvent);
				}});
//				showChoosePop();
			}
		}
		
		/**
		 * 显示选择pop
		 */
		private function showChoosePop():void{
			
		}
		
		
		private function buttonToggle(button:SimpleButton):void{
			var currDown:DisplayObject = button.downState;
			button.downState = button.upState;
			button.upState = currDown;
		}
		
		private function clickEvent(e:MouseEvent):void{
			if (toggledButton != e.target) {
				buttonToggle(e.target as SimpleButton);
				if (toggledButton)
					buttonToggle(toggledButton);
				toggledButton = (e.target as SimpleButton);
			}
			selectNum = e.target.name;
		}
		
		private function goEvent(e:MouseEvent):void{
			//无选中状态
			if(!selectNum){ return ; }
			//移除事件
			for(var i = 0,len = tempArr.length;i<len;i++){
				popStart[tempArr[i]].removeEventListener(MouseEvent.CLICK, clickEvent);
			}
			popStart.go.removeEventListener(MouseEvent.CLICK, goEvent);
			removeChild(popStart);
			popStart = null;
			
			//加载场景2
			swfRoadBg = LoaderMax.getLoader("bgSWF");
			var _class:Class =swfRoadBg.getClass("BgP1");
			roadBg = new _class();
			//加载场景元素
			addChild(roadBg);
			addEnterFrame('bgRoadMove',bgRoadMove);
			//加载裸体人
			var _class:Class =swfPeople.getClass("PeopleSanding");
			people = new _class();
			people.x = 118;
			people.y = 510;
			
			//换成站立的人
			addChild(people);
			
		}
		
		/**
		 * 背景移动
		 */
		private function bgRoadMove():void{
			roadBg.x -= SPEED;
			//不停的循环
			if(roadBg.x <= -3032){
				var _class:Class =swfRoadBg.getClass("BgP1");
				removeChild(roadBg);
				roadBg = null;
				roadBg = new _class();
				roadBg.x = -996;
				//加载场景元素
				addChildAt(roadBg,0);
				addEnterFrame('bgRoadMove',bgRoadMove);
			}
		}
		
	}
}