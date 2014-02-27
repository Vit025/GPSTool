package  {
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Vitaly Filinov @ TELEFISION TEAM
	 * @modified 2013-10-16 16:53 by Vitaly Filinov @ TELEFISION TEAM
	 */
	public class LocalDataManager {
		
		/* pn - phone number */
		/* rs - register status */
		/* clu - contacts last update */
		/* cha - last contacts hash */
		
		public function LocalDataManager() {
		}
		
		public static function setValue(paramName:String, value:*):void {
			var bytes:ByteArray = new ByteArray();
			if (value is String)
				bytes.writeUTFBytes(value as String);
			else if (value is Number && !(value is int))
				bytes.writeDouble(value as Number);
			else if (value is int)
				bytes.writeInt(value as int);
			else if (value is Boolean)
				bytes.writeBoolean(value as Boolean);
			else if (value is Array)
				bytes.writeObject(value as Array);
			else if (value is ByteArray)
				bytes = value;
			else
				bytes.writeObject(value as Object);
			EncryptedLocalStore.setItem(paramName, bytes);
		}
		
		public static function getString(paramName:String):String {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return "";
			return bytes.readUTFBytes(bytes.length);
		}
		
		public static function getInt(paramName:String):int {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes) {
				return NaN;
			}
			var result:Number = bytes.readInt();
			return result;
		}
		
		public static function getNumber(paramName:String):Number {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return NaN;
			return bytes.readFloat();
		}
		
		public static function getBool(paramName:String):Boolean {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return false;
			return bytes.readBoolean();
		}
		
		public static function getArray(paramName:String):Array {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return null;
			return (bytes.readObject() as Array);
		}
		
		public static function getObject(paramName:String):Object {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return null;
			return bytes.readObject();
		}
		
		public static function getBytes(paramName:String):ByteArray {
			var bytes:ByteArray = EncryptedLocalStore.getItem(paramName);
			if (!bytes)
				return null;
			return bytes;
		}
		
		public static function deleteParam(paramName:String):void {
			EncryptedLocalStore.removeItem(paramName);
		}
		
		public static function clear():void {
			EncryptedLocalStore.reset();
		}
		
	}
}