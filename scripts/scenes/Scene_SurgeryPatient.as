﻿(function(){ 	var mouseUpCallback = function(tool, x, y, index, callback){		return function(e){			if(tool.y>-70){				createTween(tool, "x", Regular.easeInOut, x);				createTween(tool, "y", Regular.easeInOut, y);				return			}			currentTool = toolbox.tools[index].toolName;			var tempx = tool.x;			var tempy = tool.y;			resetTools();			tool = toolbox.tools[index].tool;			tool.x = tempx;			tool.y = tempy;						createTween(tool, "x", Regular.easeInOut, x);			createTween(tool, "y", Regular.easeInOut, y+100);			callback(true);		}	};		 	var rollovers = true;	var rollOverTT = function(tool, toolName){		return function(evt){			if(rollovers){				tt.addTip(tool, toolName);			}		};		}	var configureTools = function(toUse, callback){		lostTime = false;		rollovers = true;		toolbox.bringForward();		for(var toolIndex in toolbox.tools){			var tool = toolbox.tools[toolIndex];			if(!tool.empty){				tool.tool.buttonMode = true;				tool.tool.useHandCursor = true;				//tt.buttonMode = true;				//tt.useHandCursor = true;				tool.tool.addEventListener(MouseEvent.ROLL_OVER,rollOverTT(tool.tool, tool.toolName));				tool.tool.addEventListener(MouseEvent.ROLL_OUT,function(){					tt.removeTip();   				});				if(tool.toolName===toUse){					makeDraggable(tool.tool, function(evt){						rollovers = false;						tt.removeTip();		  					}, mouseUpCallback(tool.tool, tool.tool.x, tool.tool.y, toolIndex, callback));				}else{					tool.tool.addEventListener(MouseEvent.MOUSE_DOWN, function(){											   							callback(false)											   						});				}			}		}		}		//If we should have tools but don't	if(timeline>100 && toolbox.isEmpty()){		//add the tools		if(timeline<108){			tbi.surgeonToolData = tbi.surgeonToolDataFirst;		}else{			tbi.surgeonToolData = tbi.surgeonToolDataSecond;		}		for(var index in tbi.surgeonToolData){			var tempTool = addImage(tbi.surgeonToolData[index].className, 0, 0);			var space = toolbox.getNextEmpty();			var vWidth = 0;			var vHeight = 0;			var vx = 0;			var vy = 0;			if(tempTool.height<tempTool.width){				 vHeight = ((space.width-6)/tempTool.width)*tempTool.height;				 vWidth = space.width-6;				 var diffHeight = space.height-6-vHeight;				 vx = space.x+3;				 vy = space.y+3+diffHeight/2;			 }else{				 vWidth = ((space.height-6)/tempTool.height)*tempTool.width;				 vHeight = space.height-6;				 var diffWidth = space.width-6-vWidth;				 vx =  space.x+3+diffWidth/2;				 vy = space.y+3;			 }						space.addTool(tbi.surgeonToolData[index].className, tempTool, {"width":vWidth, "height":vHeight, "x":vx-space.x+6, "y":vy-space.y+6});			 		}	}		if(timeline>107 && timeline<=109){		var mX = 300;		var mY = 150;		tbi.userLine =  addImage("markerLine", mX, mY);			}		if(timeline>109 && timeline<=110 && tbi.pMarkerCut == null){		var mX = 300;		var mY = 150;		tbi.userLine =  addImage("markerLine", mX, mY);		tbi.pMarkerCut = addImage("scalpelCut", mX, mY);	}	if(timeline>110 && timeline<117 && tbi.muscleback == null){		tbi.muscleback =  addImage("muscleback", 155, 5);	}	if(timeline>110 && tbi.rclips === null){		tbi.rclips = new clips();		tbi.rclips.x = 393;		tbi.rclips.y = 226;		stage.addChild(tbi.rclips);	}			switch(timeline){		case 103:			var surgeonDialog = function(callback){				var messages = new Array("The ER removed most of the patients hair, but we want the scalp as clean as possible.",										 "First, use the razor to remove the remaining hair.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("We need to remove any remaining hair before we can continue.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var hairX = 123;			var hairY = 20;			var pHair =  addImage("hairStubble", hairX, hairY);						var scalpX = 138;			var scalpY = 20;			var pScalp =  addImage("headTop", scalpX, scalpY);			var maskObj:MovieClip = new MovieClip();			maskObj.graphics.beginFill(0x00000000);			pScalp.mask = maskObj;						toolbox.bringForward();							surgeonDialog(function(){				var firstWrongPick = true;				configureTools("razor", function(choice){					if(choice){						include "surgery/razor.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});		break;		case 104:			var surgeonDialog = function(callback){				var messages = new Array("Good, we can now sterilize the scalp to prevent infection.",										 "First, prep the area with alcohol.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("Make sure the entire scalp has been prepared with alcohol before proceeding.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}					surgeonDialog(function(){				var firstWrongPick = true;				configureTools("alcohol", function(choice){					if(choice){						var scalpX = 124;						var scalpY = 17;						var pScalp =  addImage("headAlcohol", scalpX, scalpY);						include "surgery/alcohol.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});								break;		case 105:			var surgeonDialog = function(callback){				var messages = new Array("Now apply the iodine solution to ensure the skin is sterile.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("Make sure you are using the iodine solution to sterilize the scalp.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}					surgeonDialog(function(){				var firstWrongPick = true;				configureTools("iodine", function(choice){					if(choice){						var scalpX = 124;						var scalpY = 17;						var pScalp =  addImage("headIodine", scalpX, scalpY);						include "surgery/alcohol.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});								break;		case 106:		var surgeonDialog = function(callback){				var messages = new Array("Excellent, a good preparation goes a long way in preventing infection.",										 "Now, use the marker to draw the incision line.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("Before wan can make any incisions we need to clearly mark where to cut.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}					surgeonDialog(function(){				var firstWrongPick = true;				//include "surgery/marker.as";				configureTools("marker", function(choice){					if(choice){						include "surgery/marker.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});		break;		case 107:			var surgeonDialog = function(callback){				var messages = new Array("Looks good, We are now ready to inject the local anesthetic into the scalp.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("The syringe should be on your prep tray");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}					surgeonDialog(function(){				//include "surgery/syringe.as";				var firstWrongPick = true;				configureTools("syringe", function(choice){					if(choice){						include "surgery/syringe.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});		break;		case 109:						var surgeonDialog = function(callback){				var messages = new Array("The patient is now ready for surgery. I will be right here to assist with the procedure.",										 "Why don’t you make the first incision?",										 "Grab the scalpel and cut along the line you marked earlier.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("We need to get access to the patient’s skull,",										 "there is a scalpel ready for you to make the first incision.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			surgeonDialog(function(){				var firstWrongPick = true;				configureTools("scalpel", function(choice){					if(choice){						include "surgery/scalpel.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});				break;		case 110:			var skinCut =  addImage("openSkin", 155, 5);			tbi.muscleback =  addImage("muscleback", 155, 5);			skinCut.alpha = 0;			//addChild(skinCut);			//addChild(tbi.muscleback);			tbi.muscleback.alpha = 0;						var surgeonDialogSkin = function(callback){				var messages = new Array("Now, I will take over for the next step.",										 "First I will pull back the skin...");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}						var surgeonDialogMuscle = function(callback){				var messages = new Array("...And then the muscle");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}						var surgeonDialog = function(callback){				var messages = new Array("Now, that I’ve pulled back the skin and muscle. You can place the Raney clips along the incision to control the bleeding.",										 "Take the clips and make sure to place them evenly along the incision line.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("We need to place the Raney clips evenly along the incision line to control the bleeding.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var pullSkin = function(callback){				var tweens = new Array();				var waiter = null;								tweens.push(createTween(tbi.userLine, "alpha", None.easeInOut, 0, -1, 100));				tweens.push(createTween(tbi.pMarkerCut, "alpha", None.easeInOut, 0, -1, 100));				//tweens.push(createTween(userCutLineBlack, "alpha", None.easeInOut, 0, -1, 100));				//tweens.push(createTween(pOutline, "alpha", None.easeInOut, 0, -1, 100, function(){				tweens.push(createTween(skinCut, "alpha", None.easeInOut, 1, -1, 100, function(){					remove(tbi.userLine);					remove(tbi.pMarkerCut);					waiter.kill();					callback();				}));				waiter = waitOnUser(function(){					for(var i in tweens){						tweens[i].fforward();						tweens[i] = null;					}				});							}			var pullMuscle = function(callback){				var tweens = new Array();				var waiter = null;								tweens.push(createTween(tbi.muscleback, "alpha", None.easeInOut, 1, -1, 100));				tweens.push(createTween(skinCut, "alpha", None.easeInOut, 0, -1, 100, function(){					remove(skinCut);					waiter.kill();					callback();				}));				//var firstIgnoreHack = false;				waiter = waitOnUser(function(){					//if(firstIgnoreHack){						for(var i in tweens){							tweens[i].fforward();							tweens[i] = null;						}						tweens = null;					//}					//firstIgnoreHack = true;				});							}			surgeonDialogSkin(function(){				pullSkin(function(){					surgeonDialogMuscle(function(){						pullMuscle(function(){							surgeonDialog(function(){								var firstWrongPick = true;								configureTools("raneyClip", function(choice){									if(choice){										include "surgery/raney.as";									}else{										if(firstWrongPick){											clock.reduceAngle(20);											firstWrongPick = false;										}										sugeonDialogWrong();									}								});							});						});					});				});			});				break;		case 111:						var surgeonDialog = function(callback){				var messages = new Array("You really need to focus for the next few procedures.",										 "Take the high speed drill and make 4 keyholes where I mark on the skull.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("The only way we can cut through the skull is with the high speed drill.");				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			surgeonDialog(function(){				var firstWrongPick = true;				configureTools("drills", function(choice){					if(choice){						include "surgery/drill.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});				break;		case 112:			var mX = 317;			var mY = 164;			var theTray =  addImage("tray", WIDTH, 50);			var noSkull = addImage("noskull", mX-12, mY);			var skBone =  addImage("skullBone", mX, mY);						var surgeonDialog = function(callback){				var messages = new Array("Once all the keyholes are connected, slowly lift off the skull flap and place it in the tray.",										 "It will be sent off to the bone bank for storage until the patient recovers.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var onSkullDrop = function(skull, skullX, skullY, callback){				return function(){					if(skull.x>WIDTH-200){						callback();					}else{						createTween(skull, "x", None.easeInOut, skullX, -1, 10);						createTween(skull, "y", None.easeInOut, skullY, -1, 10);					}				}			}									createTween(theTray, "x", None.easeInOut, WIDTH-200, -1, 40);			surgeonDialog(function(){				makeDraggable(skBone, function(evt){				}, 				onSkullDrop(skBone, skBone.x, skBone.y, function(){					createTween(theTray, "x", None.easeInOut, theTray.x+200, -1, 40);					createTween(skBone, "x", None.easeInOut, skBone.x+200, -1, 40, function(){						stage.removeChild(skBone);						stage.removeChild(theTray);						lastFrame = -1;						gotoAndStop("Scene_SurgeryPatient");					});							}));			});		break;		case 113:			var mX = 317;			var mY = 165;			var noSkull = addImage("noskull", mX-12, mY);						var surgeonDialog = function(callback){				var messages = new Array("To control the bleeding, spread the bone wax along the cut edges of the skull.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("We can’t proceed until the exposed bone has been covered with the bone wax.", "We can’t proceed until the exposed bone has been covered with the bone wax.");				var msgs = displayMessages(messages, null, null, callback, false, "surgeonFace");			}						surgeonDialog(function(){				var firstWrongPick = true;				configureTools("boneWax", function(choice){					if(choice){						include "surgery/boneWax.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});		break;		case 114:						var mX = 317;			var mY = 165;			var noSkull = addImage("noskull", mX-12, mY);  /* Need to remove these */			var noSkullB = addImage("noskullblurred", mX-12, mY);						var surgeonDialog = function(callback){				var messages = new Array("Ok, we’ve almost exposed the site of injury. Now we need to cut through the dura.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("Carefully use the scissors to cut an \"X\" so that I can fold the dura back and access the brain.");				var msgs = displayMessages(messages, null, null, callback, false, "surgeonFace");			}						surgeonDialog(function(){				var firstWrongPick = true;				configureTools("duraScalpel", function(choice){					if(choice){						include "surgery/dura.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});						break;		case 115:			var mX = 317;			var mY = 165;			var noSkull = addImage("noskull", mX-12, mY);			var noSkullB = addImage("noskullblurred", mX-12, mY);			var mX = 350;			var mY = 183;			var duraOpen =  addImage("duraOpen", mX-55, mY-69);			var duraCut =  addImage("duraCut", mX, mY+2);			duraOpen.alpha = 0;			var openDura = function(callback){				var tweens = new Array();				var waiter = null;								tweens.push(createTween(duraCut, "alpha", None.easeInOut, 0, -1, 100));				//tweens.push(createTween(tbi.pMarkerCut, "alpha", None.easeInOut, 0, -1, 100));				//tweens.push(createTween(userCutLineBlack, "alpha", None.easeInOut, 0, -1, 100));				//tweens.push(createTween(pOutline, "alpha", None.easeInOut, 0, -1, 100, function(){				tweens.push(createTween(duraOpen, "alpha", None.easeInOut, 1, -1, 100, function(){					remove(duraCut);					remove(noSkull);					remove(noSkullB);					waiter.kill();					callback();				}));				waiter = waitOnUser(function(){					for(var i in tweens){						tweens[i].fforward();						tweens[i] = null;					}				});			}			var surgeonDialog = function(callback){				var messages = new Array("Looks like your interpretations of the CT imagery were correct, note the hematoma near the right temporal lobe.",										 "We’ll need use irrigation and suction to remove the damaged tissue.",										 "First irrigate a section of the hematoma to break up the clotted blood and then use the suction to carefully remove it.",										 "Work on one section of the hematoma at a time until it is completely removed.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("Using suction and irrigation is the best way we can loosen and remove the hematoma.");				var msgs = displayMessages(messages, null, null, callback, false, "surgeonFace");			}						openDura(function(){				surgeonDialog(function(){					var firstWrongPick = true;					configureTools("suction", function(choice){						if(choice){							include "surgery/suction.as";						}else{							if(firstWrongPick){								clock.reduceAngle(20);								firstWrongPick = false;							}							sugeonDialogWrong();						}					});				});						 			});					break;		case 116:			var mX = 350;			var mY = 183;			tbi.duraOpenH =  addImage("duraOpenHealed", mX-55, mY-69);			var surgeonDialog = function(callback){				var messages = new Array("It looks like the bleeding is under control,",										 "but we need to pack the damaged area with a gelatin sponge to ensure the injury site clots properly.");										 				displayMessages(messages, null, null, callback, false, "surgeonFace");			}			var sugeonDialogWrong = function(callback){				var messages = new Array("We can’t be sure the patient will be stable until we use the surgical sponge to clot and damaged blood vessels.");				var msgs = displayMessages(messages, null, null, callback, false, "surgeonFace");			}			surgeonDialog(function(){				var firstWrongPick = true;				configureTools("surgicalSponge", function(choice){					if(choice){						include "surgery/sponge.as";					}else{						if(firstWrongPick){							clock.reduceAngle(20);							firstWrongPick = false;						}						sugeonDialogWrong();					}				});			});					break;	}	timeline++;})();												