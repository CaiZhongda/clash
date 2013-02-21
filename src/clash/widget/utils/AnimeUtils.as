package clash.widget.utils{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class AnimeUtils{
		public static function tweenItem(obj:DisplayObject,tar:DisplayObjectContainer,x:int,y:int,width:int,height:int,tarXOff:int,tarYOff:int):void{
			var a:Anime=new Anime();
			a.obj=obj;
			a.tar=tar;
			a.x=x;
			a.y=y;
			a.width=width;
			a.height=height;
			a.tarXOff=tarXOff;
			a.tarYOff=tarYOff;
			a.start();
		}
	}
}
import clash.gs.TweenMax;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

class Anime{
	private var bm:Bitmap;
	private var matrix:Matrix;
	private var rect:Rectangle;
	public var obj:DisplayObject;
	public var tar:DisplayObjectContainer;
	public var width:int;
	public var height:int;
	public var x:int;
	public var y:int;
	public var tarXOff:int;
	public var tarYOff:int;
	public function start():void{
		var startPoint:Point=tar.globalToLocal(obj.localToGlobal(new Point(-x,-y)));
		var stopPoint:Point=new Point(tarXOff,tarYOff);
		var bitmapdata:BitmapData=new BitmapData(width,height,true,0x0);
		matrix=new Matrix();
		matrix.translate(x,y);
		rect=new Rectangle();
		rect.width=width;
		rect.height=height;
		bitmapdata.draw(obj,matrix,null,null,rect);
		bm=new Bitmap();
		bm.bitmapData=bitmapdata;
		tar.addChild(bm);
		bm.x=startPoint.x;
		bm.y=startPoint.y;
		TweenMax.to(bm,.8,{"x":stopPoint.x,"y":stopPoint.y,"onComplete":disposeBitmap});
	}
	private function disposeBitmap():void{
		if(tar.contains(bm)){
			tar.removeChild(bm);
		}
		matrix=null;
		rect=null;
		bm.bitmapData=null;
		bm=null;
	}
}