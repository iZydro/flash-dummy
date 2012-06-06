package
{
	import flash.utils.ByteArray;
	import flash.display.Sprite;
	
	public class SpriteClone extends Sprite
	{
		private var cloneWork:ByteArray;
		
		public function Clone()
		{
			//Constructor
		}
		
		public function doClone(source:Object):Sprite
		{
			cloneWork=new ByteArray();
			cloneWork.writeObject(source);
			cloneWork.position = 0;
			return (cloneWork.readObject());
		}
	}
}