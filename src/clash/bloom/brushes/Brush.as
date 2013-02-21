package clash.bloom.brushes 
{
	import flash.events.EventDispatcher;
	
	/**
	 * Brush
	 * 
	 * @author sindney
	 */
	public class Brush extends EventDispatcher {
		
		public function Brush() {
			super();
		}
		
		public function update():void {
			
		}
		
		public function clone():Brush {
			return null;
		}
		
		public function destory():void {
			
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.brushes.Brush]";
		}
		
	}

}