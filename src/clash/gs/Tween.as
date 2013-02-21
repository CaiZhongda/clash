package clash.gs {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Tween {
		private static var pool:Array = [];
		private static var list:Array = [];
		private static var threadMap:Dictionary = new Dictionary();
		private static const sprite:Sprite=new Sprite;
		
		public static function to(target:DisplayObject, time:int, propertie:Object, complete:Function = null, fun:Function = null):void {
			var thread:Thread;
			if(threadMap[target]) {
				thread = threadMap[target];
			}else {
				thread = pool.length > 0?pool.pop():new Thread();
				thread.target = target;
				list.push(thread);
				threadMap[target] = thread;
			}
			thread.beginTime = getTimer();
			thread.totleTime = time;
			thread.propertie = [];
			for(var key:String in propertie) {
				thread.propertie.push([key, propertie[key][0], propertie[key][1]]);
			}
			thread.complete = complete;
			thread.fun = fun;
			start();
		}
		
		public static function stop(target:DisplayObject):void {
			for(var i:int=list.length - 1;i>=0; i--) {
				if(list[i].target == target) {
					delete threadMap[list[i].target];
					pool.push(list[i]);
					list.splice(i, 1);
				}
			}
		}
		
		private static function start():void {
			if(!sprite.hasEventListener(Event.ENTER_FRAME))
				sprite.addEventListener(Event.ENTER_FRAME, run);
		}
		
		private static function run(e:Event):void {
			if(!list.length)sprite.removeEventListener(Event.ENTER_FRAME, run);
			var now:int = getTimer();
			for(var i:int=list.length-1; i>=0; i--) {
				var thread:Thread = list[i];
				for(var j:int=0; j<thread.propertie.length; j++) {
					var rate:Number = (now - thread.beginTime)/thread.totleTime;
					var value:Number = thread.propertie[j][1] + rate * (thread.propertie[j][2] - thread.propertie[j][1]);
					thread.target[thread.propertie[j][0]] = thread.propertie[j][2]>thread.propertie[j][1]?(value>thread.propertie[j][2]?thread.propertie[j][2]:value):(value<thread.propertie[j][2]?thread.propertie[j][2]:value);
					if(thread.fun != null)thread.fun();
				}
				if((now - thread.beginTime) > thread.totleTime){
					list.splice(i, 1);
					delete threadMap[thread.target];
					pool.push(thread);
					if(thread.complete != null)thread.complete();
				}
			}
		}
	}
}

import flash.display.DisplayObject;

class Thread {
	
	public var target:DisplayObject;
	public var beginTime:int;
	public var totleTime:int;
	public var propertie:Array;
	public var complete:Function;
	public var fun:Function;
}