package com.paipai
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		//开始游戏事件
		public static const GameStart:String = "GameStart";
		public static const GameOver:String = "GameOver";
		
		public var data: Object;
		
		public function GameEvent(type:String, data: Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}

