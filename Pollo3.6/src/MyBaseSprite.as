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

	//import spark.components.Application;
    //import spark.core.SpriteVisualElement;


	public class MyBaseSprite extends Sprite
	{
        private var url:String = "http://www.isidrogilabert.com/img/isidro.png";
		private var state:int = 0;
		private var count:int = 0;
		
		public var isActive:Boolean = false;
		public var onceLoaded:Boolean = false;
		
		private var loader:Loader;

		/*public function MyBaseSprite2(width:int, height:int):Sprite
		{
			var myself:Sprite = new Sprite();
			
			var circle1:Sprite = new Sprite();
			circle1.graphics.beginFill(0xFFCC00);
			circle1.graphics.drawCircle(40, 40, 40);
			circle1.buttonMode = true;
			circle1.addEventListener(MouseEvent.CLICK, clicked);
			
			var circle2:Sprite = new Sprite();
			circle2.graphics.beginFill(0xFFCC00);
			circle2.graphics.drawCircle(120, 40, 40);
			circle2.buttonMode = false;
			circle2.addEventListener(MouseEvent.CLICK, clicked);
			
			function clicked(event:MouseEvent):void {
				trace ("Click!");
			}
			
			myself.addChild(circle1);
			myself.addChild(circle2);
			
			return myself;
		}*/
		
        public function MyBaseSprite(myURL:String = "")
        {
			visible = false;
			
            loader = new Loader();
            configureListeners(loader.contentLoaderInfo);
            //loader.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			//loader.addEventListener(MouseEvent.MOUSE_OVER, clickHandler);

			var request:URLRequest;
			
			if (myURL.length == 0) myURL = url;
				
			if (myURL.length != 0)
			{
	            request = new URLRequest(myURL);
				
	            loader.load(request);
	
	            addChild(loader);
			}
        }
		
		public function getWidth():int
		{
			return loader.width;
		}

		public function getHeight():int
		{
			return loader.height;
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
            trace("BaseSprite done: " + event);

			loader.transform.matrix = new Matrix(1, 0, 0, 1, -loader.width>>1, -loader.height>>1);
			
			onceLoaded = true;
			
			isActive = true;
			
			visible = true;
			
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
		}
   }
}