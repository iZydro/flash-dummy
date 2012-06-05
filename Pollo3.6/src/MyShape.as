package 
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
    //import spark.components.Application;
    //import spark.core.SpriteVisualElement;
    
	import mx.containers.Canvas;


	public class MyShape extends Sprite/*VisualElement*/
	{
		public function MyShape():void
		{
			var child:Sprite/*VisualElement*/ = this; //new SpriteVisualElement();
			child.x = 100;
			child.y = 100;
			child.graphics.beginFill(0xff0000);
			child.graphics.drawRoundRect(0, 0, 100, 100, 20);
			child.graphics.endFill();
			//papa.addChild(child);
		}
		
	}
}