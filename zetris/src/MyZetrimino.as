package
{
	import flash.display.Sprite;
	
	public class MyZetrimino
	{
		private var tick:int = 1000;
		private var fasttick:int = 50;
		private var firsttick:int = -2000;
		
		private var shape1:Array =
		[
			[
				[0,1,0],
				[1,1,0],
				[1,0,0],
			]
			,
			[
				[1,1,0],
				[0,1,1],
				[0,0,0],
			]
			,
			[
				[0,1,0],
				[1,1,0],
				[1,0,0],
			]
			,
			[
				[1,1,0],
				[0,1,1],
				[0,0,0],
			]
		]
		;
		
		private var shape2:Array =
		[
			[
				[0,1,0],
				[0,1,0],
				[1,1,0],
			]
			,
			[
				[1,0,0],
				[1,1,1],
				[0,0,0],
			]
			,
			[
				[1,1,0],
				[1,0,0],
				[1,0,0],
			]
			,
			[
				[1,1,1],
				[0,0,1],
				[0,0,0],
			]
		]
		;
		
		private var shape:Array;
		private var shapeTile:Array;
		
		private var shapes:Array = new Array;
		
		private var sprites:Array = new Array;
		
		private var posx:int, posy:int;
		private var frame:int;
		
		private var timer:int;
		
		public function MyZetrimino(board:MyBoard)
		{
			
			shapes.push(shape1);
			shapes.push(shape2);
			
			shapeTile = shapes[Math.floor(Math.random()*(shapes.length))];
			frame = Math.floor(Math.random()*(shapeTile.length));
			shape = shapeTile[frame];
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					var imgContainer1:Sprite = new Sprite();
					imgContainer1.graphics.beginFill(0x0000ff);
					imgContainer1.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 20);
					imgContainer1.graphics.endFill();
					imgContainer1.x = x * MyApplication.ZT_TILES_SIZE;
					imgContainer1.y = y * MyApplication.ZT_TILES_SIZE;
					sprites.push(imgContainer1);
					
					// Add the Sprite to the board's sprites list
					board.addTile(imgContainer1);

				}
			}
			
			timer = firsttick;
			
			posx = MyApplication.ZT_TILES_X / 2 - 1;
			posy = 0;
			
		}
		
		public function getX():int
		{
			return posx;
		}
		
		public function getY():int
		{
			return posy;
		}
		
		public function getShape():Array
		{
			return shape;			
		}
		
		public function unpaint(panel:MyPanel):void
		{
			for (var i:int = 0; i < sprites.length; i++)
			{
				if (panel.rawChildren.contains(sprites[i]))
				{
					var imgContainer1:Sprite = sprites[i];
					imgContainer1.graphics.beginFill(0x00ffff);
					imgContainer1.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 20);
					imgContainer1.graphics.endFill();
				}
			}
		}
		
		public function paint(panel:MyPanel):void
		{
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					var spr:Sprite = sprites[y*shape[y].length + x];

					if (shape[y][x] == 1)
					{
						// Pieza
						spr.x = (posx + x) * MyApplication.ZT_TILES_SIZE;
						spr.y = (posy + y) * MyApplication.ZT_TILES_SIZE;

						if (!panel.rawChildren.contains(spr))
						{
							panel.rawChildren.addChild(spr);
						}
					}
					else
					{
						// Blanco
						if (panel.rawChildren.contains(spr))
						{
							panel.rawChildren.removeChild(spr);
						}
					}
				}
			}
		}
		
		public function move(board:MyBoard, elapsed:int, leftPressed:Boolean, rightPressed:Boolean, upPressed:Boolean, downPressed:Boolean, downReleased:Boolean):Boolean
		{
			var VALID:Boolean = false;
			var INVALID:Boolean = true;
			
			timer += elapsed;
			
			var oldx:int = posx;
			var oldy:int = posy;
			
			if(leftPressed) posx--;
			if(rightPressed) posx++;
			
			if(upPressed)
			{
				var oldframe:int = frame;
				frame++;
				frame %= shapeTile.length;
				shape = shapeTile[frame];
				if (!checkGoodPos(board))
				{
					// Si no cabe, anulamos el giro
					frame = oldframe;
					shape = shapeTile[frame];
				}
			}
			
			if (downPressed && downReleased)
			{
				if (timer < 0) timer = fasttick;
			}
			
			var thistick:int = (downPressed && downReleased) ? fasttick : tick;
			
			if (timer >= thistick)
			{
				timer -= thistick;
				posy += 1;
			}
			
			var newx:int = posx;
			var newy:int = posy;

			if (oldx == newx && oldy == newy) return false; 
			
			if (checkGoodPos(board))
			{
				return VALID;
			}
			
			// No hay hueco, probamos primero solo Y
			posx = oldx;
			posy = newy;
			if (checkGoodPos(board))
			{
				return VALID;
			}
			else
			{
				if (newy != oldy)
				{
					// Hemos tocado suelo!!!
					posx = oldx;
					posy = oldy;
					return INVALID;
				}
			}
			
			posx = newx;
			posy = oldy;
			if (!checkGoodPos(board))
			{
				// No ha habido manera 
				posx = oldx;
				posy = oldy;
			}

			return VALID;
		}
		
		
		public function checkGoodPos(board:MyBoard):Boolean
		{
			// Comprobamos que ninguna tile del zetrimino está fuera del panel
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					if (shape[y][x] == 1)
					{
						if ( (x+posx) < 0 || (x+posx >= MyApplication.ZT_TILES_X) ) return false;
						if ( (y+posy) < 0 || (y+posy >= MyApplication.ZT_TILES_Y) ) return false;
						
						if (board.getZininoAt(y+posy, x+posx) == 2) return false;
					}
				}
			}
			
			return true;
		}

		public function consolidate(board:MyBoard):void
		{
			// Comprobamos que ninguna tile del zetrimino está fuera del panel
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					if (shape[y][x] == 1)
					{
						board.setZininoAt(y+posy, x+posx, 2); 
					}
				}
			}
		}
		
	}
}
