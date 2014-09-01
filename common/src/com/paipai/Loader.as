package com.paipai
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.paipai.GameModel;
	import com.paipai.SceneBackground1;
	import com.paipai.Score;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
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
		public function getPartBackground():DisplayObject{
			return LoaderMax.getContent(type + "Part1SWF").rawContent;
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
			mc = new SceneBackground1();
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
				mc.gotoAndStop("sbig");
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
		 * 获取弹窗
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
				mc.gotoAndStop("sbig");
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
				mc
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
				
			}
//			trace(GameModel.getInstance().gameSocre.topsSelect,name,scene)
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
				mc
			}
			return mc;
		}
		
		/**
		 * 设置上衣 
		 */
		public function setPeopleProps():void{
			var data:Object = GameModel.getInstance().gameSocre;
			trace(data.shoeSelect,'data.topsSelect')
			var people:MovieClip = GameModel.getInstance().hit;
			if(data.topsSelect){
				people['a' + data.topsSelect].visible = true;
			}
			if(data.shoeSelect){
				people['a' + data.shoeSelect].visible = true;
			}
			
		} 
		
		
		
		
	}
}