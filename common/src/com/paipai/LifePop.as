package com.paipai
{
	public class LifePop extends PropsPop
	{
		public function LifePop()
		{
			super();
		}
		
		override protected function setData(name:String):void{
			GameModel.getInstance().setLift(name);
		}
	}
}