package clash.bloom.themes.bmptheme {

import clash.bloom.brushes.TextBrush;
import clash.bloom.themes.ITheme;
import clash.bloom.themes.ThemeBase;

/**
 * LabelBMPTheme
 * 
 * @author impaler
 */
public class LabelBMPTheme implements ITheme {

	public function initialize ():void {
		
		ThemeBase.Text_Label = new TextBrush ( "Verdana" , 12 , 0x000000 , false , false , false );
		
	}
}
}
