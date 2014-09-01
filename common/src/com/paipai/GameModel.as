package com.paipai
{
	import com.paipai.LocalSO;
	
	import flash.display.MovieClip;
	
	public class GameModel
	{
		/**
		 * 数据默认值
		 */
		private var data:Object = {
			//上衣
			tops:{
//				p1:false,
//				p2:false,
//				p3:false,
//				p4:false
			},
			//鞋子
			shoe:{
				
			},
			//生活方式
			lift:{
				
			},
			//选择穿上的上衣
			topsSelect:false,
			//选择穿上的鞋子
			shoeSelect:false,
			//选择的生活方式
			liftSelect:false
		};
		
		//需要碰撞的people
		private var people:MovieClip;
		
		private static var _instance:GameModel;

		private var sceneNum:int = 1;
		
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
		 * 写入本地flash数据存储
		 */
		private function setLos():void{
			var lso:LocalSO=LocalSO.getInstance();
			lso.getsharedObject("game");
			lso.setKey("gameScore",data);
//			trace(lso.flush());
		}
		
		/**
		 * 设置游戏数据
		 */
		public function set gameSocre(obj:Object):void{
			data = obj;
			setLos();
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
			setLos();
		}
		
		/**
		 * 上衣
		 */
		public function setTops(name:String):void{
			data.tops[name] = !data.tops[name];
			setLos();
		}
		
		/**
		 * 鞋子
		 */
		public function setShoe(name:String):void{
			data.shoe[name] = !data.shoe[name];
			setLos();
		}
		
		/**
		 * 鞋子
		 */
		public function setLift(name:String):void{
			data.lift[name] = !data.lift[name];
			setLos();
		}
		
		/**
		 * 获取选中的上衣数组
		 */
		public function getTops():Array{
			var tops:Array = [];
			for(var i:String in data.tops){
				if(data.tops[i]){
					tops.push(i);
				}
			}
			return tops;
		}
		
		/**
		 * 获取选中的鞋子数组 
		 */
		public function getShoe():Array{
			var shoe:Array = [];
			for(var i:String in data.shoe){
				if(data.shoe[i]){
					shoe.push(i);
				}
			}
			return shoe;
		}
		
		/**
		 * 获取选中的生活方式 
		 */
		public function getLift():Array{
			var lift:Array = [];
			for(var i:String in data.lift){
				if(data.shoe[i]){
					lift.push(i);
				}
			}
			return lift;
		}
		
		
		/**
		 * 设置碰撞对象
		 */
		public function set hit(p:MovieClip):void{
			people = p;
		}
		
		public function get hit():MovieClip{
			return people;
		}
		
		/**
		 * 新增一个part
		 */
		public function set scene(num:int):void{
			sceneNum += num;
		}
		
		/**
		 * 获取part
		 */
		public function get scene():int{
			return sceneNum;
		}
		
		/**
		 * 设置选择穿上的 上衣
		 */
		public function setTopsSelect(tops:String):void{
			data.topsSelect = tops;
			trace(data.topsSelect,tops)
		}
		
		/**
		 * 设置选择穿上的 鞋子
		 */
		public function setShoeSelect(shoe:String):void{
			data.shoeSelect = shoe;
		}
		
		/**
		 * 设置选择的生活方式
		 */
		public function setLiftSelect(lift:String):void{
			data.liftSelect = lift;
		}
		
		
		/**
		 * 获取穿上的物品
		 */
//		public function getPropsData():Object{
//			
//		}
		
		
	}
}