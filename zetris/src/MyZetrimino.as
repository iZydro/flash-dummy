package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class MyZetrimino
	{
		private var tick:int = 1000;
		private var fasttick:int = 50;
		private var firsttick:int = -400;
		
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
					[1,0,0],
					[1,1,0],
					[0,1,0],
				]
				,
				[
					[0,1,1],
					[1,1,0],
					[0,0,0],
				]
				,
				[
					[1,0,0],
					[1,1,0],
					[0,1,0],
				]
				,
				[
					[0,1,1],
					[1,1,0],
					[0,0,0],
				]
			]
			;
		
		private var shape3:Array =
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
		
		private var shape4:Array =
			[
				[
					[1,0,0],
					[1,0,0],
					[1,1,0],
				]
				,
				[
					[1,1,1],
					[1,0,0],
					[0,0,0],
				]
				,
				[
					[1,1,0],
					[0,1,0],
					[0,1,0],
				]
				,
				[
					[0,0,1],
					[1,1,1],
					[0,0,0],
				]
			]
			;
		
		private var shape5:Array =
			[
				[
					[1,1,0],
					[1,1,0],
					[0,0,0],
				]
				,
				[
					[1,1,0],
					[1,1,0],
					[0,0,0],
				]
				,
				[
					[1,1,0],
					[1,1,0],
					[0,0,0],
				]
				,
				[
					[1,1,0],
					[1,1,0],
					[0,0,0],
				]
			]
			;
		
		private var shape6:Array =
			[
				[
					[1,1,1,1],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
				]
				,
				[
					[1,1,1,1],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
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
			shapes.push(shape3);
			shapes.push(shape4);
			shapes.push(shape5);
			shapes.push(shape6);
			
			shapeTile = shapes[Math.floor(Math.random()*(shapes.length))];
			frame = 0; // Math.floor(Math.random()*(shapeTile.length));
			shape = shapeTile[frame];
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					var imgContainer1:Sprite = new Sprite();
					imgContainer1.graphics.beginFill(0x0000ff);
					imgContainer1.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 20);
					imgContainer1.graphics.endFill();
					imgContainer1.x = x * MyApplication.ZT_TILES_SIZE + 50;
					imgContainer1.y = y * MyApplication.ZT_TILES_SIZE + 50;
					sprites.push(imgContainer1);
					
					// Add the Sprite to the board's current Tetrimino sprites list
					board.addTile(imgContainer1);

				}
			}
			
			timer = firsttick;
			
			posx = MyApplication.ZT_TILES_X / 2 - 1;
			posy = -1;
			
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
					panel.rawChildren.removeChild(imgContainer1);
					
					/*imgContainer1.graphics.beginFill(0x000000);
					imgContainer1.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 20);
					imgContainer1.graphics.endFill();*/
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

					if ((posy+y) >= 0)
					{
						if (shape[y][x] == 1)
						{
							// Pieza
							spr.x = (posx + x) * MyApplication.ZT_TILES_SIZE + 50;
							spr.y = (posy + y) * MyApplication.ZT_TILES_SIZE + 50;
	
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
		}
		
		public function move(board:MyBoard, elapsed:int, keyboard:MyKeyboard /*leftPressed:Boolean, rightPressed:Boolean, upPressed:Boolean, downPressed:Boolean, downReleased:Boolean*/):Boolean
		{
			var VALID:Boolean = false;
			var INVALID:Boolean = true;
			
			timer += elapsed;
			
			var oldx:int = posx;
			var oldy:int = posy;
			
			if(keyboard.left.triggered || keyboard.left.repeated) posx--;
			if(keyboard.right.triggered || keyboard.right.repeated) posx++;
			
			if(keyboard.up.triggered)
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
			
			// Control of down key. Not based on key repeat, instead on timer and pressed
			
			// If dow key is pressed, skip longer wait for first frame
			if (keyboard.down.triggered || keyboard.down.pressed)
			{
				if (timer < 0) timer = fasttick;
			}
			
			// Select tick time
			var thistick:int = (keyboard.down.triggered || keyboard.down.pressed) ? fasttick : tick;
			
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
					/*if ((y+posy) < 0)
					{
					}
					else*/
					{
						if (shape[y][x] == 1)
						{
							if ( (x+posx) < 0 || (x+posx >= MyApplication.ZT_TILES_X) ) return false;
							if ( /*(y+posy) < 0 ||*/ (y+posy >= MyApplication.ZT_TILES_Y) ) return false;
							
							if (board.getZininoAt(y+posy, x+posx) == 2) return false;
						}
					}
				}
			}
			
			return true;
		}

		public function consolidate(board:MyBoard):void
		{
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					if (y+posy >= 0)
					{
						if (shape[y][x] == 1)
						{
							var sp:Sprite = new Sprite();//board.getZininoImageAt(y+posy, x+posx);
							
							
							var bm:Bitmap;
							
							// Create class
							var mbm:MyBitmap = new MyBitmap();
							
							// Create bitmap data to be copied
							//var mybmd:BitmapData = mbm.createBitmapData(bsBase.width, bsBase.height, bsBase);
							var mybmd:BitmapData = mbm.createBitmapData(MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, MyApplication.sp);
							
							// Fetch bitmap data to bitmap
							bm = mbm.createBitmap();
							bm.x = 0;//size_tile >> 1;
							bm.y = 0;//size_tile >> 1;
							
							// And add it to the Sprite holder
							sp.addChild(bm);
							
							
							sp.visible = true;
	/*						
							sp.graphics.beginFill(0xff0000);
							sp.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 32);
							sp.graphics.endFill();
	*/						
							sp.x =  (x+posx) * MyApplication.ZT_TILES_SIZE + 50;
							sp.y =  (y+posy) * MyApplication.ZT_TILES_SIZE + 50;
							
							// Create the MyZydroSprite
							var myz:MyZydroSprite = new MyZydroSprite(sp);
							myz.setX( (x+posx) * MyApplication.ZT_TILES_SIZE + 50);
							myz.setY( (y+posy) * MyApplication.ZT_TILES_SIZE + 50);
							//myz.update();
							
							// Set the new image
							
							var sp_behind:MyZydroSprite = board.getZininoImageAt(y+posy, x+posx);
							if (sp_behind == null)
							{
								// There was a Zinino there already
								board.setZininoImageAt(y+posy, x+posx, myz);
								board.boardPanel.rawChildren.addChild(myz.getSprite());
								
								// Set the logical piece
								board.setZininoAt(y+posy, x+posx, 2);
							}
						}
					}
				}
			}
		}
		
	}
}
