package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.BMPBrush;
import clash.bloom.brushes.TextBrush;
import clash.bloom.core.ScaleBitmap;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * TextInputBMPTheme
 * 
 * @author impaler
 */
public class TextInputBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/textbox/textbox_bg.png")]
	private var textbox_bg:Class;

	public function initialize ():void {

		ThemeBase.Text_TextInput = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new textbox_bg () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.TextInput = new BMPBrush ( data );

	}
}
}



