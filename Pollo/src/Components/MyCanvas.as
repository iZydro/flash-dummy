package Components
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
    import mx.containers.*;

	public class MyCanvas extends Canvas
	{
		public function MyCanvas():void
		{
			var child:Canvas = this; //new SpriteVisualElement();
			top = 280;
			left = 480;
			height = 295; 
			width = 295; 
			setStyle("backgroundColor", 0xff00ff);
		}
		
	}
}