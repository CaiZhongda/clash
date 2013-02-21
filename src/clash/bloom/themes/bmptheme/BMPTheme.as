package clash.bloom.themes.bmptheme {

import clash.bloom.themes.*;

/**
 * BMPTheme
 * 
 * @author impaler
 */
public class BMPTheme implements ITheme {

	public function initialize ():void {
		new AccordionTheme ().initialize();
		new ButtonBMPTheme ().initialize ();
		new ListBMPTheme ().initialize ();
		new NumericStepperBMPTheme ().initialize ();
		new CheckBoxBMPTheme ().initialize ();
		new ProgressBarBMPTheme ().initialize ();
		new SliderBMPTheme ().initialize ();
		new NumericStepperBMPTheme ().initialize ();
		new LabelBMPTheme ().initialize ();
		new TabsBMPTheme ().initialize ();
		new WindowBMPTheme ().initialize ();
		new ScrollButtonBMPTheme ().initialize ();
		new FormBMPTheme ().initialize ();
		new TextBoxBMPTheme ().initialize ();
		new TextInputBMPTheme ().initialize ();
		new ToggleButtonBMPTheme ().initialize ();
		new ContainerBMPTheme ().initialize ();
	}

}

}
