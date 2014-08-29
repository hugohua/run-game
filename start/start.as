package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import com.paipai.GameEvent;
	import com.paipai.GameModel;
	
	public class start extends Sprite
	{
		
		public function start()
		{
			if(!stage)
				addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			else 
				addedToStageHandler(); 
		}
		
		protected function addedToStageHandler(e:Event = null):void{
			//移除事件  
			if(hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			
			addEvent();
		}
		
		/**
		 * 添加事件   
		 */
		private function addEvent():void{
			mcGril.addEventListener(MouseEvent.MOUSE_OVER,showEvent);
			mcGril.addEventListener(MouseEvent.MOUSE_OUT,hideEvent);
			mcGril.btnGo.addEventListener(MouseEvent.CLICK,startGameEvent);
			mcMan.btnGo2.addEventListener(MouseEvent.CLICK,startGameEvent);
		}
		
		private function removeEvent():void{
			mcGril.removeEventListener(MouseEvent.MOUSE_OVER,showEvent);
			mcGril.removeEventListener(MouseEvent.MOUSE_OUT,hideEvent);
			mcGril.btnGo.removeEventListener(MouseEvent.CLICK,startGameEvent);
			mcMan.btnGo2.removeEventListener(MouseEvent.CLICK,startGameEvent);
		}
		
		private function showEvent(event:MouseEvent):void{
//			mcGril.gotoAndPlay("end"); 
		};
		
		private function hideEvent(event:MouseEvent):void{
//			mcGril.gotoAndPlay("start");
		};
		
		/**
		 * 开始游戏
		 */
		private function startGameEvent(e:MouseEvent):void{
			var type = "girl";
			if(e.target.name == "btnGo2"){
				type = "boy";
			}
			trace(type)
			GameModel.getInstance().type = type; 
			stage.dispatchEvent( new GameEvent(GameEvent.GameStart,{type:type}) );
			//加载背景及人物
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void{
			removeEvent();
		}
		
		
		
	}
}