// Command and signals tab and Unit roster are generated automatically based of TFD_ORBAT

//player createDiaryRecord ["Diary",
//							["Admin and Logistics",
//								""]];

player createDiaryRecord ["Diary",
							["Execution",
								"2 x 6 man Elements will advance through the marked zones and remove ISTS Forces. HQ has approved the use of 2 x HMMWV with some supplies for this Operation. <br/><br/><br/> P.S. I really dont know whats supposed to go in these briefings. <br/><br/>-JohnnyShootos"]];

player createDiaryRecord ["Diary", 
							["Mission", 
								"Advance through the marked zones and remove all ISTS forces.<br/><br/>Be advised our local allies have dropped supplies for you however they botched the drop and the supplies have landed <marker name='marker_5'>North</marker> of your position in the second zone. <br/><br/>Be prepared for anything. Foot Mobiles, soft vehicles, IED's, Mines & Static emplacements."]];
								
player createDiaryRecord ["Diary", 
							["Situation", 
								"Local ISTS cells have merged to become a militia and are currently holding 3 towns in Al Rayak. Local Assets are tasked with repelling the ISTS force."]];
								
rosterPage = player createDiarySubject [ "Admin" , "Admin Instruction" ];

player createDiaryRecord ["Admin", 
							["Starting", 
								'execute following command in console:<br/><br/>nul = execVM "script\flow\start.sqf"']];