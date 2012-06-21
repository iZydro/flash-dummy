package  /*Components*/
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.events.TimerEvent;
    import flash.geom.*;
    import flash.net.*;
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
		
		private var bsBase:MyBaseSprite;
		
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

			var bg:Canvas = new Canvas();
			bg.x = 80;
			bg.y = 80;
			bg.width = 395; 
			bg.height = 295; 
			bg.setStyle("backgroundColor", 0xff00ff);
			panel.rawChildren.addChild(bg);
			
			var shape:MyShape = new MyShape(); 
			panel.rawChildren.addChild(shape);
			
			var image:Image = new Image();
			image.source = "youtube.png";
			image.x = 0;
			image.y = 0;
			
			var imgContainer:Sprite = new Sprite();
			imgContainer.graphics.beginFill(0xff0000);
			imgContainer.graphics.drawRoundRect(0, 0, 100, 100, 20);
			imgContainer.graphics.endFill();
			imgContainer.x = 200;
			imgContainer.y = 200;
			
			//imgContainer.addChild(image);
			
			panel.rawChildren.addChild(imgContainer);
			
			canvas = new MyCanvas();
			panel.rawChildren.addChild(canvas);
			
			tile = new MyTile();
			tile.createFromURL("");
			canvas.rawChildren.addChild(tile.tile);
			
			tile1 = new MyTile();
			tile1.createFromURL("http://www.isidrogilabert.com/flash/tile.png"); 
			panel.rawChildren.addChild(tile1.tile);

			tile2 = new MyTile();
			tile2.createFromURL("http://www.isidrogilabert.com/img/yummy.png"); 
			panel.rawChildren.addChild(tile2.tile);
			
			//bs1 = new MyBaseSprite(80, 80/*"http://www.isidrogilabert.com/img/vttennis.png"*/);
			bs0 = new Sprite();
			bs1 = new Sprite();
			
			bsBase = new MyBaseSprite("http://www.isidrogilabert.com/img/spaceball.png");

			var sp:Sprite = new Sprite();
			sp.x = 50;
			sp.y = 50;
			sp.graphics.beginFill(0xffff00,1);
			sp.graphics.drawRoundRect(10,10,100,100,150,150);
			sp.graphics.endFill();
			panel.rawChildren.addChild(sp);
			
/*			
			myLoader = new Loader();
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
			
			//var fileRequest:URLRequest = new URLRequest("http://www.isidrogilabert.com/img/isidro.png");
			//myLoader.load(fileRequest);
*/
			currentTimer = getTimer();

	        timer = new Timer(DELAY);
	        timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();

			addEventListener(FlexEvent.CREATION_COMPLETE, creationHandler);
        }

	    private function onTimerTick(event:TimerEvent):void
	    {
	    	//Alert.show("Timer!");
			var now:int = getTimer();
			elapsedTimer = now - currentTimer;
			currentTimer = now;
			
			if (/*bs1.onceLoaded &&*/ bsBase.onceLoaded)
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

				panel.rawChildren.addChild(bs0);
				
				for (var i:int = 0; i < 20; i++)
				{
					var _sp:Sprite = new Sprite();
					var _bm:Bitmap = new Bitmap(mybmd2);
					_bm.transform.matrix = new Matrix(1, 0, 0, 1, -_bm.width>>1, -_bm.height>>1);
					_sp.addChild(_bm);
					_sp.x = 0;
					_sp.y = 0;
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
        
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }
        
    }
}
