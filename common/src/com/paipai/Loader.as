package com.paipai
{
//	import com.greensock.TweenMax;
//	import com.greensock.easing.Linear;
//	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.paipai.GameModel;
	import com.paipai.SceneBackground1;
	import com.paipai.Score;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
//	import flash.utils.Dictionary;
	
	public class Loader
	{
		private var type:String;
		private var swfPeople:SWFLoader;							//人物swf
		private var swfScene:SWFLoader;							//运动场景
		private var TempClass:Class;
		private var mc:MovieClip;
		private var btn:SimpleButton;
		private var popMc:MovieClip;
		private var btnArr:Array = [];
//		private var toggledButton:SimpleButton;
		//弹窗位置
		private var popPostionBig:Array = [
			{x:429,y:100},
			{x:429,y:292},
			{x:669,y:100},
			{x:669,y:292}
		];
		
		private var popPostionSmall:Array = [
			{x:556,y:92},
			{x:556,y:303}
		];
		
		public function Loader()
		{
			type = GameModel.getInstance().type;
			swfPeople = LoaderMax.getLoader(type + "SWF");				//取得swf
			swfScene = LoaderMax.getLoader(type + "SceneSWF");
			
		}
		
		/**
		 * 加载场景2
		 */
		public function getPartBackground():MovieClip{
			TempClass =  swfScene.getClass("partBackground");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 获取跑步的人
		 */
		public function getPeople():MovieClip{
			TempClass =  swfPeople.getClass("People");
			mc = new TempClass();
			GameModel.getInstance().hit = mc; 
			return mc;
		}
		
		/**
		 * 获取上衣弹出层
		 */
		public function getPopStart():MovieClip{
			TempClass =  swfPeople.getClass("PopStart");
			mc = new TempClass();
			return mc;
		}
		
		
		/**
		 * 加载跑步场景swf
		 */
		public function getSceneBackground():MovieClip{
			var data:Object = GameModel.getInstance().gameSocre;
			var mc:MovieClip;
			switch(data.topsSelect){
				case "mcTopsp2":
					mc = new SceneBackground2();
					break;
				case "mcTopsp3":
					mc = new SceneBackground3();
					break;
				case "mcTopsp4":
					mc = new SceneBackground4();
					break;
				default:
					mc = new SceneBackground1();
					break;
				
			}
			return mc;
		}
		
		/**
		 * 获取游戏提示mc
		 */
		public function getSceenGameTips():MovieClip{
			TempClass = swfScene.getClass("GameTips");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 加载记分牌
		 */
		public function getScore():Score{
			var score:Score =  new Score();
			return score;
		}
		
		/**
		 * 获取上衣选择按钮
		 */
		public function getTopsBtn(name:String):SimpleButton{
			TempClass = swfPeople.getClass('btn' + name);
			btn = new TempClass();
			return btn;
		}
		
		
		/**
		 * 获取上衣弹窗
		 */
		public function getTopsPop():MovieClip{
			var tops:Array = GameModel.getInstance().getTops();
			var pos:Array;
			TempClass =  swfPeople.getClass("ChoosePop");
			mc = new TempClass();
			popMc = mc;
			if(tops.length <=2){
				mc.gotoAndStop("csmall");
				pos = popPostionSmall;
			}else{
				mc.gotoAndStop("cBig");
				pos = popPostionBig;
			}
			for(var i:int = 0,len:int = tops.length;i<len;i++){
				TempClass = swfPeople.getClass('btn' + tops[i]);
				var _topsMc:SimpleButton = new TempClass();
				_topsMc.x = pos[i].x;
				_topsMc.y = pos[i].y;
				_topsMc.addEventListener(MouseEvent.CLICK, clickEvent);
				//穿上的上衣 实例名称
				_topsMc.name = "mcTops"+tops[i];
//				trace(_topsMc.name)
				btnArr.push(_topsMc);
				mc.addChild(_topsMc);
			}
			return mc;
		}
		
		/**
		 * 获取鞋子弹窗
		 */
		public function getShoePop():MovieClip{
			//标签
			var shoe:Array = GameModel.getInstance().getShoe();
			var pos:Array;
			TempClass =  swfPeople.getClass("ChoosePop");
			mc = new TempClass();
			popMc = mc;
			if(shoe.length <=2){
				mc.gotoAndStop("csmall");
				pos = popPostionSmall;
			}else{
				mc.gotoAndStop("cBig");
				pos = popPostionBig;
			}
			for(var i:int = 0,len:int = shoe.length;i<len;i++){
				TempClass = swfPeople.getClass('btns' + shoe[i]);
				var _shoeMc:SimpleButton = new TempClass();
				_shoeMc.x = pos[i].x;
				_shoeMc.y = pos[i].y;
				_shoeMc.addEventListener(MouseEvent.CLICK, clickEvent);
				//穿上的鞋子 实例名称
				_shoeMc.name = "mcShoe"+shoe[i];
				//				trace(_shoeMc.name)
				btnArr.push(_shoeMc);
				mc.addChild(_shoeMc);
			}
			return mc;
		}
		
		/**
		 * 获取鞋子弹窗
		 */
		public function getLiftPop():MovieClip{
			//标签
			var life:Array = GameModel.getInstance().getLife();
			var pos:Array;
			TempClass =  swfPeople.getClass("ChoosePop");
			mc = new TempClass();
			popMc = mc;
			if(life.length <=2){
				mc.gotoAndStop("csmall");
				pos = popPostionSmall;
			}else{
				mc.gotoAndStop("cBig");
				pos = popPostionBig;
			}
			for(var i:int = 0,len:int = life.length;i<len;i++){
				TempClass = swfPeople.getClass('btna' + life[i]);
				var _lifeMc:SimpleButton = new TempClass();
				_lifeMc.x = pos[i].x;
				_lifeMc.y = pos[i].y;
				_lifeMc.addEventListener(MouseEvent.CLICK, clickEvent);
				//穿上的鞋子 实例名称
				_lifeMc.name = "mcLife"+life[i];
				trace(_lifeMc.name)
				btnArr.push(_lifeMc);
				mc.addChild(_lifeMc);
			}
			return mc;
		}
		
		/**
		 * 选择
		 */
		public function getPopChoose():MovieClip{
			var scene:int = GameModel.getInstance().scene;
			var mc:MovieClip;
			if(scene == 1){
				mc = getTopsPop();
			}else if(scene == 2){
				mc = getShoePop();
			}else if(scene == 3){
				mc = getLiftPop();
			}
			return mc;
		}
		
		/**
		 * 设置需要穿上的衣服
		 */
		private function clickEvent(e:MouseEvent):void{
			var name:String = e.target.name;
			Utils.radioEffect(e.target as SimpleButton);
			var scene:int = GameModel.getInstance().scene - 1;
			if(scene == 1){
				GameModel.getInstance().setTopsSelect(name);
			}else if(scene == 2){
				GameModel.getInstance().setShoeSelect(name);
			}else if(scene == 3){
				GameModel.getInstance().setLifeSelect(name);
			}
		}
		
		/**
		 * 移除子元素 事件
		 */
		public function removePropsEvent():void{
			for(var i:int = 0,len:int = btnArr.length;i<len;i++){
				btnArr[i].removeEventListener(MouseEvent.CLICK, clickEvent);
				popMc.removeChild(btnArr[i]);
			}
			popMc = null;
			btnArr = [];
		}
		
		/**
		 * 获取属性弹出层
		 */
		public function getPropsPop():MovieClip{
			var scene:int = GameModel.getInstance().scene;
			var mc:MovieClip;
			if(scene == 1){
				mc = new TopsPop();
			}else if(scene == 2){
				mc = new ShoePop();
			}else if(scene == 3){
				mc = new LifePop();
			}
			return mc;
		}
		
		/**
		 * 设置上衣 
		 */
		public function setPeopleProps():void{
			var data:Object = GameModel.getInstance().gameSocre;
			trace(data.lifeSelect,'data.lifeSelect')
			var people:MovieClip = GameModel.getInstance().hit;
			if(data.topsSelect){
				people['a' + data.topsSelect].visible = true;
			}
			if(data.shoeSelect){
				people['a' + data.shoeSelect].visible = true;
			}
			
		};
		
		/**
		 * 获取碰撞的星星
		 */
		public function getStar(x:Number,y:Number):MovieClip{
			TempClass =  swfScene.getClass("Star");
			mc = new TempClass();
			mc.x = x;
			mc.y = y;
			return mc;
		}
		
		/**
		 * 显示结果浮层
		 */
		public function getResultPop():MovieClip{
			TempClass =  swfScene.getClass("ResultPop");
			mc = new TempClass();
			return mc;
		}
		
		
		
		
	}
}