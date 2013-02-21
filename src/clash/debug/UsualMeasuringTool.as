package clash.debug{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * UsualMeasuringTool用来测试内存
	 * @author Colin created on Feb 21, 2013
	 */
	public class UsualMeasuringTool{
		private static const ENSURE_GC_TIMES:int=3;
		private static const BYTE_TO_MEGABYTE:int=1<<16;
		public static var needForceGC:Boolean=true;
		private static var needReportTrack:Boolean;
		private static var fpcStartTime:int=getTimer();
		private static var calcTimeDict:Dictionary=new Dictionary();
		private static var enterFrameTimes:int=0;
		private static var referObject:Sprite;
		private static var d:Dictionary=new Dictionary(true);
		private static var gcTimes:int;
		private static var interval:int;
		public function UsualMeasuringTool(p:PrivatePress){}
		/**
		 * 注册显示对象参考
		 * @referObject 这里指定参考对象，一般为文档类
		 * @$interval 以秒为单位
		 * @author Colin created on Feb 21, 2013
		 */
		public static function registerReferObject($referObject:Sprite,$interval:int):void{
			referObject=$referObject;
			interval=$interval;
			if(interval>0){
				referObject.addEventListener(Event.ENTER_FRAME,measuringSystem,false,0,true);
			}
		}
		/**
		 * 注册需要测量的对象
		 * @param obj 需要测量的对象
		 * @param detail 对象存在时输出的内容
		 * @author Colin created on Feb 21, 2013
		 */
		public static function registerTrack(obj:*,detail:*=null):void{
			d[obj]=detail;
		}
		/**
		 * 强制报告当前测量结果
		 * @author Colin created on Feb 21, 2013
		 */
		public static function report():void{
			needReportTrack=true;
			validateTrackAndGC();
		}
		/**
		 * 开始计算用时
		 * @author Colin created on Feb 21, 2013
		 */
		public static function calcTimeStart(id:int):void{
			calcTimeDict[id]=getTimer();
		}
		/**
		 * 结束计算用时
		 * @author Colin created on Feb 21, 2013
		 */
		public static function calcTimeEnd(id:int):void{
			var timeUsed:int=getTimer()-calcTimeDict[id];
			trace("====DEBUG>TimeUsed:"+timeUsed)
			delete calcTimeDict[id];
		}
		private static function measuringSystem(e:Event):void{
			enterFrameTimes++;
			if (enterFrameTimes%(interval*referObject.stage.frameRate)==0){
				gcTimes=0;
				trace("====");
				validateTrackAndGC();
				trace("====DEBUG>FPS:",int(enterFrameTimes*1000/(getTimer()-fpcStartTime)));
				trace("====DEBUG>Memory Usage:",System.totalMemory/BYTE_TO_MEGABYTE>>0,"MB");
				enterFrameTimes=0;
				fpcStartTime=getTimer();
			}
		}
		private static function validateTrackAndGC():void {
			referObject.addEventListener(Event.ENTER_FRAME,trackAndGC,false,0,true);
			gcTimes=0;
		}
		private static function trackAndGC(e:Event):void {
			var removeAndTrack:Boolean;
			if(needForceGC){
				System.gc();
				gcTimes++;
				removeAndTrack=gcTimes>ENSURE_GC_TIMES-1;
			}else{
				removeAndTrack=true;
			}
			if (removeAndTrack){
				referObject.removeEventListener(Event.ENTER_FRAME,trackAndGC,false);
				if(needReportTrack){
					needReportTrack=false;
					reportObjectTracking();
				}
			}
		}
		private static function reportObjectTracking():void{
			trace("====DEBUG>MEMORY REPORT AT:",int(getTimer()/1000));
			for(var obj:* in d){
				trace("====DEBUG>",obj," exists:",d[obj]);
			}
		}
	}
}
class PrivatePress{}