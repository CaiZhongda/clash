package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import clash.bloom.core.TextBase;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * Label
	 * 
	 * @author sindney
	 */
	public class Label extends TextBase {
		
		public function Label(p:DisplayObjectContainer = null, text:String = "") {
			super(p);
			
			selectable = mouseEnabled = tabEnabled = false;
			type = "dynamic";
			autoSize = "left";
			
			brush = ThemeBase.Text_Label;
			
			this.text = text;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.Label]";
		}
		
	}

}