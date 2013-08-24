package facebook
{
	import com.facebook.graph.Facebook;
	
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import UI.Button;

	public class ReceivedRequest extends Sprite
	{
		private var url:String;
		private var facebook_object:String;
		
		private var but1:Button;
		private var but2:Button;
		private var but3:Button;
		
		private var _request_id:String;
		
		public function ReceivedRequest(request_id:String, uid:String, access_token:String, i:int)
		{
			_request_id = request_id;
			
			facebook_object = request_id + "_" + uid + "?access_token=" + access_token;
			url = "https://graph.facebook.com/" + facebook_object;
			
			but1 = new Button(100, 20);
			but1.x = 0;
			but1.y = i*80 + 40;
			but1.setText(request_id);
			but1.addEventListener(MouseEvent.CLICK, onClicked);
			addChild(but1);
			
			but3 = new Button(100, 20);
			but3.x = 0;
			but3.y = i*80 + 60;
			but3.setText("Delete");
			but3.addEventListener(MouseEvent.CLICK, onClickedDelete);
			addChild(but3);
			
			but2 = new Button(580, 80);
			but2.x = 110;
			but2.y = i*80;
			addChild(but2);
			
		}

		private function onClickedDelete(e:MouseEvent):void
		{
			but3.removeEventListener(MouseEvent.CLICK, onClickedDelete);

			Facebook.deleteObject(facebook_object, onDeleted);
		}
		
		private function onDeleted(response:*, extra:*):void
		{
			if (response == true)
			{
				but2.setText("Deleted!");
			}
			else
			{
				but2.setText("Error Deleting!");
			}
		}
		
		private function onClicked(e:MouseEvent):void
		{
			but1.removeEventListener(MouseEvent.CLICK, onClicked);
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.addEventListener(ErrorEvent.ERROR, onError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			//loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			//ExternalInterface.call("showtext", url);
			loader.load(new URLRequest(url));
		}
		
		private function onLoaded(e:Event):void
		{
			//ExternalInterface.call("showtext", e.target.data);
			var rex:RegExp = /[\s\r\n]*/gim;
			but2.setText(e.target.data.replace(rex, ""));
		}
		
		private function onError(e:ErrorEvent):void
		{
			//ExternalInterface.call("showtext", "Error loading!");
			but2.setText("Error Loading!");
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			//ExternalInterface.call("showtext", "IO Error loading!");
			but2.setText("IO Error Loading!");
		}
		
	}
}