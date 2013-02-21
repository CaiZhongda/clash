package clash.bloom
{
	import flash.display.DisplayObjectContainer;

	import clash.bloom.themes.ThemeBase;

	/**
	 * List
	 *
	 * @author sindney
	 */
	public class List extends Form {

		public function List(p:DisplayObjectContainer = null, d:Array = null) {
			super(p, d);
			brush = ThemeBase.List;
			_scrollBar.brush = ThemeBase.List_ScrollBar;
			_scrollBar.button.brush = ThemeBase.List_ScrollBarButton;
		}

		override protected function newItem():* {
			return new ListItem();
		}

		///////////////////////////////////
		// toString
		///////////////////////////////////

		override public function toString():String {
			return "[bloom.List]";
		}

	}

}
