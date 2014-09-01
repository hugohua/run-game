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
	import com.paipai.PropsPop;
	import com.paipai.PropsUtils;
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
		
		private var swf:Object;										//通用swf对象  
		
		private var swfRoadBg:SWFLoader;							//道路Background
		private var swfBg:DisplayObject;							//背景swf
		private var enterFRAME:Dictionary;
		private var people:MovieClip;								//用户
		private var popStart:MovieClip;								//弹出选择框
		private var propsPop:MovieClip;								//物品穿戴选择
		private var popChoose:MovieClip;
		private var maskMc:MovieClip;
		
		private var roadBg:MovieClip;								//用户
		private var tempArr:Array;									//
		private var TempClass:Class;								//临时对象
		private var barrierArr:Array;								//大便数组
		private var propsArr:Array;									//道具数组
		private var barrier:Barrier;								//大便
		private var props:MovieClip;								//道具等
		private var scoreMc:MovieClip;								//成绩
		private var type:String
		private var loader:Loader;
		private var firstPlay:Boolean;								//判定是否是第一次游戏
		
		private static const SPEED:Number = Data.SPEED;
		private static const BGMOVEX:Number = Data.BGMOVEX;				//首屏背景移动的最终距离  
		
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
			
			reset();
			
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
		
		
		private function addMask():void{
			maskMc = new Mask();
			addChild(maskMc);
		}
		
		private function remvoeMask():void{
			removeChild(maskMc);
			maskMc = null;
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
				people = loader.getPeople()
				people.gotoAndStop('run');
				people.x = Data.PEOPLEPOS.x;
				people.y = Data.PEOPLEPOS.y;
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
			swfBg.y += Data.BGSPEEDY;
			people.x += Data.PEOPLESPEED;
			//该停止了
			if(swfBg.x < BGMOVEX){
				removeEnterFrame("bgMove");
				//换人 先获取当前人物的位置信息 
				people.gotoAndStop('sanding');
				//监听浮层选择事件
				GameEvent.stage.addEventListener(GameEvent.GamePropsPopClose, propsPopCloseEvt);
				addMask();
				//1秒后弹窗
//				popStart = loader.getPopStart();
//				popStart.x = 250;
//				popStart.y = 140;
//				popStart.scaleX = 0.5;
//				popStart.scaleY = 0.5;
				propsPop  = loader.getPropsPop();
				propsPop.y = -600;
				//加载场景元素  
				addChild(propsPop);
				TweenMax.to(propsPop, 1, {y:0, ease:Bounce.easeOut});
			}
		}
		
		/**
		 * 浮层关闭事件
		 */
		private function propsPopCloseEvt(e:GameEvent):void{
			//先移除之前的道路
			if(roadBg){
				removeChild(roadBg);
				roadBg = null;
			}
			//加载下一个场景的道路
			roadBg = loader.getSceneBackground();
			addChild(roadBg);
//			addChildAt(roadBg,0);
			//加载站立裸体人
			people.gotoAndStop('sanding');
			people.x = Data.PEOPLEPOS.x;
			people.y = Data.PEOPLEPOS.y;
			//加载游戏提示
			if(firstPlay){
				popStart = loader.getSceenGameTips();
				popStart.x = 400;
				popStart.y = 300;
				addChild(popStart);
				//添加开始事件
				popStart.btnGamePlay.addEventListener(MouseEvent.CLICK, GamePlayEvt);
			}else{
				GamePlayEvt();
			}
			
		}
		
		/**
		 * 开始游戏
		 */
		private function GamePlayEvt(e:MouseEvent = null):void{
			if(firstPlay){
				popStart.btnGamePlay.removeEventListener(MouseEvent.CLICK, GamePlayEvt);
				removeChild(popStart);
				popStart = null;
				//取消第一次游戏提示 
				firstPlay = false;
			}
			
			//加载跑步的人  
			people.gotoAndStop('run');
//			people.mcRun.visible = false;
//			people.test123.visible = true;
			loader.setPeopleProps();
			//设置最顶层
			setChildIndex(people,numChildren-1);
			//加载记分牌  
			if(!scoreMc){
				scoreMc = loader.getScore();
				scoreMc.x = 800;
				scoreMc.y = 100;
				addChild(scoreMc);
			}
			//生成障碍物   
			createProps();
			//2秒后移除楼梯背景及站立的人 
			if(swfBg){
				TweenMax.delayedCall(2,function(){
					removeChild(swfBg);
					swfBg = null;
				})
			}
			
			roadBg.move();
			//监听事件
			GameEvent.stage.addEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);	
			GameEvent.stage.addEventListener(GameEvent.GameHitBarrier,GameHitBarrierEvt);
			GameEvent.stage.addEventListener(GameEvent.GameHitProps,GameHitPropsEvt);
			GameEvent.stage.addEventListener(GameEvent.GamePartOver,GamePartOverEvt);
			GameEvent.stage.addEventListener(GameEvent.GameWin,GameWinEvt);
		}
		
		/**
		 * 生成障碍物
		 */
		private function createBarrs():void{
			var babaXArr:Array = Utils.createRandom(11,800,1500);				//大便数组
			var babaXLen:int = babaXArr.length;
			var barrLen:int = barrierArr.length;					//存放大便对象的数组
			//先清除之前的道具
			if(barrLen){
				for(var i = 0; i < barrLen; i++ ){
					barrier = barrierArr[i];
					barrier.dispose();
					barrier = null;
				}
				barrierArr = [];
			}
			//生成大便  
			for (var m=0; m< babaXLen; m++){
				barrier = new Barrier(babaXArr[m]);
				addChild(barrier);
				barrierArr.push(barrier);
			}
		}
		
		
		/**
		 * 生成道具   
		 */
		private function createProps():void{
			
			var propXArr:Array = Utils.createRandom(11,100,400);		//道具数组
			var propXLen:int = propXArr.length;							//道具数组长度
			var propsLen:int = propsArr.length;							//存放道具对象的数组 
			if(propsLen){
				for(var k = 0;k < propsLen; k++){
					props = propsArr[k];
					props.dispose();
					props = null;
				}
				propsArr = [];
			}
			
			//生成道具  
			for (var j=0; j< propXLen; j++){
				props = PropsUtils.createProps(propXArr[j]);
				addChild(props);
				propsArr.push(props);
			}
		}
		
		/**
		 * 碰撞检测大便 
		 */
		private function GameHitBarrierEvt(e:GameEvent):void{
			people.mcRun.tou.visible = true;
			people.mcRun.tou2.visible = false;
			scoreMc.addScore();  
		}
		
		/**
		 * 碰撞检测道具 
		 */
		private function GameHitPropsEvt(e:GameEvent):void{
			people.mcRun.tou.visible = false;
			people.mcRun.tou2.visible = true;
			scoreMc.addScore();
		}
		
		/**
		 * 最后的一段跑步  
		 */
		private function peopleRunEnd():void{
			people.x += SPEED;
			//最终停止跑步
			if(people.x >= 800){
				GameEvent.partOver();
			}
		}
		
		/**
		 * 大便及道具停止  
		 */
		private function GameSceneOverEvt(e:GameEvent):void{
			addEnterFrame('peopleRunEnd',peopleRunEnd)
		}
		
		/**
		 * 关卡结束   停止移动 换成站立的人 
		 */
		private function GamePartOverEvt(e:GameEvent):void{
			removeEnterFrame('peopleRunEnd');
			people.gotoAndStop('sanding'); 
			//弹出界面选择 
			popChoose = loader.getPopChoose();
			addChild(popChoose); 
			//添加事件
			popChoose.btnGo.addEventListener(MouseEvent.CLICK, nextPartEvt);
			//关卡数 加1
			GameModel.getInstance().scene = 1; 
		}
		
		/**
		 * 下一个关卡  
		 */
		private function nextPartEvt(e:MouseEvent):void{
			popChoose.btnGo.removeEventListener(MouseEvent.CLICK, nextPartEvt);
			loader.removePropsEvent();
			removeChild(popChoose);
			popChoose = null;
			
			
			if(GameModel.getInstance().scene < Data.MAXSCENE ){
				//加载下一个关卡的物品选择  
				propsPop  = loader.getPropsPop();
				//加载场景元素   
				addChild(propsPop);
			}else{
				GameEvent.win();
			}
			
		}
		
		/**
		 * reset
		 */
		private function reset():void{
			//初始化
			firstPlay = true;
			//初始化道具数组
			barrierArr = [];
			propsArr = [];
		}
		
		/** 
		 * 游戏结束  弹出拍照浮层
		 */
		private function GameWinEvt(e:GameEvent):void{
			trace("end");
		}
		
		
		
	}
}