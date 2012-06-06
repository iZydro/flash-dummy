package 
{
    import flash.display.*;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.URLRequest;
    
    import mx.containers.Canvas;
    import mx.controls.*;
    
    //import spark.components.Application;
    //import spark.core.SpriteVisualElement;


	public class MyTile extends Sprite/*VisualElement*/
	{
        private var url:String = "http://www.isidrogilabert.com/img/isidro.png";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/bit2010.jpg";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/ronaldo.jpg";
		//private var url:String = "http://www.isidrogilabert.com/img/photos/newfrontier.jpg";
		
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
		
		private var loader:Loader;
		
		private var localScore:int = 0;
        
        public function MyTile(myURL:String = "")
        {
			visible = false;
			
            loader = new Loader();
            configureListeners(loader.contentLoaderInfo);
            loader.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);

            var request:URLRequest = new URLRequest(url);
			
			if (myURL.length != 0)
			{
				request = new URLRequest(myURL); 
			}
			
            loader.load(request);

            addChild(loader);

			//transform.matrix = new Matrix(1, 0, 0, 1, width>>1, height>>1);
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
				loader.transform.matrix = new Matrix(1, 0, 0, 1, -loader.width>>1, -loader.height>>1);
				isMoving = true;
				
				import flash.display.BitmapData;
				import flash.display.Bitmap;
				var bd2:BitmapData=new BitmapData(160,200,true,0xFF00FFFF);
				var mat:Matrix=new Matrix();
				//mat.rotate(-45);
				//mat.scale(0.6,0.6);
				mat.translate(width>>1,height>>1);
				bd2.draw(this,mat);
				//bd2.draw(this);
				var bitmap2:Bitmap=new Bitmap(bd2);
				bitmap2.x=70;
				bitmap2.y=160;
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

				var oldtop:int  = y;
				var oldleft:int = x;
				
		        y = y + dy*sy*50 * (elapsed/1000);
		        x = x + dx*sx*50 * (elapsed/1000);
		        
				//y = y + 0*sy * (elapsed/1000);
				//x = x + 200*sy * (elapsed/1000);
				
		        if ( x < (loader.width>>1)  )                   { sx = 1;  x = oldleft; }
		        if ( y < (loader.height>>1) )                   { sy = 1;  y = oldtop;  }
		        if ( x > (parent.width - (loader.width>>1)) )   { sx = -1; x = oldleft; }
		        if ( y > (parent.height - (loader.height>>1)) ) { sy = -1; y = oldtop;  }

			}
	    	
	    	if (state == 1)
	    	{
	    		count += 10;
				
	    		rotation = count;
	    		scaleX = 1 - (count % 360) / 360;
				scaleY = 1 - (count % 360) / 360;
	    		if (count >= 360)
	    		{
					initObject();
					localScore += 1;
	    		}
	    	}
			
			return null;
	    }

		private function initObject():void
		{
			var r1 : int = Math.floor( Math.random() * (parent.height - loader.height) + (loader.height>>1) );
			var r2 : int = Math.floor( Math.random() * (parent.width - loader.width)   + (loader.width>>1)  );
			y = r1;
			x = r2;
			
			state = 0;
			count = 0;
			
			rotation = 0;
			scaleX = 1;
			scaleY = 1;
			
			visible = true;

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
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
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
        
		private static function rotateImage(image:Sprite, degrees:Number):void
		{
			// Calculate rotation and offsets
			var radians:Number = degrees * (Math.PI / 180.0);
			var offsetWidth:Number = image.width/2;//contentWidth/2.0;
			var offsetHeight:Number =  image.height/2;//contentHeight/2.0;
		
			// Perform rotation
			var matrix:Matrix = new Matrix();
			matrix.translate(-offsetWidth, -offsetHeight);
			matrix.rotate(radians);
			matrix.translate(+offsetWidth, +offsetHeight);
			matrix.concat(image.transform.matrix);
			image.transform.matrix = matrix;
		}        
		
		private function scaleFromCenter(ob:*, sx:Number, sy:Number, ptScalePoint:Point):void
		{ 
			var m:Matrix=ob.transform.matrix;
			m.tx -= ptScalePoint.x;
			m.ty -= ptScalePoint.y;
			m.scale(sx, sy);
			m.tx += ptScalePoint.x;
			m.ty += ptScalePoint.y;
			ob.transform.matrix = m;
		}
		
		public static function scaleAroundPoint(objToScale:DisplayObject, regX:int, regY:int, scaleX:Number, scaleY:Number):void
		{
            if (!objToScale)
            {
                return;
            }
            
            var transformedVector:Point = new Point( (regX-objToScale.x)*scaleX, (regY-objToScale.y)*scaleY );
            
            objToScale.x = regX-( transformedVector.x);
            objToScale.y = regY-( transformedVector.y);
            objToScale.scaleX =  objToScale.scaleX*(scaleX);
            objToScale.scaleY =  objToScale.scaleY*(scaleY);
		}		
    }
}