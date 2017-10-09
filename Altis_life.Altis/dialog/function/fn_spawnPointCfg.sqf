/*
	File: fn_spawnPointCfg.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration for available spawn points depending on the units side.
	
	Return:
	[Spawn Marker,Spawn Name,Image Path]
*/
private["_side","_return"];
_side = param [0,civilian,[civilian]];

/*Spawn Marker, Spawn Name, PathToImage*/
switch (_side) do
{
	case west:
	{
		_return = [
			["cop_spawn_1","Police HQ","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["cop_spawn_3","Athira Dept.","\a3\ui_f\data\map\GroupIcons\badge_rotate_0_gs.paa"],
			["cop_spawn_2","Pyrgos Dept.","\a3\ui_f\data\map\MapControl\fuelstation_ca.paa"],
			["cop_spawn_4","Kavala Dept.","\a3\ui_f\data\map\Markers\NATO\b_air.paa"],
			["cop_spawn_5","Sofia Dept.","\a3\ui_f\data\map\GroupIcons\badge_rotate_0_gs.paa"],
			["cop_spawn_6","Coast Guard","\a3\ui_f\data\map\GroupIcons\badge_rotate_0_gs.paa"]
		];
	};
	
	case civilian:
	{
		_return = [
			["civ_spawn_3","Athira (Main)","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["civ_spawn_2","Pyrgos","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["civ_spawn_5","Airport","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["civ_spawn_1","Agios Dionysios","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
			["civ_spawn_4","Sofia","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
		];
		if(count life_tent > 0) then {
			_return pushBack [format["civ_spawn_tent_%1",getPlayerUID player],"Tent","\a3\ui_f\data\map\locationtypes\vegetationbroadleaf_ca.paa"];
		};
		if(count life_houses > 0) then {
			{
				_pos = call compile format["%1",_x];
				_house = nearestBuilding _pos;
				_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
				
				_return pushBack [format["house_%1",_house getVariable "uid"],_houseName,"\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"];
			} foreach life_houses;
		};
		
		{
		if(group player getVariable["gang_name",nil] == ((life_turf_list select _x) select 1)) then {
			_place = switch(_x) do {
				case 0: {"Syrta Turf"};
				case 1: {"Zaros Turf"};
				case 2: {"Paros Turf"};
			};
			_var = format["gang_spawn_%1",(_x + 1)]; 
			_return pushBack [_var,_place,"\a3\ui_f\data\map\MapControl\watertower_ca.paa"];
		};
		} forEach [0,1,2];
	};
	
	case independent: {
		_return = [
			["medic_spawn_2_1","Medical Air Base","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
			["medic_spawn_2","Rodopoli Medical","\a3\ui_f\data\map\MapControl\hospital_ca.paa"],
			["medic_spawn_1","Kavala Hospital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"]
		];
	};
};

_return;