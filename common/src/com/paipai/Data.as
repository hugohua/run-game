package com.paipai
{
	public class Data
	{
		public function Data()
		{
			
		}
		
		//速度
		public static const SPEED:int = 60;//15;
		
//		public static const LOOP:int = 5;						//场景循环次数
		
		public static const PEOPLESPEED:Number = 1.2;				//第一个场景 人跑步的速度
		
		//第一个场景 背景移动的速度
		public static const BGSPEEDX:Number = 5;				
		public static const BGSPEEDY:Number = 2.7;
		
		public static const BGMOVEX:Number = -960;				//首屏背景移动的最终距离  
		
		public static const DISTANCE:Number = -15000;			//最终距离
		
		public static const JUMPTIME:Number = 0.5;				//跳起来的时间
		
		//跑步的人 默认位置
		public static const PEOPLEPOS:Object = {
			x:118,
			y:510
		};
		
		public static const JUMPY:Number = 400;
		
		public static const MAXSCENE:int = 4;//4;		//最大关卡数
		
	}
}