package com.paipai
{
	import com.paipai.GameModel;
	import com.paipai.Utils;
	
	import flash.display.MovieClip;

	/**
	 * 创建游戏所需的道具
	 */
	public class PropsUtils
	{
		public function PropsUtils()
		{
		}
		
		
		
		/**
		 * 创建上衣
		 */
		public static function createTops(x:Number):MovieClip{
			//获取上衣 
			var tops:Array = GameModel.getInstance().getTops();
			var mc:MovieClip = new Tops(x);
			var label:String = Utils.getRandom(tops);
			mc.gotoAndStop(label);
			return mc;
		}
		
		/**
		 * 创建鞋子
		 */
		public static function createShoe(x:Number):MovieClip{
			//获取鞋子
			var shoe:Array = GameModel.getInstance().getShoe();
			var mc:MovieClip = new Shoe(x);
			var label:String = Utils.getRandom(shoe);
			mc.gotoAndStop(label);
			return mc;
		}
		
		/**
		 * 创建鞋子
		 */
		public static function createLift(x:Number):MovieClip{
			//获取鞋子
			var lift:Array = GameModel.getInstance().getLift();
			var mc:MovieClip = new Shoe(x);
			var label:String = Utils.getRandom(lift);
			mc.gotoAndStop(label);
			return mc;
		}
		
		/**
		 * 创建道具
		 */
		public static function createProps(x:Number):MovieClip{
			var scene:int = GameModel.getInstance().scene;
			var mc:MovieClip;
			if(scene == 1){
				mc = PropsUtils.createTops(x);
			}else if(scene == 2){
				mc = PropsUtils.createShoe(x);
			}else if(scene == 3){
				mc = PropsUtils.createLift(x);
			}
			return mc;
		}
	}
}