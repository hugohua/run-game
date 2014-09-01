package com.paipai
{
	import com.paipai.GameModel;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class Utils
	{
		private static var radioButton:SimpleButton;
		/**
		 * 随机生成坐标点
		 */
		public static function createRandom(num:Number = 5, minL:Number = 200, maxL:Number = 500):Array{
			var x:int = 100 ;  			// 当前在数轴上的点坐标
			var i:int;
			var rndX:Array = [];  // 保存在数轴上的生成的随机点的坐标
			//生成大便
			for (i=0; i< num; i++){
				//距离
				var m:Number = (maxL - minL) * Math.random() + minL;
				x += m;
				rndX.push(x);
			}
			return rndX;
		}
		
		/**
		 * 设置按钮的可选状态
		 */
		public static function buttonToggle(button:SimpleButton):void{
			var currDown:DisplayObject = button.downState;
			button.downState = button.upState;
			button.upState = currDown;
		}
		
		/**
		 * 单选按钮
		 */
		public static function radioEffect(target:SimpleButton):void{
//			var target:SimpleButton = e.target as SimpleButton;
			if (radioButton != target) {
				Utils.buttonToggle(target);
				if (radioButton)
					Utils.buttonToggle(radioButton);
				radioButton = (target);
			}
		}
		
		/**
		 * 数组随机取值
		 */
		public static function getRandom(arr:Array):*{
			var m:int = Math.round((arr.length - 1) * Math.random());
			return arr[m];
		}
	}
}