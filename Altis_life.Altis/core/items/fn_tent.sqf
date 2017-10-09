/*
	File: fn_tent.sqf
	Author: Raku @ Veterans of Altis
	
	Description:
	Sets up a tent with a fireplace, a chair and a campinglight.
*/
private["_nearestTents","_nearestVehicles","_nearestRoad","_tent","_tentSpawnPosition","_item","_chair","_fire","_light"];
_item = param [0,"",[""]];
bool = true;
_tentType = param [1,"",[""]];
if(_item == "" OR _tentType == "") exitWith {};
if(count life_tent > 0) exitWith {hint "You already own a tent!"};
_tentSpawnPosition = player modelToWorld[0,4,0];
_tentSpawnPosition set [2,0];
_nearestTents = nearestObjects [_tentSpawnPosition, ["Land_Campfire_F", "Campfire_burning_F","Land_TentA_F","Land_TentDome_F"], 7];
_nearestVehicles = _tentSpawnPosition nearEntities [["Car", "Air", "Boat"], 15];
_nearestRoad = _tentSpawnPosition nearRoads 50;
if(_nearestTents isEqualTo [] && _nearestVehicles isEqualTo [] && _nearestRoad isEqualTo []) then {
	if([false,_item,1] call life_fnc_handleInv) then {
		life_action_inUse = true;
		
		//Setup the progress bar
		disableSerialization;
		_title = "Setting up tent...";
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
		_titleText ctrlSetText format["%2 (1%1)...","%",_title];
		_progressBar progressSetPosition 0.01;
		_cP = 0.01;	
		_cpRate = 0.0075;
		
		while {true} do
		{
			if(bool) then {
				[] spawn {
					bool = false;
					player playMoveNow "AinvPknlMstpSnonWnonDnon_medic0";
					sleep 7;
					bool = true;
				};
			};
			sleep 0.26;
			if(isNull _ui) then {
				5 cutRsc ["life_progress","PLAIN"];
				_ui = uiNamespace getVariable "life_progress";
				_progressBar = _ui displayCtrl 38201;
				_titleText = _ui displayCtrl 38202;
			};
			_cP = _cP + _cpRate;
			_progressBar progressSetPosition _cP;
			_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
			if(_cP >= 1 OR !alive player) exitWith {};
			if(life_istazed) exitWith {};
			if(life_interrupted) exitWith {};
		};
		
		//Kill the UI display and check for various states
		5 cutText ["","PLAIN"];
		player playActionNow "stop";
		if(!alive player OR life_istazed) exitWith {life_action_inUse = false};
		if((player getVariable["restrained",false]) OR (player getVariable["ziptied",false])) exitWith {life_action_inUse = false};
		if(life_interrupted) exitWith {life_interrupted = false; life_action_inUse = false};
		life_action_inUse = false;
		
		_tent = createVehicle [_tentType, [1.6650946,1.6626484,5], [], 0, "CAN_COLLIDE"];
		_tent setDir 90;
		_chair = createVehicle ["Land_CampingChair_V1_F", [3.2369072,2.8136106,5], [], 0, "CAN_COLLIDE"];
		_fire = createVehicle ["Land_FirePlace_F", [2.5509803,3.8476455,5], [], 0, "CAN_COLLIDE"];
		_light = createVehicle ["Land_Camping_Light_off_F", [0.98040187,3.285964,5], [], 0, "CAN_COLLIDE"];
		_chair attachTo [_tent];
		_fire attachTo [_tent];
		_light attachTo [_tent];
		_tent setDir (floor (random 360));		
		_tent setPos (_tentSpawnPosition);
		_tent setPosATL [(getPosATL _tent) select 0, (getPosATL _tent) select 1, 0];
		_chair setDir (+63.3056);
		_chair setPos (getPos _chair);
		_chair setPosATL [(getPosATL _chair) select 0, (getPosATL _chair) select 1, 0];
		_fire setPos (getPos _fire);
		_fire setPosATL [(getPosATL _fire) select 0, (getPosATL _fire) select 1, 0];
		_light setPos (getPos _light);
		_light setPosATL [(getPosATL _light) select 0, (getPosATL _light) select 1, 0];
		
		_tent allowDamage false;
		_chair allowDamage false;
		_fire allowDamage false;
		_light allowDamage false;
		
		[getPlayerUID player,playerSide,_tentType,1,(getPos _tent)] remoteExec ["DB_fnc_updatePartial",2];
		
		life_tent = [_tentType,_tentSpawnPosition];		
		_tent setVariable["pid",getPlayerUID player,true];
		
		hint "Tent set up.";
	};
} else {
	hint "Cant setup tent, there is a \n\ntent (7 meters),\n campfire (7 meters),vehicle (15 meters),\n or road (50 meters)\n\n nearby.";
};