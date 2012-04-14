
switch(timeline){
	case 51:
		var messages = new Array("Click to start the quiz"); 
		displayMessages(messages, 550, 320, function(){
			gotoAndStop("Scene_CTQuiz");
		});
		
		break;
	//case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
}
timeline++;
//trace(timeline);