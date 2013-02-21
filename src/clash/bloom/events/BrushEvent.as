package clash.bloom.events 
{
	import flash.events.Event;
	
	/**
	 * BrushEvent
	 * 
	 * @author sindney
	 */
	public class BrushEvent extends Event {
		
		public static const REDRAW:String = "redraw";
		
		public function BrushEvent(type:String) {
			super(type);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.events.BrushEvent]";
		}
		
	}

}