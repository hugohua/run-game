package
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	import flash.events.MouseEvent;
	
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
		}
		
		private function showEvent(event:MouseEvent):void{
			mcGril.gotoAndPlay("end");
		};
		
		private function hideEvent(event:MouseEvent):void{
			mcGril.gotoAndPlay("start"); 
		};
		
		//public function show
		
		
	}
}