(function(){
	
 switch(timeline){
	case 75:
		var DoctorDialog = function(callback){
			var messages = new Array("Now that the scan is complete, we need to submit the information using this electronic report.",
									 "I’ve just sent it to your Med-tablet.");
			displayMessages(messages, null, null, callback, false);
		}
		fadeIn(function(){
			 DoctorDialog(function(){
				//ExternalInterface.call("showCTReportOption"); DEPRECATED
				toolbox.pad.toggleCtReport(function(){
						var DoctorDialog = function(callback){
							var messages = new Array("Excellent. Now that you’ve submitted the report, you should check in with Dr. Blackwell about it.");
							displayMessages(messages, null, null, callback, false);
						}
						//close pad (hopefully)
						toolbox.pad.padToggle(null, null, null);
						var msg = DoctorDialog(function(){
							SurgeonButton.createHighlight();   
						});
						var SurgeonButton:ClickRegion = new ClickRegion(stage, 0, 115, 175, 350, function(){
							SurgeonButton.remove();
							fadeOut(function(){
								timeline = 76;
								gotoAndStop("Scene_DoctorOffice");
							});
						}); 
				   }, 
				   function(){
					    var DoctorDialog = function(callback){
							var messages = new Array("You should finish the form before continuing...");
							displayMessages(messages, null, null, callback, false);
					   	}
						//seems pretty silly, I'm sure there's a more sensical way.
						DoctorDialog(function(){});
				}); //end callback
			 });
		});
	 
	 break;
	/*case 76:
		var DoctorDialog = function(callback){
			var messages = new Array("Excellent. Now that you’ve submitted the report, you should check in with Dr. Blackwell about it.");
			displayMessages(messages, null, null, callback, false);
		}
		//close pad (hopefully)
		toolbox.pad.padToggle();
		var msg = DoctorDialog(function(){
			SurgeonButton.createHighlight();   
		});
		var SurgeonButton:ClickRegion = new ClickRegion(stage, 0, 115, 175, 350, function(){
			SurgeonButton.remove();
			fadeOut(function(){
				timeline = 76;
				gotoAndStop("Scene_DoctorOffice");
			});
		}); 
	break;*/
 }
})();

timeline++;