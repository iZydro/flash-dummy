package UI
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Button extends Sprite
	{
		private var _text:String;
		
		private var textField:TextField;
		private var buttonSprite:Sprite
		
		public function Button(w:int, h:int)
		{
			textField = new TextField();
			textField.name = "textField";
			textField.mouseEnabled = false;
			textField.width = w;
			textField.height = h;
			textField.multiline = true;
			textField.wordWrap = true;
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 12;
			
			textField.defaultTextFormat = myFormat;
			
			var rectangleShape:Shape = new Shape();
			rectangleShape.graphics.beginFill(0xFF0000);
			rectangleShape.graphics.drawRect(0, 0, w, h);
			rectangleShape.graphics.endFill();
			
			buttonSprite = new Sprite();
			buttonSprite.addChild(rectangleShape);
			buttonSprite.addChild(textField);
			addChild(buttonSprite);
		}
		
		public function setText(s:String):void
		{
			var tf:TextField = TextField(buttonSprite.getChildByName("textField"));
			tf.text = s;
		}
	}
}