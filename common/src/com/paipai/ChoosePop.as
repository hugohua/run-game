package com.paipai
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import com.paipai.Loader;
	
	/**
	 * 选择浮层 
	 */
	public class ChoosePop extends MovieClip
	{
		private var arr:Array;
		private var TempClass:Class;
		private var btnArr:Array = [];
		//弹窗位置
		private var popPostionBig:Array = [
			{x:328,y:43},
			{x:566,y:43},
			{x:328,y:229},
			{x:566,y:229}
		];
		
		//type 类型 ：上衣 1 ， 帽子 2 ，裤子 3 ，鞋子 4
		public function ChoosePop(type:int = 1)
		{
			//TODO: implement function
			super();
			if(type == 1){
				arr = GameModel.getInstance().getTops();
			}
			
//			for(var i:int = 0,len:int = arr.length;i<len;i++){
//				TempClass = loader.getTopsBtn(arr[i]);
//				var _topsMc:SimpleButton = new TempClass();
//				_topsMc.x = popPostionBig[i].x;
//				_topsMc.y = popPostionBig[i].y;
//				_topsMc.addEventListener(MouseEvent.CLICK, clickEvent);
//				_topsMc.name = "topsBtn"+tops[i];
//				btnArr.push(_topsMc);
//				mc.addChild(_topsMc);
//			}
			
		}
		
		public function dispose():void{
			
		}
//		
//		var tops:Array = GameModel.getInstance().getTops();
//		TempClass =  swfPeople.getClass("ChoosePop");
//		mc = new TempClass();
//		popMc = mc;
//		for(var i:int = 0,len:int = tops.length;i<len;i++){
//			TempClass = swfPeople.getClass('btn' + tops[i]);
//			var _topsMc:SimpleButton = new TempClass();
//			_topsMc.x = popPostionBig[i].x;
//			_topsMc.y = popPostionBig[i].y;
//			_topsMc.addEventListener(MouseEvent.CLICK, clickEvent);
//			_topsMc.name = "topsBtn"+tops[i];
//			btnArr.push(_topsMc);
//			mc.addChild(_topsMc);
//		}
//		mc.btnGo.addEventListener(MouseEvent.CLICK, nextPartEvt);
	}
}