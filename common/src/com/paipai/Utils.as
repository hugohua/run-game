package com.paipai
{
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;

	public class Utils
	{
		private static var radioButton:SimpleButton;
		/**
		 * 随机生成坐标点
		 * num 生成的个数
		 */
		public static function createRandom(num:Number = 28):Array{
			var x:int = 100 ;  			// 当前在数轴上的点坐标
			var i:int;
			var rndX:Array = [];  // 保存在数轴上的生成的随机点的坐标
			var avg:Number = (Math.abs(Data.DISTANCE) - 800) / num;			//平均距离
			var minL:Number = avg - 50;
			var maxL:Number = avg + 50;
			
			//生成个数
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