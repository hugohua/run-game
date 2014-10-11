package com.paipai
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * 开始
	 */
	public class Start extends MovieClip
	{
		public var mcBoy:MovieClip;
		public var mcGirl:MovieClip;
		public var mcStar:MovieClip;
//		public var btnGo:SimpleButton;
//		public var btnGo2:SimpleButton;
		
		public function Start()
		{
			super();
			init();
		}
		
		private function init():void{
			mcBoy = this.getChildByName('mcBoy') as MovieClip;
			mcBoy.btnGo2.addEventListener(MouseEvent.CLICK,startGameEvent);
			
			mcGirl = this.getChildByName('mcGirl') as MovieClip;
			mcGirl.btnGo.addEventListener(MouseEvent.CLICK,startGameEvent);
			//.btnGo2.addEventListener(MouseEvent.CLICK,startGameEvent); 
//			this.getChildByName('mcGirl').btnGo.addEventListener(MouseEvent.CLICK,startGameEvent); 
		}
		
		private function startGameEvent(e:MouseEvent):void{
			var type:String = "girl";
			if(e.target.name == "btnGo2"){
				type = "boy";
			}
			trace(type)
			GameModel.getInstance().type = type; 
			GameEvent.start({type:type});
//			stage.dispatchEvent( new GameEvent(GameEvent.GameStart,{type:type}) );
		}
		
		public function dispose():void{
			mcGirl.btnGo.removeEventListener(MouseEvent.CLICK,startGameEvent);
			mcBoy.btnGo2.removeEventListener(MouseEvent.CLICK,startGameEvent);
		}
		
	}
}