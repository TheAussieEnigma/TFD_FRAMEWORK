class TFD
{	
	class missionResource
	{
		file = "functions\misc";
		
		class dynamicMarkers {};
		class automaticMarkers {};
		class weaponLights {};
		class weaponSafety {};
		class customUnitTraits {};
	};

	class Init
	{
		file = "functions\init";
		class assignGroup {};
		class setTFAR {};
		class setRadio {};
		class unitRoster {};
		class missionStartDialog {};
	}
	class IED 
	{
		file = "functions\IED";
		class iedInit {};
		class IED_mainLogic {};
		class IED_PPeffect {};
		class generateIedLocations {};
		class placeIedObjects {};
	};
};