package com.paipai
{
	import flash.display.MovieClip;
	import com.paipai.GameEvent;
	
	/**
	 * 记分牌
	 */
	public class Score extends MovieClip
	{
		private var totalLen:int;
		private var isWin:int;		//0是输  3是赢
		
		
		public function Score()
		{
			super();
			this.x = 400;
			this.y = 400;
			this.gotoAndStop(1);
			totalLen =  this.totalFrames;
			isWin = 2;
		}
		
		/**
		 * 添加一分
		 */
		public function addScore():int{
			var cur:int = this.currentFrame;
			cur++;
			if(cur >= totalLen){
				cur = totalLen;
				isWin = 0;
			}
			this.gotoAndStop(cur);
			return isWin;
		}
		
		/**
		 * 减去一分
		 */
		public function removeScore():int{
			var cur:int = this.currentFrame;
			cur++;
			
			if(cur <= 0){
				cur = 0;
				isWin = 3;
			}
			
			this.gotoAndStop(cur);
			return isWin;
		}
		
		/**
		 * 移除
		 */ 
		public function dispose():void {
			parent.removeChild(this);
		}
	}
}