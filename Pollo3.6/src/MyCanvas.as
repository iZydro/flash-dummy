package  /*Components*/
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
    import mx.containers.*;
	
	//import spark.layouts.*;

	public class MyCanvas extends Canvas
	{
		public function MyCanvas():void
		{
			//var child:Canvas = this; //new SpriteVisualElement();
			x = 110;
			y = 110;
			height = 195; 
			width = 195; 
			setStyle("backgroundColor", 0x0000ff);
		}
		
	}
}