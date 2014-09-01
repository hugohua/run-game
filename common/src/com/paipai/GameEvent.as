package com.paipai
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 游戏事件派发类  游戏内大部分操作控制 通过事件 进行派发
	 */
	public class GameEvent extends Event
	{
		//开始游戏事件
		public static const GameStart:String = "GameStart";
		public static const GameOver:String = "GameOver";
		public static const GameSceneOver:String = "GameSceneOver";			//场景停止移动
		public static const GamePartOver:String = "GamePartOver";				//关卡结束
		public static const GameHitBarrier:String = "GameHitBarrier";		//碰撞到大便
		public static const GameHitProps:String = "GameHitProps";				//碰撞到 道具
		public static const GameWin:String = "GameWin";						//赢得游戏
		public static const GamePropsPopClose:String = "GamePropsPopClose";	//关闭浮层事件
		
		
		private var data: Object;
		//用一个空sprite 来做事件传递载体
		public static var stage:Sprite = new Sprite();
		
		public function GameEvent(type:String, data: Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		/**
		 * 碰撞到大便
		 */
		public static function hitBarrier(obj:Object):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GameHitBarrier,obj) );
		}
		
		/**
		 * 碰撞到道具
		 */
		public static function hitProps(obj:Object):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GameHitProps,obj) );
		}
		
		/**
		 * 场景结束
		 */
		public static function sceneOver(obj:Object):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GameSceneOver,obj) );
		}
		
		/**
		 * 赢得游戏
		 */
		public static function win(obj:Object = null):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GameWin,obj) );
		}
		
		/**
		 * 关卡结束事件
		 */
		public static function partOver(obj:Object = null):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GamePartOver,obj) );
		}
		
		
		/**
		 * 关闭浮层
		 */
		public static function propsPopClose(obj:Object = null):void{
			GameEvent.stage.dispatchEvent( new GameEvent(GameEvent.GamePropsPopClose,obj) );
		}
		
		
		
		
		
	}
}

