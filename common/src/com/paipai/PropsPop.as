package com.paipai
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * 物品选择弹出层
	 */
	public class PropsPop extends MovieClip
	{
//		private var _type:String;
		private var data:Object;
		private var btns:Array = ['p1','p2','p3','p4'];
		//p1 是 浮层子元素实例  同时也对应库里的 p1结尾按钮 
		public var p1:SimpleButton;
		public var p2:SimpleButton;
		public var p3:SimpleButton;
		public var p4:SimpleButton;
		public var go:SimpleButton;
		
		
		public function PropsPop()
		{
			data = {};
			this.y = - 600;
			addEvent();
		}
		
		private function addEvent():void{
			//添加选中事件
			for(var i:int = 0,len:int = btns.length;i<len;i++){
				this.getChildByName(btns[i]).addEventListener(MouseEvent.CLICK, clickEvent);
			}
			//背景移动事件  
			this.getChildByName('go').addEventListener(MouseEvent.CLICK, goEvent); 
		}
		
		private function clickEvent(e:MouseEvent):void{
			var name:String = e.target.name;
			Utils.buttonToggle(e.target as SimpleButton);
			data[name] = !data[name];
			setData(e.target.name);
		}
		
		private function goEvent(e:MouseEvent):void{
			var isOk:Boolean = false,
				tops:Array = [];
			//添加数据  
			for(var i:String in data){
				if(data[i]){
					tops.push(i);
					isOk = true;
				}
			}
			
			if(isOk){
				GameEvent.propsPopClose({data:tops});
				this.dispose();
			}
			
			
		}
		
		public function dispose():void{
			//移除事件 及 释放内存  
			for(var i:int = 0,len:int = btns.length;i<len;i++){
				this.getChildByName(btns[i]).removeEventListener(MouseEvent.CLICK, clickEvent);
			}
			this.getChildByName('go').removeEventListener(MouseEvent.CLICK, goEvent);
		}
		
		/**
		 * 设置数据
		 */
		protected function setData(name:String):void{
			
		}
		
		/**
		 * 设置类型前缀
		 */
		protected function setType(type:String):void{
			
		}
		
	}
}