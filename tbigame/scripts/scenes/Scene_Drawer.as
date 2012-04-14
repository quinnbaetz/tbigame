

var toolData = new Array({"className" : "cuff", "x": 350, "y" : 90},
					 {"className" : "gauze", "x": 400, "y" : 350},
					 {"className" : "penLight", "x": 570, "y" : 350},
					 {"className" : "stethoscope", "x": 80, "y" : 190},
					 {"className" : "thermometer", "x": 140, "y" : 100});


var tools = new Array();

for each(var tool in toolData){
	tools.push(addImage(tool.className, tool.x, tool.y));
}

var front = addImage("drawerFront", 18, 493);
toolbox.bringForward();

var storeCount = 0;

var createListener = function(tool, index){
	 var fun =  function(e){
		  var tool = e.currentTarget;
		  if(tool.hitTestObject(toolbox.menuBox)){
			 var space = toolbox.getNextEmpty();
			 var tempTool = addImage(toolData[index].className, tool.x, tool.y);
			 remove(tool);
			 createTween(tempTool, "width", None.easeInOut, space.width-6);
			 createTween(tempTool, "height", None.easeInOut, space.height-6);
			 createTween(tempTool, "x", None.easeInOut, space.x+3);
			 createTween(tempTool, "y", None.easeInOut, space.y+3, -1, 10, function(){
				space = toolbox.getNextEmpty();
				space.addTool(toolData[index].className, tempTool);
				storeCount++;
				if(tools.length == storeCount){
					remove(front);
					gotoAndStop(currentFrame-1);
				}
			});
			 
			 
		  }
	 }
	 return fun;
}

for(var tool in tools){
	var temp = tool;
	tools[tool].buttonMode = true;
	tools[tool].useHandCursor = true;
	makeDraggable(tools[tool], function(e){bringToFront(stage, e.currentTarget);},createListener(tools[tool], tool));

}

