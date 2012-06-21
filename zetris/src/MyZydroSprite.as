package
{
	import flash.display.Sprite;

	public class MyZydroSprite
	{
		private var sprite:Sprite;
		private var x:int, y:int, newx:int, newy:int;
		
		public function MyZydroSprite(sp:Sprite)
		{
			sprite = sp;
		}
		
		public function getSprite():Sprite
		{
			return sprite;
		}
		
		public function setX(value:int):void
		{
			x = value;
			newx = value;
		}
		
		public function setY(value:int):void
		{
			y = value;
			newy = value;
		}
		
		public function getY():int
		{
			return y;
		}
		
		public function getNewY():int
		{
			return newy;
		}
		
		public function setNewX(value:int):void
		{
			newx = value;
		}
		
		public function setNewY(value:int):void
		{
			newy = value;
		}
		
		public function update():void
		{
			var diff:int = newy - y;
			if (diff != 0)
			{
				if (diff > 0)
				{
					diff = diff / 4;
					if (diff < 1) diff = 1;
				}
				else
				{
					diff = diff / 4;
					if (diff > -1) diff = -1;
				}
				y = y + diff;
			}

			sprite.x = x;
			sprite.y = y;
		}
	}
}