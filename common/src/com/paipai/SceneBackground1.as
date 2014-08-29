package com.paipai
{
	import com.paipai.Data;
	
	import flash.display.MovieClip;
	
	public class SceneBackground1 extends MovieClip implements IFrame
	{
		private static const SPEED:Number = Data.SPEED;
		private var distance:Number;
		
		public function SceneBackground1()
		{
			super();
			this.x  = 0; 
			this.y = 0;
			distance = 2500 - this.width;
			
		}
		
		public function action():void
		{
			this.x -= SPEED;
			trace(this.x,distance);
			//停止
			if(this.x <= distance){
				FrameTimer.remove(this);
				stage.dispatchEvent( new GameEvent(GameEvent.GameSceneOver,{scene:"p1"}) );
			}
		}
		
		/**
		 * 背景移动
		 */
		public function move():void {
			FrameTimer.add(this); 
		}
		
		public function stops():void {
			FrameTimer.remove(this);
		}
		
		/**
		 * 移除舞台
		 */ 
		public function dispose():void {
			FrameTimer.remove(this);
			parent.removeChild(this);
		}
	}
}