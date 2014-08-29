package com.paipai
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.paipai.GameModel;
	import com.paipai.Score;
	import com.paipai.SceneBackground1;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	public class Loader
	{
		private var type:String;
		private var swfPeople:SWFLoader;							//人物swf
		private var swfScene:SWFLoader;							//运动场景
		private var TempClass:Class;
		private var mc:MovieClip;
		
		public function Loader()
		{
			type = GameModel.getInstance().type;
			swfPeople = LoaderMax.getLoader(type + "SWF");				//取得swf
			swfScene = LoaderMax.getLoader(type + "SceneSWF");
		}
		
		/**
		 * 加载场景2
		 */
		public function getPartBackground():DisplayObject{
			return LoaderMax.getContent(type + "Part1SWF").rawContent;
		}
		
		/**
		 * 获取跑步的人
		 */
		public function getPeopleRun():MovieClip{
			TempClass =  swfPeople.getClass("People");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 获取站立的人
		 */
		public function getPeopleSanding():MovieClip{
			TempClass =  swfPeople.getClass("PeopleSanding");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 获取弹出层
		 */
		public function getPopStart():MovieClip{
			TempClass =  swfPeople.getClass("PopStart");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 加载跑步场景swf
		 */
		public function getSceneBackground():MovieClip{
			mc = new SceneBackground1();
			return mc;
		}
		
		/**
		 * 获取游戏提示mc
		 */
		public function getSceenGameTips():MovieClip{
			TempClass = swfScene.getClass("GameTips");
			mc = new TempClass();
			return mc;
		}
		
		/**
		 * 加载记分牌
		 */
		public function getScore():Score{
			var score:Score =  new Score();
			return score;
		}
		
	}
}