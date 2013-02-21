package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.ColorBrush;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

/**
 * ContainerBMPTheme
 * 
 * @author impaler
 */
public class ContainerBMPTheme implements ITheme {

	public function initialize ():void {

		var uint_data:Vector.<uint>;

		var BGCOLOR:int = 0;

		uint_data = new Vector.<uint> ( 1 , true );
		uint_data[BGCOLOR] = 0xE9E9E9;
		ThemeBase.Container = new ColorBrush ( uint_data );

	}
}
}
