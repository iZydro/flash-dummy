package  /*Components*/
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.TimerEvent;
    import flash.geom.*;
    import flash.net.*;
    import flash.ui.Keyboard;
    import flash.utils.*;
    import flash.utils.Timer;
    
    import mx.containers.Canvas;
    import mx.controls.*;
    import mx.controls.Alert;
    import mx.events.DragEvent;
    import mx.events.FlexEvent;
    import mx.graphics.SolidColor;

	[SWF(width = "1024", height = "768")]
	public class MyApplication extends Canvas
    {
		
		public static var ZT_TILES_X:int = 8;
		public static var ZT_TILES_Y:int = 12;
		public static var ZT_TILES_SIZE:int = 32;
		
		private var isActive:Boolean = false;

		private static var myLoader:Loader;
		private static var canvas:MyCanvas;
		
		private var panel:MyPanel;
		    	
		private static var basiclayout:MyBasicLayout;

		private var tile:MyTile;
    	private var tile1:MyTile;
    	private var tile2:MyTile;
    	
		private var timer:Timer = null;
		private var elapsedTimer:int;
		private var currentTimer:int;
		
		public static const DELAY:Number = 1000 / 30;
		
		private static var myScore:int = 0;
		
		//private var bs1:MyBaseSprite;
		
		private var bs0:Sprite;
		private var bs1:Sprite;
		
		private var tiles:Array = new Array;

		private var ztBoard:Array = new Array;
		private var ztBoardImages:Array = new Array;
		private var ztBoardTiles:Array = new Array;
		
		private var zetri:MyZetrimino;
		
		private var ztColors:Array = [ 0xff0000, 0x00ff00, 0x00ffff ];
		
		private var bsBase:MyBaseSprite;
		
		private var leftPressed:Boolean, rightPressed:Boolean, upPressed:Boolean, downPressed:Boolean, downReleased:Boolean;
		
		private var gameOver:Boolean;
		private var gameOverTimer:int;
		
		public function done():Canvas
		{
			return this;
		}
		
        public function MyApplication()
        {
    	
        	//app = this;

        	//stage.frameRate = FRAMERATE;
        	
			//createMainPanel();
			//addChild(MyApplication.mainPanel)

			x=0;
			y=0;
			panel = new MyPanel();
			this.addChild(panel);

			
			for (var y:int = 0; y < ZT_TILES_Y; y++)
			{
				for (var x:int = 0; x < ZT_TILES_X; x++)
				{
					var imgContainer1:Sprite = new Sprite();
					imgContainer1.graphics.beginFill(0xff0000);
					imgContainer1.graphics.drawRoundRect(0, 0, ZT_TILES_SIZE, ZT_TILES_SIZE, 20);
					imgContainer1.graphics.endFill();
					imgContainer1.x = x*ZT_TILES_SIZE;
					imgContainer1.y = y*ZT_TILES_SIZE;
					
					//imgContainer.addChild(image);
					
					panel.rawChildren.addChild(imgContainer1);
					ztBoard.push(0);
					ztBoardImages.push(imgContainer1);

				}
			}
			
			zetri = new MyZetrimino(ztBoardTiles);
	
			currentTimer = getTimer();

	        timer = new Timer(DELAY);
	        timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();

			addEventListener(FlexEvent.CREATION_COMPLETE, creationHandler);
			
			leftPressed = rightPressed = upPressed = downPressed = false;
			downReleased = true;
			gameOver = false;
		
		}
		
		private function initGame():void
		{
			for (var h:int = 0; h < ztBoardTiles.length; h++)
			{
				if (panel.rawChildren.contains(ztBoardTiles[h]))
				{
					panel.rawChildren.removeChild(ztBoardTiles[h]);
				}
			}
			
			for (var i:int = 0; i < ztBoardImages.length; i++)
			{
				var imgContainer1:Sprite = ztBoardImages[i];
				imgContainer1.graphics.beginFill(0xff0000);
				imgContainer1.graphics.drawRoundRect(0, 0, ZT_TILES_SIZE, ZT_TILES_SIZE, 20);
				imgContainer1.graphics.endFill();
			}
			
			for (var j:int = 0; j < ztBoard.length; j++)
			{
				ztBoard[j] = 0;
			}
			
			zetri = new MyZetrimino(ztBoardTiles);
		}

	    private function onTimerTick(event:TimerEvent):void
	    {
			
			var now:int = getTimer();
			elapsedTimer = now - currentTimer;
			currentTimer = now;
			
			if (gameOver)
			{
				gameOverTimer += elapsedTimer;
				if (gameOverTimer >= 5000)
				{
					initGame();
					gameOver = false;
				}
				else
				{
					return;
				}
			}
			
			var px:int = Math.random() * ZT_TILES_X;
			var py:int = Math.random() * ZT_TILES_Y;
			
			if (ztBoard[py * ZT_TILES_X + px] == 0)
			{
				ztBoard[py * ZT_TILES_X + px] = 1;
				
				var cell:int = ztBoard[py * ZT_TILES_X + px];
				var imgContainer1:Sprite = ztBoardImages[py * ZT_TILES_X + px];
				imgContainer1.graphics.beginFill(0x00ff00);
				imgContainer1.graphics.drawRoundRect(0, 0, ZT_TILES_SIZE, ZT_TILES_SIZE, 20);
				imgContainer1.graphics.endFill();
			}
			
			zetri.paint(panel);
			
			var done:Boolean = zetri.move(ztBoard, elapsedTimer, leftPressed, rightPressed, upPressed, downPressed, downReleased);
			if (done)
			{
				zetri.consolidate(ztBoard);
				zetri.unpaint(panel);
				zetri = null;
				
				zetri = new MyZetrimino(ztBoardTiles);
				
				if (!zetri.checkGoodPos(ztBoard))
				{
					// GAME OVER!
					zetri.consolidate(ztBoard);
					zetri.paint(panel);
					zetri.unpaint(panel);
					zetri = null;
					gameOver = true;
					gameOverTimer = 0;
				}
			
				downReleased = false;
			}
			
			leftPressed = rightPressed = upPressed = downPressed = false;
			
			return;
			
	    	//Alert.show("Timer!");
			if (bsBase.onceLoaded)
			{
				
				var bm:Bitmap;
				
				// Create class
				var mbm:MyBitmap = new MyBitmap();
				
				// Create bitmap data to be copied
				var mybmd:BitmapData = mbm.createBitmapData(bsBase.getWidth(), bsBase.getHeight(), bsBase);
				
				// Fetch bitmap data to bitmap
				bm = mbm.createBitmap();

				// And add it to the Sprite holder
				bs1.addChild(bm);

				bs1.x = 100;
				bs1.y = 300;
				panel.rawChildren.addChild(bs1);
				
				
				// Clone old bitmap data
				var mybmd2:BitmapData = mybmd.clone();

				// Add few changes to it			
				mybmd2.setPixel(43,10, 0xff00ff00);
				mybmd2.fillRect(new Rectangle(64, 64, 10, 10), 0xff0000ff);
				
				// And create a new Bitmap
				var bm1:Bitmap = new Bitmap(mybmd2);
				
				bm1.rotation = 0;
				bm1.x = 0;
				bm1.y = 0;
				bm1.transform.matrix = new Matrix(1, 0, 0, 1, -bm1.width>>1, -bm1.height>>1);

				// And add it to the Sprite holder
				bs0.addChild(bm1);
				bs0.x = 0;
				bs0.y = 0;
				//bs0.transform.matrix = new Matrix(1, 0, 0, 1, -mybmd2.width>>1, -mybmd2.height>>1);

				panel.rawChildren.addChild(bs0);
				
				for (var i:int = 0; i < 20; i++)
				{
					var _sp:Sprite = new Sprite();
					var _bm:Bitmap = new Bitmap(mybmd2);
					_bm.transform.matrix = new Matrix(1, 0, 0, 1, -_bm.width>>1, -_bm.height>>1);
					_sp.addChild(_bm);
					_sp.x = 0;//i*30;
					_sp.y = 0;//i*25;
					_sp.rotation = (i*18) % 360;
					
					var mt:MyTile = new MyTile();
					mt.createFromSprite(_sp);
					panel.rawChildren.addChild(mt.tile);
					
					//panel.rawChildren.addChild(_sp);
					
					tiles.push(mt);
				}
				
				bsBase.onceLoaded = false;
			}
			
			
			if (isActive)
			{
				bs0.rotation += 10;
				bs0.rotation %= 360;
				
				var caca:Bitmap;
				caca = tile.move(elapsedTimer);
		    	if (caca != null)
				{
					canvas.rawChildren.addChild(caca);
				}
		    	
				var b1:Bitmap = tile1.move(elapsedTimer);
				
				
		    	tile2.move(elapsedTimer);
				
				
				for(var cnt:int = 0; cnt < tiles.length; cnt++)
				{
					//trace(i+". Posicion: "+nombrearray[i]);
					tiles[cnt].move(elapsedTimer);
				}
				
				
				
				panel.setTitle("Papás:" + tile.getScore() + " Tenis: "+ tile1.getScore() + " Yummy: " + tile2.getScore() + " Elapsed: " + elapsedTimer);
			}
	    	
	    }
		
		public function addScore(score:int):void
		{
			myScore += score;	
		}

		public function onProgressStatus(e:ProgressEvent):void
		{   
		      // this is where progress will be monitored     
		      //trace(e.bytesLoaded, e.bytesTotal); 
		}
		
		public function onLoaderReady(e:Event):void
		{     
		      // the image is now loaded, so let's add it to the display tree!     
		      MyApplication.canvas.rawChildren.addChild(myLoader);
		}			
		

        private function creationHandler(e:FlexEvent):void
        {
			trace("Create button");
			isActive = true;
            var button : Button = new Button();
            button.label = "My favorite button";
            button.styleName="halo"
			button.x = panel.width>>1;
			button.y = panel.height>>1;
            button.addEventListener(MouseEvent.CLICK, handleClick);
            /*panel.rawChildren.*/addChild( button );
        }

		public function addedApp():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
		}
		
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }
		
		private function keyPressedUp(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			
			switch (key)
			{
				case Keyboard.DOWN:
					downReleased = true;
					break;
			}
			
		}
			
		private function keyPressedDown(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
		
			switch (key)
			{
				case Keyboard.LEFT :
					leftPressed = true;
					break;
				case Keyboard.RIGHT :
					rightPressed = true;
					break;
				case Keyboard.UP :
					upPressed = true;
					break;
				case Keyboard.DOWN :
					downPressed = true;
					break;
			}
		}
        
    }
}
