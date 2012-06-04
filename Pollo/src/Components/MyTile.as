package Components
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	
    import spark.components.Application;
    import spark.core.SpriteVisualElement;
    
	import mx.containers.Canvas;

    import mx.controls.*;


	public class MyTile extends SpriteVisualElement
	{
        private var url:String = "http://www.isidrogilabert.com/img/isidro.png";
        
        private var ptRotationPoint:Point;
        
		private var dx:int = 1; 
		private var dy:int = 1; 
        
		private var state:int = 0;
		private var count:int = 0;
        
        public function MyTile(myURL:String = "")
        {
            var loader:Loader = new Loader();
            configureListeners(loader.contentLoaderInfo);
            loader.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);

            var request:URLRequest = new URLRequest(url);
			
			if (myURL.length != 0)
			{
				request = new URLRequest(myURL); 
			}
			
            loader.load(request);

            addChild(loader);

			var r1 : int = Math.floor( Math.random() * 500 );
			var r2 : int = Math.floor( Math.random() * 500 );
			top = r1;
			left = r2;
			
			state = 0;
			count = 0;
			
			//transform.matrix = new Matrix(1, 0, 0, 1, width>>1, height>>1);
        }

	    public function move():void
	    {
	    	if (state == 0)
	    	{
		        top = top + 4*dy;
		        left = left + 4*dx;
		        
		        if (left < 0) dx = 1;
		        if (top < 0) dy = 1;
		        if (left > 800) dx = -1;
		        if (top > 500) dy = -1;
	    	}
	    	
	    	if (state == 1)
	    	{
	    		count += 10;
	    		//scaleX = 1 + (count % 10) / 10;
	    		//scaleY = 1 + (count % 10) / 10;

	    		//rotation = count;
	    		//scaleX = 1 + (count % 50) / 50;
	    		//ptRotationPoint = new Point(top + width/2, left + height/2);
	    		//scaleFromCenter(this, 1.01, 1.01, ptRotationPoint);
	    		
	    		if (count == 10)
	    		{
	    			 var clip:Sprite = this;
					 var tx:Number = clip.x;
					 var ty:Number = clip.y;
					 var m:Matrix = clip.transform.matrix;
					 m.translate( -tx, -ty );
					 m.rotate(45*Math.PI/180);
					 m.translate( tx, ty );
					 //m.scale( 2, 2);
					 clip.transform.matrix = m;
	    		}
	    			    			    		
	    		if (count >= 360)
	    		{
					var r1 : int = Math.floor( Math.random() * 500 );
					var r2 : int = Math.floor( Math.random() * 500 );
					top = r1;
					left = r2;
	    			state = 0;
	    			count = 0;
	    			rotation = 0;
	    			scaleX = 1;
	    			scaleY = 1;
		    		//scaleFromCenter(this, 1, 1, ptRotationPoint);
	    		}
	    	}
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

    		ptRotationPoint = new Point(x + width/2, y + height/2);
            
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
            /*else
            {
	            var r1 : int = Math.floor( Math.random() * 500 );
				var r2 : int = Math.floor( Math.random() * 500 );
				top = r1;
				left = r2;
            }*/
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