package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * ListItem
	 * 
	 * @author sindney
	 */
	public class ListItem extends FormItem {
		
		private var _title:Label;
		
		public function ListItem(p:DisplayObjectContainer = null) {
			super(p);
			
			_title = new Label(this);
			_title.brush = ThemeBase.Text_List;
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			_title.addEventListener(BrushEvent.REDRAW, onTitleChanged);
			
			brush = ThemeBase.ListItem;
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move(5, (_height - _title.height) * 0.5);
		}
		
		/**
		 * Call this when data:Array is modified.
		 */
		override public function dataChanged():void {
			_title.text = String(_data[0]);
			_changed = true;
			invalidate();
		}
		
		override protected function draw(e:Event):void {
			super.draw(null);
			_title.move(5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set data(a:Array):void {
			if (_data != a) {
				_data = a;
				_title.text = String(_data[0]);
				_changed = true;
				invalidate();
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ListItem]";
		}
		
	}

}
