package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.BMPBrush;
import clash.bloom.brushes.TextBrush;
import clash.bloom.core.ScaleBitmap;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

import flash.display.Bitmap;
import flash.geom.Rectangle;

/**
 * NumericStepperBMPTheme
 * 
 * @author impaler
 */
public class NumericStepperBMPTheme implements ITheme {

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_bg_normal.png")]
	private var ns_bg_normal:Class;
	private var ns_bg_normal_bit:Bitmap = new ns_bg_normal ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_bg_active.png")]
	private var ns_bg_active:Class;
	private var ns_bg_active_bit:Bitmap = new ns_bg_active ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_decrease_button_normal.png")]
	private var ns_decrease_button_normal:Class;
	private var ns_decrease_button_normal_bit:Bitmap = new ns_decrease_button_normal ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_decrease_button_over.png")]
	private var ns_decrease_button_over:Class;
	private var ns_decrease_button_over_bit:Bitmap = new ns_decrease_button_over ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_decrease_button_down.png")]
	private var ns_decrease_button_down:Class;
	private var ns_decrease_button_down_bit:Bitmap = new ns_decrease_button_down ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_increase_button_normal.png")]
	private var ns_increase_button_normal:Class;
	private var ns_increase_button_normal_bit:Bitmap = new ns_increase_button_normal ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_increase_button_over.png")]
	private var ns_increase_button_over:Class;
	private var ns_increase_button_over_bit:Bitmap = new ns_increase_button_over ();

	[Embed(source="../../assets/defaultBMP/numeric_stepper/ns_increase_button_down.png")]
	private var ns_increase_button_down:Class;
	private var ns_increase_button_down_bit:Bitmap = new ns_increase_button_down ();

	public function initialize ():void {

		ThemeBase.Text_NumericStepper = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );

		var data:Vector.<ScaleBitmap>;
		var scaleBMP0:ScaleBitmap;
		var scaleBMP1:ScaleBitmap;
		var scaleBMP2:ScaleBitmap;

		var NORMAL:int = 0;
		var OVER:int = 1;
		var DOWN:int = 2;

		scaleBMP0 = new ScaleBitmap ( ns_bg_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		scaleBMP1 = new ScaleBitmap ( ns_bg_active_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 13 , 15 , 51 , 12 );

		data = new Vector.<ScaleBitmap> ( 2 , true );
		data[0] = scaleBMP0;
		data[1] = scaleBMP1;
		ThemeBase.NumericStepper = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( ns_decrease_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		scaleBMP1 = new ScaleBitmap ( ns_decrease_button_down_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		scaleBMP2 = new ScaleBitmap ( ns_decrease_button_over_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 2 , 13 , 4 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP2;
		data[DOWN] = scaleBMP1;
		ThemeBase.NS_Decrease = new BMPBrush ( data );

		scaleBMP0 = new ScaleBitmap ( ns_increase_button_normal_bit.bitmapData );
		scaleBMP0.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		scaleBMP1 = new ScaleBitmap ( ns_increase_button_down_bit.bitmapData );
		scaleBMP1.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		scaleBMP2 = new ScaleBitmap ( ns_increase_button_over_bit.bitmapData );
		scaleBMP2.scale9Grid = new Rectangle ( 2 , 4 , 13 , 4 );

		data = new Vector.<ScaleBitmap> ( 3 , true );
		data[NORMAL] = scaleBMP0;
		data[OVER] = scaleBMP2;
		data[DOWN] = scaleBMP1;
		ThemeBase.NS_Increase = new BMPBrush ( data );

	}
}
}
