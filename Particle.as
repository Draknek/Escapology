package
{
	public class Particle
	{
		public var x: Number = 0;
		public var y: Number = 0;
		
		public var dx: Number = 0;
		public var dy: Number = 0;
		
		public var age: int = 0;
		
		public var previous: Particle = null;
		public var next: Particle = null;
		
		public static function create (pNext:Particle, x: Number, y: Number): Particle
		{
			var p: Particle;
			
			if (recycleFirst) {
				p = recycleFirst;
				recycleFirst = p.next;
				//p.next = null;
			} else {
				p = new Particle;
			}
			
			p.next = pNext;
			p.previous = null;
			
			if (pNext) {
				pNext.previous = p;
			}
			
			p.x = x;
			p.y = y;
			p.age = 0;
			
			return p;
		}
		
		public static function recycle (p: Particle): void
		{
			if (p.previous)
				p.previous.next = p.next;
			
			if (p.next)
				p.next.previous = p.previous;
			
			p.next = recycleFirst;
			recycleFirst = p;
			
			p.previous = null;
		}
		
		public static var recycleFirst: Particle = null;
	}
}



