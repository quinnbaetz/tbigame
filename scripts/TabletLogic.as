package tbigame.scripts {
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TabletLogic extends MovieClip{
		
		/*****************************************
		************    CONSTANTS     ************
		******************************************
		*/
		private static const EMT:String = "Emergency medical technicians (EMT's) are medical professionals" +
		" that are trained to respond to emergency calls. Working as part of ambulance team, search and rescue squad" +
		", or fire department, EMT's are often the first to arrive at the scene of a medical emergency. EMT's are" +
		" trained to quickly assess a patient's condition at the scene of the accident and transport them quickly and" +
		" safely to the nearest medical facility.";
		
		private static const Penlight:String = "This small pen-shaped flashlight is typically used by medical professionals" +
		" to illuminate a patient's throat, nose, and ears, as well as to check the for the response of pupils to bright" +
		" light.";
		
		private static const Stethoscope:String = "Modern stethosscopes are a simple device that enable a medical professional" +
		" to listen to internal body sounds. Acoutsic sethtoscopes, the most common kind, use a plastic disc and hollow" +
		" tubes to carry sound to the listener. More advanced electronic sethoscopes can amplify and record internal body sounds.";
		
		private static const EarTherm:String = "While there are many places that a patient's body temerature can be measured," +
		" some locations are more accurate than others. Because the eardrum is set inside the head, ear thermometers are one" +
		" of the more accurate ways to measure body temerature. Ear thermometers are able to measure the amount of infrared" +
		" radiation (heat energy) given off by the eardrum without touching it.";
		
		private static const BPCuff:String = "Also called a sphygmomanometer, a blood pressure cuff measures the pressure of blood" +
		" flowing through arteries in the body. When gathering information on a patient, two pressures are checked: a systolic" +
		" blood pressure (the pressure of the blood as the heart muscle contracts) and a diastolic pressure (the pressure of the" +
		" blood when the heart is relaxed).";
		
		private static const Gauze:String = "Usually made of cotton, gauze is a type of bandage (or dressing) that is used to" +
		" loosley wrap an injury or to hold other bandages in place. Some modern gauze has a plastic film on one side to prevent" +
		" it from sticking to a wound.";
		
		private static const GCS:String = "The Glasgow Coma Scale of GCS is a type of medical diagnostic developed in 1974" +
		"  at the University of Glasgow. The scale was developed as a way to reliably record the conscious sate of a patient" +
		" who has recieved an injury to the brain. The GCS consits of a scale from 1 to 6 in three areas: Eyes, Verbal, and Motor." +
		" Depending on the score a patient gets in each area, they are classified as having either midle, moderate, or severe brain" +
		" injury.";
		
		private static const MedevacHeli:String = "While motor vehicle ambulances are the most common way medical" +
		" techncicnas reach the scene of an emergency, sometimes accidents can happen where an ambulance would be too slow" +
		" or unable to reach the patient. In these cases medevac (medical evacuation) helicopters are used to gain access" +
		" to the scene of an emergency and transport the patient to the nearest hospital. Medevac helicopters have most of " +
		" the same equipment as a standard ambulance and can travel up to twice as fast. Many hospital emergency rooms have" +
		" a helicopter landing pad on the roof of the building so that patients can be easily loaded on and off a helicopter" +
		" right at the hospital.";
		
		/************************
		**************************************
		***************************************************************
		************************************************************************************************
		*/
		
		//public var tabletContent;
		public var theStage;
		public var scope;
		private var padX = -105;
		private var padY = 420;
		private var padRot = 30;
		private var scale = .4;
		public var pad;
		public var inToolbox;

		public function TabletLogic(theStage, scope, myToolbox) {
			this.theStage = theStage;
			this.scope = scope;
			
			//set parameters for tablet
			this.pad = new Tablet();
			this.pad.x = padX;
			this.pad.y = padY;
			this.pad.scaleX = scale;
			this.pad.scaleY = scale;
			this.pad.rotation = padRot;
			//tabletContent is embedded within the tablet movieClip now
			this.scope.addCache(this.pad, this.theStage);
			this.pad.tabletContent.gotoAndStop("defaultScreen");
			this.pad.tabletContent.SearchInput.addEventListener(MouseEvent.CLICK, prepSearch);
			this.inToolbox = myToolbox;
		}
		
		private function addContentEvtListeners() {
			//listens for user click on search button
			hideResults();
			//don't call hideResults after addLinkLiseners()... or make sure the gotoandstop is called earlier
			addLinkListeners();
			//trace(this.pad.tabletContent.SearchInput);
			this.pad.tabletContent.SearchInput.text = "";
			this.pad.tabletContent.SearchInput.addEventListener(KeyboardEvent.KEY_DOWN, termSearch);
			//reset focus
			this.pad.tabletContent.SearchInput.stage.focus = this.pad.tabletContent.SearchInput;
			this.pad.tabletContent.SearchInput.setSelection(0,0);
			//this.pad.tabletContent.SearchButton.addEventListener(MouseEvent.CLICK, termSearch);
		}
		
		private function prepSearch(event: MouseEvent):void {
			addContentEvtListeners();
		}
		
		/* triggered when clicked on search. We take the entered string and see if it is a substring from the list of
		 * valid entries
		 */
		private function termSearch(event: KeyboardEvent) {
			if(event.keyCode == Keyboard.ENTER) {
			displayQueryResult(this.pad.tabletContent.SearchInput.text);
			}
		}
		
		//public wrapper for the actual toggle function
		public function padToggle(evt, forceOpen = false, forceClose = false) {
			tabletToggle(evt, forceOpen, forceClose);
		}
		
		/**
		* Adds event listeners to each "link" on the tablet, for click time.
		*/
		private function addLinkListeners(){
			this.pad.tabletContent.EMT.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.Penlight.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.Stethoscope.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.EarTherm.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.BPCuff.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.Gauze.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.GCS.addEventListener(MouseEvent.CLICK, displayDescription);
			this.pad.tabletContent.MedevacHeli.addEventListener(MouseEvent.CLICK, displayDescription);			
		}
		/**
		* Hides tablet from view
		*/
		public function hide(){
			this.pad.buttonMode = false;
			this.pad.useHandCursor = false;
			this.pad.alpha = 0;
		}
		/**
		* Shows tablet
		*/
		public function show(){
			this.pad.buttonMode = true;
			this.pad.useHandCursor = true;
			this.pad.alpha = 1;
		}
		
		/**
		* Hides all elements of searchList
		*/
		private function hideResults():void {
			this.pad.tabletContent.gotoAndStop("searchList");
			//A good place in code to see the strange instance names!
			this.pad.tabletContent.EMT.alpha = 0;
			this.pad.tabletContent.Penlight.alpha = 0;
			this.pad.tabletContent.Stethoscope.alpha = 0;
			this.pad.tabletContent.EarTherm.alpha = 0;
			this.pad.tabletContent.BPCuff.alpha = 0;
			this.pad.tabletContent.Gauze.alpha = 0;
			this.pad.tabletContent.GCS.alpha = 0;
			this.pad.tabletContent.MedevacHeli.alpha = 0;
		}
		
		/*
		* Opposite of hideResults
		*/
		private function displayAll():void {
			this.pad.tabletContent.EMT.alpha = 1;
			this.pad.tabletContent.Penlight.alpha = 1;
			this.pad.tabletContent.Stethoscope.alpha = 1;
			this.pad.tabletContent.EarTherm.alpha = 1;
			this.pad.tabletContent.BPCuff.alpha = 1;
			this.pad.tabletContent.Gauze.alpha = 1;
			this.pad.tabletContent.GCS.alpha = 1;
			this.pad.tabletContent.MedevacHeli.alpha = 1;
		}
		
		/**
		* Uses indexOf to check for subStrings. hideResults will first set
		* all elements invisible, and if indexOf spots match it will reveal it.
		*/
		private function displayQueryResult(queryStr:String):void {
			hideResults();
			var numFound:int = 0;
			queryStr = queryStr.toLowerCase();
			trace("string of query is: " + queryStr);
			var foundStr:String = "emergency medical technician";
			//began the great if statement sequence
			if(foundStr.indexOf(queryStr) >= 0 ){
				//EXAMPLE IF *** ALL ARE THE SAME BEYOND
				//Set alpha to opaque
				this.pad.tabletContent.EMT.alpha = 1;
				//numFound will "crunch" the found search terms into a nice order from sart point -97
				this.pad.tabletContent.EMT.y = -97 + numFound*24;
				//if we've found it, then iterate numFound for next possible if
				numFound++;
			}
			foundStr = "penlight";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.Penlight.alpha = 1;
				this.pad.tabletContent.Penlight.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "stethoscope";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.Stethoscope.alpha = 1;
				this.pad.tabletContent.Stethoscope.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "ear thermometer";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.EarTherm.alpha = 1;
				this.pad.tabletContent.EarTherm.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "blood pressure cuff";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.BPCuff.alpha = 1;
				this.pad.tabletContent.BPCuff.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "gauze";
			if(foundStr.indexOf(queryStr) >= 0){
				this.pad.tabletContent.Gauze.alpha = 1;  
				this.pad.tabletContent.Gauze.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "glasgow coma scale";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.GCS.alpha = 1;
				this.pad.tabletContent.GCS.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "medevac helicopter";
			if(foundStr.indexOf(queryStr) >= 0 ) {
				this.pad.tabletContent.MedevacHeli.alpha = 1;
				this.pad.tabletContent.MedevacHeli.y = -97 + numFound*24;
				numFound++;
			}
			if(numFound == 0) {
				displayAll();
			}
			this.pad.tabletContent.SearchInput.text = "";
		}
		
		private function tabletToggle(evt, forceOpen = false, forceClose = false): void {
			trace("here");
			inToolbox.bringForward();
			
			if((pad.x<-50 || forceOpen) && !forceClose){
				trace("opening");
				this.inToolbox.hideMenu();
				this.scope.createTween(pad, "x", None.easeInOut, 20);
				this.scope.createTween(pad, "y", None.easeInOut, 5);
				this.scope.createTween(pad, "scaleX", None.easeInOut, 1);
				this.scope.createTween(pad, "scaleY", None.easeInOut, 1);
				this.scope.createTween(pad, "rotation", None.easeInOut, 0, -1, 10, function(){
					//ExternalInterface.call("showTabletContent");
				});
				return;
			}
			if(pad.x>=-50 || forceClose){
				trace("closing");
				var myTimer:Timer = new Timer(250, 1);
				myTimer.start();
				var scope = this.scope;
				myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(){
					myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);
					myTimer = null;
					scope.createTween(pad, "x", None.easeInOut, padX);
					scope.createTween(pad, "y", None.easeInOut, padY);
					scope.createTween(pad, "scaleX", None.easeNone, scale);
					scope.createTween(pad, "scaleY", None.easeNone, scale);
					scope.createTween(pad, "rotation", None.easeInOut, padRot);
				 });
				 //ExternalInterface.call("hideTabletContent");
			} 
		}//end toggle function
		
		private function displayDescription(event:MouseEvent):void {
			this.pad.tabletContent.gotoAndStop("descriptionField");
			this.pad.tabletContent.ReturnSearchButton.addEventListener(MouseEvent.CLICK, returnSearchButt);
			trace('firing displayDescription ' + event.currentTarget.name);
			switch (event.currentTarget.name) {
				case EMT: 
					pad.DescriptionField.text = EMT;
					break;
				case Penlight:
					pad.DescriptionField.text = Penlight;
					break;
				case Stethoscope:
					pad.DescriptionField.text = Stethoscope;
					break;
				case EarTherm:
					pad.DescriptionField.text = EarTherm;
					break;
				case BPCuff:
					pad.DescriptionField.text = BPCuff;
					break;
				case Gauze:
					pad.DescriptionField.text = Gauze;
					break;
				case GCS:
					pad.DescriptionField.text = GCS;
					break;
				case MedevacHeli:
					pad.DescriptionField.text = MedevacHeli;
					break;
			}// end switch statement
		}
		
		private function returnSearchButt(event: MouseEvent):void {
			trace('firing mouse');
			this.pad.tabletContent.ReturnSearchButton.removeEventListener(MouseEvent.CLICK, returnSearchButt);
			this.pad.tabletContent.gotoAndStop("defaultScreen");
			this.pad.tabletContent.SearchInput.addEventListener(MouseEvent.CLICK, prepSearch);
		}

	}
	
}
