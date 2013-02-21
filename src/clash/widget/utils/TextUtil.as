package clash.widget.utils
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;

	/**
	 * 文本工具类 
	 * @author Administrator
	 * 
	 */
	public class TextUtil
	{
		/**
		 * 当TextField的宽度不够放入s时就会以...的形式省略 
		 * @param ts 文本域
		 * @param s 字符串
		 * @param maxW 最大宽度
		 * 
		 */		
		public static function fitText(ts:TextField, s:String, maxW:Number):void {
			const tf:TextField = ts;
			var len:int = s.length;
			ts.text = s;
			var tm:TextLineMetrics = tf.getLineMetrics(0);
			while (len > 0 && tm.width > maxW) {
				len = len - 2; 
				s = s.substr(0, len);
				ts.text = s + "…";
				tm = tf.getLineMetrics(0);
			}
			if (len <= 0) {
				ts.text = "";
			}
		}
		
		private static var text:TextField;
		private static var textformat:TextFormat;
		public static function getTextWidth(s:String,fontSize:int=12,fontBold:Boolean=false):Number{
			if(text == null){
				text = new TextField();
				textformat = new TextFormat();
			}
			textformat.size = fontSize;
			textformat.bold = fontBold;
			text.defaultTextFormat = textformat;
			text.text = s;
			return text.textWidth;
		}
		
		private static var text1:TextField;
		public static function getCharPosition(html:String,char:String,width:Number=180):Point{
			if(text1 == null){
				text1 = new TextField();
				text1.wordWrap = true;
				text1.multiline = true;
			}
			text1.width = width;
			text1.htmlText = html;
			var index:int = text1.text.indexOf(char);
			var pt:Point = new Point(0,0)
			if(index !=- 1){
				var rect:Rectangle = text1.getCharBoundaries(index);
				pt.x = rect.x;
				pt.y = rect.y;
			}
			return pt;
		}
	}
}