package com.paipai
{
	public class TopsPop extends PropsPop
	{
		/**
		 * 上衣浮层
		 */
		public function TopsPop()
		{
			super();
		}
		
		/**
		 * 设置上衣的选择数据
		 */
		override protected function setData(name:String):void{
			GameModel.getInstance().setTops(name);
		}
		
	}
}