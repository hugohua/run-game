package com.paipai
{
	import com.paipai.Data;
	
	import flash.display.MovieClip;
	
	public class SceneBackground extends MovieClip implements IFrame
	{
		private static const SPEED:Number = Data.SPEED;
		private var distance:Number;
		//循环次数
//		private static const LOOP:int = Data.LOOP;
		
		public function SceneBackground()
		{
			super();
			this.x  = -250; 
			distance = -7200; 
			//设置关卡场景
			this.gotoAndStop(GameModel.getInstance().scene);
		}
		
		public function action():void
		{
			this.x -= SPEED;
			//停止
			if(this.x <= distance){
				FrameTimer.remove(this);
				GameEvent.sceneOver({scene:"p1"});
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