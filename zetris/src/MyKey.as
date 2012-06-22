package
{
	public class MyKey
	{
		public var triggered:Boolean;
		public var pressed:Boolean;
		public var repeated:Boolean;
		
		private var _triggered:Boolean;
		private var _released:Boolean;
		
		private var timer_delay:int;
		private var timer_rate:int;
		
		private var repeat_delay:int;
		private var repeat_rate:int;
		
		public function MyKey()
		{
			clear();
			repeat_delay = 300;
			repeat_rate = 100;
		}
		
		public function clear():void
		{
			triggered = pressed = repeated = false;
			
			_triggered = false;
			_released = true;
			
			timer_delay = 0;
			timer_rate = 0;
		}
		
		public function force_release():void
		{
			_released = false;
		}
		
		public function setRepeatDelay(val:int):void
		{
			repeat_delay = val;
		}
		
		public function setRepeatRate(val:int):void
		{
			repeat_rate = val;
		}
		
		public function process(elapsed:int):void
		{
			triggered = _triggered;
			_triggered = false;
			
			if (pressed)
			{
				if (timer_delay < repeat_delay)
				{
					timer_delay += elapsed;
					return;
				}
				
				if (timer_rate < repeat_rate)
				{
					timer_rate += elapsed;
					repeated = true;
				}
				else
				{
					timer_rate -= elapsed;
					repeated = false;
				}
			}
		}
		
		public function pressedDown():void
		{
			if (!_released) return;
			
			if (!pressed)
			{
				_triggered = true;
				timer_delay = 0;
				timer_rate = 0;
			}
			pressed = true;
		}
		
		public function pressedUp():void
		{
			_released = true;
			
			pressed = false;
			repeated = false;
		}
		
	}
}