package clash.widget.managers{
	import clash.gs.Tween;
	import clash.widget.ui.containers.Panel;
	import clash.widget.utils.Handler;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.Point;

	public class MinimizeManager{
		public static const BORDER:int=1;
		private static const SCALE:Number=.1;
		public static var regObject:Object=new Object();
		public static var startObject:Object=new Object();
		private var mirror:DisplayObject;
		private var tar:DisplayObject;
		private var p:Panel;
		private var type:int;
		private var startPos:Point;
		private var stopPos:Point;
		public function MinimizeManager(){
		}
		public static function register(p:Panel,tar:DisplayObject,type:int=BORDER):void{
			regObject[p]=new Handler(MinimizeManager.initMinimize,[p,tar,type]);
		}
		public static function startMinimizeHandler(p:Panel):void{
			var h:Handler=regObject[p];
			if(h){
				h.call();
			}
		}
		public static function initMinimize(p:Panel,tar:DisplayObject,type:int):void{
			var m:MinimizeManager;
			if(!startObject[p]){
				m=new MinimizeManager();
				m.p=p;
				m.tar=tar;
				m.type=type;
				startObject[p]=m;
			}else{
				m=startObject[p] as MinimizeManager;
			}
			m.startMinimize();
		}
		private function startMinimize():void{
			startPos=p.localToGlobal(new Point(0,0));
			stopPos=tar.localToGlobal(new Point(tar.width-p.width*SCALE>>1,tar.height-p.height*SCALE>>1));
			if(type==BORDER){
				if(!mirror){
					mirror=new Shape();
					var s:Shape=Shape(mirror);
					s.graphics.lineStyle(2,0,0);
					s.graphics.beginFill(0x2FB7D5,.3);
					s.graphics.drawRoundRect(0,0,p.width,p.height,10,10);
					s.graphics.endFill();
					s.x=startPos.x;
					s.y=startPos.y;
				}
			}
			p.stage.addChild(mirror);
			scaleMirror();
		}
		private function scaleMirror():void{
			if(type==BORDER){
				Tween.to(mirror,300,{"alpha":[1,0],"x":[startPos.x,stopPos.x],"y":[startPos.y,stopPos.y],"width":[p.width,p.width*SCALE],"height":[p.height,p.height*SCALE]},stopMinimize);
			}
		}
		private function stopMinimize():void{
			if(type==BORDER){
				(mirror as Shape).graphics.clear();
			}
			mirror=null;
		}
	}
}