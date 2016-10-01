// Command and signals tab and Unit roster are generated automatically based of TFD_ORBAT

player createDiaryRecord ["Diary",
							["Admin and Logistics",
								""]];

player createDiaryRecord ["Diary",
							["Execution",
								""]];

player createDiaryRecord ["Diary", 
							["Mission", 
								""]];
								
player createDiaryRecord ["Diary", 
							["Situation", 
								""]];

rosterPage = player createDiarySubject [ "Admin" , "Admin Instruction" ];

player createDiaryRecord ["Admin", 
							["Starting", 
								'execute "startMission = true;" when ready to commence the mission.']];