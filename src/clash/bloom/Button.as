package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import clash.bloom.core.ButtonBase;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * Button
	 * 
	 * @author sindney
	 */
	public class Button extends ButtonBase {
		
		private var _title:Label;
		
		public function Button(p:DisplayObjectContainer = null, text:String = "", click:Function = null) {
			super(p);
			
			_title = new Label(this, text);
			_title.brush = ThemeBase.Text_Button;
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			_title.addEventListener(BrushEvent.REDRAW, onTitleChanged);
			
			if (click != null) addEventListener(MouseEvent.CLICK, click);
			size(100, 20);
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		override protected function draw(e:Event):void {
			super.draw(null);
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get title():Label {
			return _title;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.Button]";
		}
		
	}

}