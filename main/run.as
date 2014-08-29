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
	import com.greensock.plugins.TweenPlugin;
	import com.paipai.Barrier;
	import com.paipai.Data;
	import com.paipai.FrameTimer;
	import com.paipai.GameEvent;
	import com.paipai.GameModel;
	import com.paipai.HitTest;
	import com.paipai.IFrame;
	import com.paipai.Loader;
	import com.paipai.Score;
	import com.paipai.Shoe;
	import com.paipai.Utils;
	
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
		private var xmlloader:XMLLoader;
		private var _loaderMax:LoaderMax;
		
		private var swf:Object;									//通用swf对象
		
//		private var swfPeople:SWFLoader;							//人物swf
		private var swfRoadBg:SWFLoader;							//道路Background
		private var swfBg:DisplayObject;							//背景swf
		private var enterFRAME:Dictionary;
		private var people:MovieClip;								//用户
		private var popStart:MovieClip;							//弹出选择框
		
		private var roadBg:MovieClip;								//用户
		private var tempArr:Array;									//
		private var TempClass:Class;								//临时对象
		private var barrierArr:Array;								//大便数组
		private var propsArr:Array;								//道具数组
		private var barrier:Barrier;								//大便
		private var props:MovieClip;								//道具等
		private var scoreMc:MovieClip;									//成绩
		private var type:String
		private var loader:Loader;
		
		private static const SPEED:Number = Data.SPEED;
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
			xmlloader = new XMLLoader('data.xml',{name:"xmlDoc", onComplete:completeHandler,onError:errorHandler,onProgress:progressHandler});
			xmlloader.load();
				
		}

        private function completeHandler(event:LoaderEvent):void{
			xmlloader = null;
            trace('done'); 
			//加载开始
			swf = LoaderMax.getContent("startSWF").rawContent;		//取得真实内容
			addChild(swf as DisplayObject);
			//监听事件
			stage.addEventListener(GameEvent.GameStart, GameStartEvt);
        }
		
		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		
		/**
		 * 选择男女，开始游戏
		 */
		private function GameStartEvt(e:GameEvent):void{
			trace('done');
			stage.removeEventListener(GameEvent.GameStart, GameStartEvt);
			swf.dispose();
			removeChild(swf as DisplayObject);
			swf = null;
			type = GameModel.getInstance().type;
			//取得xml文件中名字为"queueGirl/Boy"的LoaderMax开始加载
			var queue2:LoaderMax = LoaderMax.getLoader(type + "queue"); 
			queue2.addEventListener(LoaderEvent.COMPLETE, queue2CompleteHandler); 
			queue2.load(); 
			
		}
		
		private function queue2CompleteHandler(event:LoaderEvent):void {
			//开始time
			FrameTimer.init();
			FrameTimer.add(this);
			enterFRAME = new Dictionary(true);
			trace("queue2 loaded!"); 
			loader = new Loader();
			swfBg = loader.getPartBackground()
			//加载场景2
			swfBg.y = -610;
			addChild(swfBg);
//			//背景动画  
			TweenMax.to(swfBg, 1, {y:0, ease:Linear.easeNone,onComplete:function(){
				people = loader.getPeopleRun()
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
			//该停止了
			if(swfBg.x < BGMOVEX){
				removeEnterFrame("bgMove");
				//换人 先获取当前人物的位置信息
				var x:Number = people.x;
				var y:Number = people.y;
				removeChild(people);
				people = loader.getPeopleSanding();
				people.x = x;
				people.y = y;
				addChild(people);
				
				//1秒后弹窗
				popStart = loader.getPopStart();
				popStart.x = 250;
				popStart.y = 140;
				popStart.scaleX = 0.5;
				popStart.scaleY = 0.5;
				//加载场景元素
				addChild(popStart);
				TweenMax.to(popStart, 1, {transformAroundCenter:{scaleX:1, scaleY:1}, ease:Bounce.easeOut,onComplete:function(){
					//添加选中事件
					for(var i = 0,len = tempArr.length;i<len;i++){
						popStart[tempArr[i]].addEventListener(MouseEvent.CLICK, clickEvent);
					}
					//背景移动事件
					popStart.go.addEventListener(MouseEvent.CLICK, goEvent);
				}});
			}
		}
		
		
		private function clickEvent(e:MouseEvent):void{
			Utils.buttonToggle(e.target as SimpleButton);
			GameModel.getInstance().setTops(e.target.name);
		}
		
		private function goEvent(e:MouseEvent):void{
			//无选中状态
			if(!type){ return ; }
			//移除事件 及 释放内存  
			for(var i = 0,len = tempArr.length;i<len;i++){
				popStart[tempArr[i]].removeEventListener(MouseEvent.CLICK, clickEvent);
			}
			popStart.go.removeEventListener(MouseEvent.CLICK, goEvent);
			removeChild(popStart);
			popStart = null;
			removeChild(people);
			people = null;
			//加载场景2 跑步场景
			roadBg = loader.getSceneBackground();
			addChild(roadBg);
			//加载站立裸体人
			people = loader.getPeopleSanding();
			people.x = 118;
			people.y = 510;
			addChild(people);
			//加载游戏提示
			popStart = loader.getSceenGameTips();
			addChild(popStart);
			//添加开始事件
			popStart.btnGamePlay.addEventListener(MouseEvent.CLICK, GamePlayEvt);
		}
		
		/**
		 * 开始游戏
		 */
		private function GamePlayEvt(e:MouseEvent):void{
			removeChild(popStart);
			popStart = null;
			removeChild(people);
			//加载跑步状态的人
			people = loader.getPeopleRun();
			people.x = 118;
			people.y = 510;
			addChild(people);
			//加载记分牌 
			scoreMc = loader.getScore();
			addChild(scoreMc);
			
			barrierArr = [];
			propsArr = [];
			//生成障碍物
			createProps();
			//2秒后移除楼梯背景及站立的人 
			TweenMax.delayedCall(2,function(){
				removeChild(swfBg);
				swfBg = null;
			})
			roadBg.move();
			//监听事件
			stage.addEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);
//			addEnterFrame('bgRoadMove',bgRoadMove);
			addEnterFrame('hitTestBarrier',hitTestBarrier);
			addEnterFrame('hitTestProps',hitTestProps)
		}
		
		
		/**
		 * 设置道具
		 */
		private function createProps():void{
			var babaXArr:Array = Utils.createRandom(11,800,1500);				//大便数组
			var babaXLen:int = babaXArr.length;
			
			var propXArr:Array = Utils.createRandom(11,100,400);		//道具数组
			var propXLen:int = propXArr.length;							//道具数组长度
			
			var barrLen:int = barrierArr.length;					//存放大便对象的数组
			var propsLen:int = propsArr.length;						//存放道具对象的数组
			//先清除之前的道具
			if(barrLen){
				for(var i = 0; i < barrLen; i++ ){
					barrier = barrierArr[i];
					barrier.dispose();
					barrier = null;
				}
				barrierArr = [];
			}
			
			if(propsLen){
				for(var k = 0;k < propsLen; k++){
					props = propsArr[k];
					props.dispose();
					props = null;
				}
				propsArr = [];
			}
			
			//生成大便  
			for (var m=0; m< babaXLen; m++){
				barrier = new Barrier(babaXArr[m]);
				addChild(barrier);
				barrierArr.push(barrier);
			}
			//生成道具
			for (var j=0; j< propXLen; j++){
				props = new Shoe(propXArr[j]);
				addChild(props);
				propsArr.push(props);
			}
		}
		
		/**
		 * 背景移动
		 */
//		private function bgRoadMove():void{
//			roadBg.x -= SPEED;
//			//不停的循环
//			if(roadBg.x <= -3032){
//				var _class:Class =swfRoadBg.getClass("BgP1");
//				removeChild(roadBg);
//				roadBg = null;
//				roadBg = new _class();
//				roadBg.x = -996;
//				//加载场景元素 
//				addChildAt(roadBg,0);
//				//创建道具
//				createProps();
//			}
//		}
		
		/**
		 * 碰撞检测大便 
		 */
		private function hitTestBarrier():void{
			var len:int = barrierArr.length;
			var barrier:Barrier;
			if(!len) return;
			
			for(var i:int = 0; i < len;i++){
				barrier = barrierArr[i];
				if(HitTest.complexHitTestObject(barrier,people)){
					people.tou.visible = true;//(2);
					people.tou2.visible = false;//(2);
					var scoreNum:int = scoreMc.addScore();
//					trace(scoreNum);
					if(scoreNum == 0){
//						trace("你输了")
					}
				}
			}
		}
		
		/**
		 * 碰撞检测道具
		 */
		private function hitTestProps():void{
			var len:int = propsArr.length;
			var shoe:Shoe;
			if(!len) return;
			
			for(var i:int = 0; i < len;i++){
				shoe = propsArr[i];
				if(HitTest.complexHitTestObject(shoe,people)){
					people.tou.visible = false;//(2); 
					people.tou2.visible = true;
					var scoreNum:int = scoreMc.addScore();
//					trace(scoreNum);
					if(scoreNum){
//						trace("你赢了")
					}
				}
			}
		}
		
		/**
		 * 大便及道具停止
		 */
		private function GameSceneOverEvt(e:GameEvent):void{
			trace("yes====")
		}
		
		
		
	}
}