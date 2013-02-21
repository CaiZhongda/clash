package clash.bloom.themes.bmptheme 
{
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.themes.ThemeBase;
	import clash.bloom.themes.ITheme;
	
	/**
	 * AccordionTheme
	 * 
	 * @author sindney
	 */
	public class AccordionTheme implements ITheme {
		
		public function initialize():void {
			var data:Vector.<uint>;
			
			data = new Vector.<uint>(1, true);
			data[0] = 0x3E3E50;
			ThemeBase.AC_Title = new ColorBrush(data);
			
			data = new Vector.<uint>(1, true);
			data[0] = 0xB4B4B4;
			ThemeBase.AC_Content = new ColorBrush(data);
		}
		
	}

}