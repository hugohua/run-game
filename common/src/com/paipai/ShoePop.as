package com.paipai
{
	public class ShoePop extends PropsPop
	{
		/**
		 * 鞋子浮层
		 */
		public function ShoePop()
		{
			super();
		}
		
		/**
		 * 设置鞋子的选择数据
		 */
		override protected function setData(name:String):void{
			GameModel.getInstance().setShoe(name);
		}
		
		override protected function setType(type:String):void{
			
		};
	}
}