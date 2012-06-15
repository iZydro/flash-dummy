package 
{
    import flash.display.*;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.URLRequest;
    
    import mx.containers.Canvas;
    import mx.controls.*;

	public class MyTile /*extends Sprite*/
	{
        private var url:String = "http://www.isidrogilabert.com/img/isidro.png";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/bit2010.jpg";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/ronaldo.jpg";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/newfrontier.jpg";

		private var bd2:BitmapData; // Working bitmapdata
		private var bitmap2:Bitmap; // Working bitmap
		private var bm:MyBitmap;
		
		private var dx:int = 1; 
		private var dy:int = 1;
		
		private var sx:int = 1; 
		private var sy:int = 1;
		
		private var tx:int = 0;
		private var ty:int = 0;
        
		private var state:int = 0;
		private var count:int = 0;
		
		public var isActive:Boolean = false;
		private var isMoving:Boolean = false;
		
		private var loader:Loader = null;
		private var sprite:Sprite = null;
		
		private var theHeight:int = 0;
		private var theWidth:int = 0;
		
		private var localScore:int = 0;
        
		public var tile:Sprite;
		
		public function MyTile()
		{
			tile = new Sprite();
		}
		
        public function createFromURL(myURL:String = ""):void
        {
			tile.visible = false;
			
            loader = new Loader();
            configureListeners(loader.contentLoaderInfo);
            loader.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			//loader.addEventListener(MouseEvent.MOUSE_OVER, clickHandler);

            var request:URLRequest = new URLRequest(url);
			
			if (myURL.length != 0)
			{
				request = new URLRequest(myURL); 
			}
			
            loader.load(request);

            tile.addChild(loader);

			//transform.matrix = new Matrix(1, 0, 0, 1, width>>1, height>>1);
        }
		
		public function createFromSprite(sprite_id:Sprite):void
		{
			sprite = sprite_id;
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			theHeight = sprite.height;
			theWidth  = sprite.width;
			tile.addChild(sprite);
			isActive = true;
		}

		public function getScore():int
		{
			return localScore;
		}
		
	    public function move(elapsed:int):Bitmap
	    {
			if (!isActive) return null;

			if (!isMoving)
			{
				initObject();
				
				if (loader) loader.transform.matrix = new Matrix(1, 0, 0, 1, -theWidth>>1, -theHeight>>1);
				//if (sprite) sprite.transform.matrix = new Matrix(1, 0, 0, 1, -theWidth>>1, -theHeight>>1);
				
				isMoving = true;
				
				//bm = new MyBitmap();
				//bitmap2 = bm.getBitmap(theWidth, theHeight, tile);
				//tile.addChild(bitmap2);
				
				return bitmap2;
			}
			
	    	if (state == 0)
	    	{
				if (tx-- <= 0)
				{
					tx = Math.random() * 10 + 10;
					dx = Math.random() * 4 + 2;
				}

				if (ty-- <= 0)
				{
					ty = Math.random() * 10 + 10;
					dy = Math.random() * 4 + 2;
				}

				var oldtop:int  = tile.y;
				var oldleft:int = tile.x;
				
				tile.y = tile.y + dy*sy*50 * (elapsed/1000);
				tile.x = tile.x + dx*sx*50 * (elapsed/1000);
		        
				//y = y + 0*sy * (elapsed/1000);
				//x = x + 200*sy * (elapsed/1000);
				
		        if ( tile.x < (theWidth>>1)  )                   { sx = 1;  tile.x = oldleft; }
		        if ( tile.y < (theHeight>>1) )                   { sy = 1;  tile.y = oldtop;  }
		        if ( tile.x > (tile.parent.width - (theWidth>>1)) )   { sx = -1; tile.x = oldleft; }
		        if ( tile.y > (tile.parent.height - (theHeight>>1)) ) { sy = -1; tile.y = oldtop;  }

			}
	    	
	    	if (state == 1)
	    	{
	    		count += 10;
				
				tile.rotation = count;
				tile.scaleX = 1 - (count % 360) / 360;
				tile.scaleY = 1 - (count % 360) / 360;
	    		if (count >= 360)
	    		{
					if (loader)
					{
						initObject();
						localScore += 1;
					}
					else
					{
						isActive = false;
						sprite.visible = false;
					}
	    		}
	    	}
			
			return null;
	    }

		private function initObject():void
		{
			var r1 : int = Math.floor( Math.random() * (tile.parent.height - theHeight) + (theHeight>>1) );
			var r2 : int = Math.floor( Math.random() * (tile.parent.width - theWidth)   + (theWidth>>1)  );
			tile.y = r1;
			tile.x = r2;
			
			state = 0;
			count = 0;
			
			tile.rotation = 0;
			tile.scaleX = 1;
			tile.scaleY = 1;
			
			tile.visible = true;

		}
		
        private function configureListeners(dispatcher:IEventDispatcher):void
        {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);

			theHeight = loader.height;
			theWidth = loader.width;
			isActive = true;
			
            //Alert.show("Loaded!");
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
        }

        private function clickHandler(event:MouseEvent):void {
            trace("clickHandler: " + event);
            //var loader:Loader = Loader(event.target);
            //loader.unload();
            
            if (state == 0)
            {
            	// Estaba vivo
            	state = 1;
            }
        }
      
   }
}