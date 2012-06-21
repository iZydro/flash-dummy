package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.containers.*;
	import mx.controls.*;

	public class MyBoard
	{
		private var ztBoard:Array = new Array;
		private var ztBoardBackgroundImages:Array = new Array;
		private var ztBoardImagesZinino:Array = new Array;
		
		private var ztBoardTiles:Array = new Array;
		
		public var boardPanel:Panel;

		private var size_x:int;
		private var size_y:int;
		private var size_tile:int;
		
		public function MyBoard(given_y:int, given_x:int, given_tile:int, panel:Panel, bsBase:Sprite)
		{
			size_x = given_x;
			size_y = given_y;
			size_tile = given_tile;
			boardPanel = panel;
			
			for (var y:int = 0; y < size_y; y++)
			{
				for (var x:int = 0; x < size_x; x++)
				{
					// Save the Zinino code
					ztBoard.push(0);
					
					// Create a sprite for each cell of the board (background)
					var imgContainer1:Sprite = new Sprite();
/*					
					var bm:Bitmap;
					
					// Create class
					var mbm:MyBitmap = new MyBitmap();
					
					// Create bitmap data to be copied
					//var mybmd:BitmapData = mbm.createBitmapData(bsBase.width, bsBase.height, bsBase);
					var mybmd:BitmapData = mbm.createBitmapData(size_tile, size_tile, bsBase);
					
					// Fetch bitmap data to bitmap
					bm = mbm.createBitmap();
					bm.x = 0;//size_tile >> 1;
					bm.y = 0;//size_tile >> 1;
					
					// And add it to the Sprite holder
					imgContainer1.addChild(bm);
*/					
					// Draw a standard shape on the sprite
					imgContainer1.graphics.beginFill(0xff0000);
					imgContainer1.graphics.drawRoundRect(0, 0, size_tile, size_tile, 20);
					imgContainer1.graphics.endFill();
					
					// Place it at its x and y position
					imgContainer1.x = x*size_tile + 50;
					imgContainer1.y = y*size_tile + 50;
					
					// Add it to the panel
					panel.rawChildren.addChild(imgContainer1);
					
					// And save the Sprite for further access 
					ztBoardBackgroundImages.push(imgContainer1);
					ztBoardImagesZinino.push(null);
/*					
					var imgContainer2:Sprite = new Sprite();
					
					// Draw a standard shape on the sprite
					imgContainer2.graphics.beginFill(0xffffff);
					imgContainer2.graphics.drawRoundRect(0, 0, size_tile, size_tile, 32);
					imgContainer2.graphics.endFill();
					
					// Place it at its x and y position
					imgContainer2.x = x*size_tile + 50;
					imgContainer2.y = y*size_tile + 50;
					
					// Add it to the panel
					imgContainer2.visible = false;
					panel.rawChildren.addChild(imgContainer2);
					
					// And save the Sprite for further access 
					ztBoardImagesZinino.push(imgContainer2);
*/					
				}
			}
		
		}
		
		public function addTile(spr:Sprite):void
		{
			ztBoardTiles.push(spr);			
		}
		
		public function deleteOneTile(panel:Panel):void
		{
			if (ztBoardTiles.length > 0)
			{
				if (panel.rawChildren.contains(ztBoardTiles[0]))
				{
					panel.rawChildren.removeChild(ztBoardTiles[0]);
				}
				delete ztBoardTiles[0];
				ztBoardTiles.splice(0, 1);				
			}
		}
		
		public function getNumTiles():int
		{
			return ztBoardTiles.length;	
		}

		public function getZininoImageAt(y:int, x:int):MyZydroSprite
		{
			var imgContainer1:MyZydroSprite = ztBoardImagesZinino[y * size_x + x];
			return imgContainer1;
		}
		
		public function setZininoImageAt(y:int, x:int, sp:MyZydroSprite):void
		{
			ztBoardImagesZinino[y * size_x + x] = sp;
		}
		
		public function getZininoAt(y:int, x:int):int
		{
			var zinino:int = ztBoard[y * size_x + x];
			return zinino;
		}
		
		public function setZininoAt(y:int, x:int, zinino:int):void
		{
			ztBoard[y * size_x + x] = zinino;
		}
		
		public function deleteZininos():void
		{
			for (var j:int = 0; j < ztBoard.length; j++)
			{
				ztBoard[j] = 0;
			}
		}
		
		public function deleteBoardImages():void
		{
			for (var i:int = 0; i < ztBoardBackgroundImages.length; i++)
			{
				var imgContainer1:Sprite = ztBoardBackgroundImages[i];
				imgContainer1.graphics.beginFill(0xff0000);
				imgContainer1.graphics.drawRoundRect(0, 0, size_tile, size_tile, 20);
				imgContainer1.graphics.endFill();
								
				var myz:MyZydroSprite = ztBoardImagesZinino[i];
				if (myz != null)
				{
					var imgContainer2:Sprite = myz.getSprite();
					if (imgContainer2 != null)
					{
						imgContainer2.visible = false;
						imgContainer2.graphics.beginFill(0xffffff);
						imgContainer2.graphics.drawRoundRect(0, 0, size_tile, size_tile, 32);
						imgContainer2.graphics.endFill();
						boardPanel.rawChildren.removeChild(imgContainer2);
						imgContainer2 = null;
					}
					ztBoardImagesZinino[i] = null;
				}
			}
		}
		
		public function updateZetriminos():void
		{
			for (var i:int = 0; i < ztBoardImagesZinino.length; i++)
			{
				var myz:MyZydroSprite = ztBoardImagesZinino[i];
				if (myz)
				{
					myz.update();
				}
			}			
			
		}
		
		public function checkCompleteLines():void
		{
			var y:int = size_y-1; // We start from the bottom line
			while (y >= 0)
			{
				var complete:Boolean = true;
				for (var x:int = 0; x < size_x; x++)
				{
					if (getZininoAt(y, x) != 2) complete = false; 
				}
				
				if (complete)
				{
					// Clear the line
					for (var cx:int = 0; cx < size_x; cx++)
					{
						// Clear the complete line
						setZininoAt(y, cx, 0);
						var sp2clear:Sprite = getZininoImageAt(y, cx).getSprite();
						boardPanel.rawChildren.removeChild(sp2clear);
						setZininoImageAt(y, cx, null);
						
/*						
						var sp:Sprite = getZininoImageAt(y, cx);
						sp.visible = false;
						sp.graphics.beginFill(0xffffff);
						sp.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 32);
						sp.graphics.endFill();
*/						
						
					}
					
					// Move down all the zininos up to this line
					for (var my:int = y-1; my >= -1; my--)
					{
						for (var mx:int = 0; mx < size_x; mx++)
						{
							setZininoAt(my+1, mx, my < 0 ? 0 : getZininoAt(my, mx));
							
							//var tile:int = my < 0 ? 0 : getZininoAt(my, mx);
							
							var sp:MyZydroSprite = getZininoImageAt(my, mx);
							if (sp != null)
							{
								sp.setNewY(sp.getNewY() + MyApplication.ZT_TILES_SIZE);
								//sp.update();
							}
							setZininoImageAt(my+1, mx, sp);
							setZininoImageAt(my, mx, null);
							
							
/*							
							var sp1:Sprite = getZininoImageAt(my+1, mx);
							sp1.visible = (tile == 2);
							sp1.graphics.beginFill(tile == 2 ? 0x0 : 0xffffff);
							sp1.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 32);
							sp1.graphics.endFill();
*/							

							/*var sp2:Sprite = getZininoImageAt(my+1, mx);
							sp2.graphics.beginFill(0xffffff);
							sp2.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 32);
							sp2.graphics.endFill();*/
							
						}
					}
				}
				else
				{
					y--;
				}
			}	
		}
	}
}