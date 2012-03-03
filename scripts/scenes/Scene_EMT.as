switch(timeline){
	case 0:
		
		sounds['helicopter'] = playSound("sound_helicopter", int.MAX_VALUE);
		tweenSound(sounds['helicopter'], .15, 0, 10000);
		
		var messages = new Array("I know you’re just a medical student but you’ve been trained for this.",
								 "If you need guidance I will help you.",
								 "It’s good you that you brought your medical school notes.",
								 "Remember to check your notebook for notes about procedures and tools.",
								 "To get started, open the drawer and grab the tools you need to complete the assessment.");
								 
		timeline++;
		fadeIn(function(){
			//new Picker(stage, 20, 20, "hello how are you today", messages);//{
			displayMessages(messages, 550, 320, function(){
				gotoAndStop("Scene_Heli2");
			}, false);
		});
		var msgNum = 0;
		
		break;
	case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
}
trace(timeline);