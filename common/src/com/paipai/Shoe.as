package com.paipai
{
	import flash.display.MovieClip;
	import com.paipai.Data;
	
	public class Shoe extends MovieClip implements IFrame
	{
		private static const SPEED:Number = Data.SPEED;
		private static const YPOS:Number = 400;
		
		public function Shoe(x:Number)
		{
			//TODO: implement function
			super();
			this.x  = x;
			this.y = YPOS;
			FrameTimer.add(this); 
			
		}
		
		public function action():void
		{
			//TODO: implement function
			this.x -= SPEED;
		}
		
		/**
		 * 停止
		 */
		public function stops():void{
			FrameTimer.remove(this);
		}
		
		/**
		 * 移除舞台上的大便
		 */ 
		public function dispose():void {
			FrameTimer.remove(this);
			parent.removeChild(this);
		}
	}
}