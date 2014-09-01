package com.paipai
{
	import flash.display.MovieClip;
	
	/**
	 * 游戏道具超类
	 */
	public class Props extends MovieClip implements IFrame
	{
		private static const SPEED:Number = Data.SPEED;
		private var pos:Array = [200,400];
		private var isHit:Boolean;		//只能碰撞一次
		
		public function Props(x:Number)
		{
			//TODO: implement function
			super();
			this.x  = x;
			this.y = Utils.getRandom(pos);
			this.gotoAndStop(1);
			FrameTimer.add(this); 
			//监听over事件
			GameEvent.stage.addEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);
		}
		
		public function action():void
		{
			//TODO: implement function
			this.x -= SPEED;
			//碰撞检测 碰撞到人了
			if(HitTest.complexHitTestObject(this,GameModel.getInstance().hit) && !isHit){
				isHit = true;
				GameEvent.hitProps({hit:this});
			}
		}
		
		private function GameSceneOverEvt(e:GameEvent):void{
			stops();
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
			GameEvent.stage.removeEventListener(GameEvent.GameSceneOver, GameSceneOverEvt);
			FrameTimer.remove(this);
			parent.removeChild(this);
		}
	}
}