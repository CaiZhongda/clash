package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.BMPBrush;
import clash.bloom.core.ScaleBitmap;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * WindowBMPTheme
 * 
 * @author impaler
 */
public class WindowBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/window/window_bg.png")]
	private var window_bg:Class;

	[Embed(source="../../assets/defaultBMP/window/window_footer.png")]
	private var window_footer:Class;

	[Embed(source="../../assets/defaultBMP/window/window_header.png")]
	private var window_header:Class;

	[Embed(source="../../assets/defaultBMP/window/sizer.png")]
	private var sizer:Class;

	public function initialize ():void {

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new window_header () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 9 , 9 , 182 , 4 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.Window_Header = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new window_footer () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 9 , 6 , 182 , 4 );

		data = new Vector.<ScaleBitmap> ( 1 , true );
		data[0] = scaleBMP0;
		ThemeBase.Window_Footer = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( Bitmap ( new window_bg () ).bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 11 , 1 , 180 , 2 );

		scaleBMP1 = new ScaleBitmap ( Bitmap ( new sizer () ).bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 0 , 0 , 0 , 0 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.Window = new BMPBrush ( data );

	}
}
}
