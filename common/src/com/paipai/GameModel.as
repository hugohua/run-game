package com.paipai
{
	import com.paipai.LocalSO;
	
//	import flash.net.SharedObject;
	
	public class GameModel
	{
		/**
		 * 数据默认值
		 */
		private var data:Object = {
			tops:{
				p1:false,
				p2:false,
				p3:false,
				p4:false
			}
		};
		private static var _instance:GameModel;
//		private var mySo:SharedObject;
		
		
		/**
		 * 数据格式
		 */
//		var data = {
//			type: boy or girl
//			tops :[1,2,3],
//			pants :[1,2,3],
//			shoe:[1,2,3]
//		}
		
		
		public static function getInstance():GameModel {
			return _instance ? _instance : (new GameModel());
		}
		
		public function GameModel()
		{
			if(!_instance)
				_instance=this;
			else 
				throw new Error("GameModel is a singale class")
		}
		
		/**
		 * 获取游戏数据
		 */
		public function get gameSocre():Object{
			if(data){
				return data;
			}else{
				var lso:LocalSO=LocalSO.getInstance();
				lso.getsharedObject("game");
				return lso.getAt("gameScore") as  Object;
			}
		}
		
		/**
		 * 设置游戏数据
		 */
		public function set gameSocre(obj:Object):void{
			data = obj;
			var lso:LocalSO=LocalSO.getInstance();
			lso.getsharedObject("game");
			lso.setKey("gameScore",data);
			trace(lso.flush());
		}
		
		/**
		 * 设置用户类型，是男还是女
		 */
		public function get type():String{
			return data.type;
		}
		
		/**
		 * 设置用户类型，是男还是女
		 */
		public function set type(type:String):void{
			data.type = type;
			var lso:LocalSO=LocalSO.getInstance();
			lso.getsharedObject("game");
			lso.setKey("gameScore",data);
		}
		
		/**
		 * 上衣
		 */
		public function setTops(name:String):void{
			data.tops[name] = !data.tops[name];
			var lso:LocalSO=LocalSO.getInstance();
			lso.getsharedObject("game");
			lso.setKey("gameScore",data);
		}
		
		public function get tops():Array{
			return [];
		}
		
		
	}
}