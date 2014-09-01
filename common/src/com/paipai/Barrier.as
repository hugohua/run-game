package com.paipai
{
	import com.paipai.Data;
	
	import flash.display.MovieClip;
	
	public class Barrier extends MovieClip implements IFrame
	{
		private static const SPEED:Number = Data.SPEED;
		private static const YPOS:Number = 400;
		private var isHit:Boolean;		//只能碰撞一次
		
		public function Barrier(x:Number)
		{
			//TODO: implement function
			super();
			this.x  = x;
			this.y = YPOS;
			isHit = false;
			FrameTimer.add(this); 
			//监听over事件
			GameEvent.stage.addEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);
		}
		
		
		private function GameSceneOverEvt(e:GameEvent):void{
			FrameTimer.remove(this);
		}
		
		public function action():void
		{
			//TODO: implement function
			this.x -= SPEED;
			//碰撞检测 碰撞到人了
			if(HitTest.complexHitTestObject(this,GameModel.getInstance().hit) && !isHit ){
				isHit = true;
				GameEvent.hitBarrier({hit:this});
			}
		}
		
		/**
		 * 移除舞台上的大便
		 */ 
		public function dispose():void {
			GameEvent.stage.removeEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);
			FrameTimer.remove(this);
			parent.removeChild(this);
		}
		
		
	}
}