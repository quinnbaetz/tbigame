package  {
	
	public class TabletLogic {
		
		public var tablet;
		public var tabletContent;
		public var theStage;
		public var scope;

		public function TabletLogic(theStage, scope) {
			this.theStage = theStage;
			this.scope = scope;
			this.tablet = new Tablet();
			this.tabletContent = new TabletContent();
			
		}

	}
	
}
