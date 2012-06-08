package
{
	import flash.display.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.URLRequest;
	
	import mx.containers.Canvas;
	import mx.controls.*;

	public class MyBitmap /*extends Bitmap*/
	{
		private var bd2:BitmapData; // Working bitmapdata
		private var bitmap2:Bitmap; // Working bitmap
		
		public function MyBitmap():void
		{
		}
		
		public function getBitmap(width:int, height:int, filler:Sprite):Bitmap
		{
			bd2 = new BitmapData(width>>1, height>>1, true, 0xFF00FFFF);
			var mat:Matrix = new Matrix();
			//mat.rotate(-45);
			//mat.scale(0.6,0.6);
			mat.translate(width>>1,height>>1);
			//if (filler != null) bd2.draw(filler,mat);
			
			bd2.setPixel(0, 0, 0xffffff);
			bd2.setPixel(16, 16, 0xff0000);
			
			bitmap2 = new Bitmap(bd2);
			//bitmap2 = this;
			bitmap2.x = -width>>1;
			bitmap2.y = -height>>1;
			
			//addChild(bitmap2);
			
			return bitmap2;
		}
	}
}