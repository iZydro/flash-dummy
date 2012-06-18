package
{
	import mx.containers.Panel;

	public class GameOver
	{
		private var timer:int;
		
		public function GameOver()
		{
			timer = 0;
		}
		
		public function process(elapsedTime:int, panel:Panel, board:MyBoard):Boolean
		{
			board.deleteOneTile(panel);
			/*if (tiles.length > 0)
			{
				if (panel.rawChildren.contains(tiles[0]))
				{
					panel.rawChildren.removeChild(tiles[0]);
				}
				delete tiles[0];
				tiles.splice(0, 1);				
			}*/
			
			timer += elapsedTime;
			if (timer >= 5000)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
	}
}