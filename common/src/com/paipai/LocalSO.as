package com.paipai
{
	import flash.events.NetStatusEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	/**
	 * LocalSO.as
	 * author：cyb
	 * 2013 2013-9-16 下午02:29:42
	 */
	
	public class LocalSO
	{
		private static var instance:LocalSO;
		private var _shareObject:SharedObject;
		
		public static function getInstance():LocalSO
		{
			return instance ||= new LocalSO();
		}
		
		public function LocalSO()
		{
			if(!instance)
				instance = this;
			else 
				throw new Error("LocalSO is a singal class")
		}
		
		/**
		 *  
		 * @param key
		 * 
		 */		
		public function getsharedObject(key:String):void 
		{
			_shareObject = SharedObject.getLocal(key);
			_shareObject.objectEncoding = ObjectEncoding.AMF3;
		}
		
		/**
		 * 如果是有值的value 则存储， 否则删除这个key里面的值; 
		 * @param key
		 * @param value
		 * 
		 * 用法： var localSo:LocalSo = LocalSo.getInstance().getsharedObject("gameScore");
		 * localSo.setKey("gameScore","10000");
		 * trace(localSo.flush());
		 */		
		public function setKey(key:String , value:*):void 
		{
			if (value != null) {
				_shareObject.setProperty(key, value);
				_shareObject.flush();
			} else {
				delete _shareObject.data[key];
			}
		}
		
		/**
		 * getAt 获得键值
		 * 
		 * @param key 键
		 * var lso:LocalSO=LocalSO.getInstance().getsharedObject("gameScore");
		 * trace(lso.getAt("key")); // 如果flush成功则输出"value"
		 */
		public function getAt(key : String) : Object {
			return _shareObject.data[key];
		}
		
		/**
		 * 保存数据到本地对象
		 * 
		 * @return Boolean 成功
		 */
		public function flush() : Boolean {
			return _shareObject.flush() as Boolean;
		}
		
		/**
		 * 清除此本地对象中的所有数据
		 */
		public function clear() : void {
			_shareObject.clear();
		}
		
	}
}