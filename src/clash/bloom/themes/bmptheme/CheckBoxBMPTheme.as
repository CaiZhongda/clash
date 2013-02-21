package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.BMPBrush;
import clash.bloom.brushes.TextBrush;
import clash.bloom.core.ScaleBitmap;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

import flash.display.Bitmap;

/**
 * CheckBoxBMPTheme
 * 
 * @author impaler
 */
public class CheckBoxBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_on.png")]
	private var checkbox_on:Class;

	[Embed(source="../../assets/defaultBMP/checkbox/checkbox_off.png")]
	private var checkbox_off:Class;

	public function initialize ():void {

		ThemeBase.Text_CheckBox = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;

		var OFF:int = 0;
		var ON:int = 1;

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[OFF] = new ScaleBitmap ( Bitmap ( new checkbox_off () ).bitmapData );
		data[ON] = new ScaleBitmap ( Bitmap ( new checkbox_on () ).bitmapData );
		ThemeBase.CheckBox = new BMPBrush ( data );

	}
}
}

