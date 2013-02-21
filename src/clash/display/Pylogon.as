package clash.display{
	import flash.display.Shape;
	
	public class Pylogon extends Shape{
		public function Pylogon()
		{
			super();
		}
		public function setArray(a:Array):void{
			graphics.moveTo(a[0][0],a[0][1]);
			graphics.lineStyle(3);
			for(var i:int=0;i<a.length;i++){
				graphics.lineTo(a[i][0],a[i][1]);
			}
			graphics.lineTo(a[0][0],a[0][1]);
		}
	}
}