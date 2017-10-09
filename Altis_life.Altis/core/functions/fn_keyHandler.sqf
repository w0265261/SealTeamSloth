#include <macro.h>
/*
	File: fn_keyHandler.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main key handler for event 'keyDown'
*/
private ["_handled","_shift","_alt","_code","_ctrl","_alt","_ctrlKey","_veh","_locked","_interactionKey","_mapKey","_interruptionKeys","_player"];
_ctrl = _this select 0;
_code = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;
_speed = speed cursorTarget;
_handled = false;
_player = player;

_interactionKey = 219;
if(_code in (actionKeys "User10")) then {
	_code = 219;
};
_mapKey = actionKeys "ShowMap" select 0;

_interruptionKeys = [17,30,31,32];


if((_code in (actionKeys "GetOver") || _code in (actionKeys "salute") || _code in (actionKeys "SitDown")) && {(player getVariable ["restrained",false])}) exitWith {
	true;
};
if(_code in actionKeys "SwitchPrimary" || _code in actionKeys "SwitchHandgun") then {_handled = true};
if(life_action_inUse || life_cruise) exitWith {
	if(!life_interrupted && _code in _interruptionKeys) then {life_interrupted = true;};
	_handled;
};

if(_code in (actionKeys "User13")) then {
	_code = 35;
};
if(_code in (actionKeys "User14")) then {
	player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendA";
};
if(_code in (actionKeys "User15")) then {
	player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
};
if(_code in (actionKeys "User16")) then {
	player playMove "Acts_AidlPercMstpSlowWrflDnon_pissing";
};

if(_code in (actionKeys "User7")) then {
	[] call life_fnc_radar;
};

if(_code in (actionKeys "User6") && !isNull objectParent player && playerSide == west && vehicle player in life_vehicles) then {
	[vehicle player] spawn life_fnc_setUnitNumber;
};
if(_code in (actionKeys "User4")) then {
	call life_fnc_activateNitro;
};
if(_code in (actionKeys "User5") && !isNull objectParent player) then {
	if(speed (vehicle player) > 25) then {
			[] spawn {
				_velocity = velocity (vehicle player);
				_vehicle = vehicle player;
				life_cruise = true;
				_damage = damage _vehicle;
				while{isEngineOn _vehicle && vehicle player == _vehicle && !life_interrupted && speed _vehicle > 25 && (getPosATL _vehicle select 2) < 0.5 && isOnRoad _vehicle && _damage == damage _vehicle} do
				{
					_vehicle setVelocity _velocity;
				};
				life_cruise = false;
				life_interrupted = false;
			};
	};
};

switch (_code) do
{
	/*1 Key*/
	case 2:
	{
		if(isNull (findDisplay 2400) && (life_governor || (__GETC__(style) > 0) || life_wantedlist || license_civ_bh || vehicle player getVariable ["copCar",false] || (playerSide == west && ((player distance (getMarkerPos "jail_marker") < 200) OR (player distance (getMarkerPos "cop_spawn_1") < 100) OR (player distance (getMarkerPos "cop_spawn_2") < 100) OR (player distance (getMarkerPos "cop_spawn_3") < 100) OR (player distance (getMarkerPos "cop_spawn_4") < 100) OR (player distance (getMarkerPos "cop_spawn_5") < 100) OR (player distance (getMarkerPos "cop_spawn_6") < 100))))) then {
			closeDialog 0;
			[] call life_fnc_wantedMenu;
		};
	};
	
	case 6:
	{
		if(_shift) then {_handled = true;};
		if (_shift) then
		{
			if(!_alt && !_ctrlKey && !dialog) then
			{
				createDialog "STS_Life_my_smartphone"; /*Call SmartPhone Dialog*/
			};
		};
	};
	
	/*Map Key*/
	case _mapKey:
	{
		switch (playerSide) do 
		{
			case west: {if(!visibleMap) then {[] spawn life_fnc_copMarkers;}};
			case independent: {
				if(!visibleMap) then {
					[] spawn life_fnc_medicMarkers;
				};
			};
			case civilian: {if(!visibleMap) then {[] spawn life_fnc_gangMarkers;}};
		};
	};
	
	/*Holster / recall weapon.*/
	case 35:
	{
		if(_shift && !_ctrlKey && currentWeapon player != "" && isNull objectParent player) then {
			life_curWep_h = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchcamera cameraView;
		};
		
		if(!_shift && _ctrlKey && !isNil "life_curWep_h" && {(life_curWep_h != "")}) then {
			if(!isNil "life_getOut") exitWith {};
			if(life_curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
				player selectWeapon life_curWep_h;
			};
		};

		if(playerSide == west && !isNull objectParent player && ((driver vehicle player) == player) && life_lock) then
		{
			life_lock = false;
			[vehicle player,"police_horn",200] remoteExec ["life_fnc_playSound",0];
			[] spawn { sleep 1; life_lock = true; };
		};
	};

	/*Interaction key (default is Left Windows, can be mapped via Controls -> Custom -> User Action 10)*/
	case _interactionKey:
	{
		if(!life_action_inUse) then {
			[] spawn 
			{
				private["_handle"];
				_handle = [] spawn life_fnc_actionKeyHandler;
				waitUntil {scriptDone _handle};
				life_action_inUse = false;
			};
		};
	};
	
	/*Restraining (Shift + R)*/
	case 19:
	{
		if((player getvariable["restrained",false] || player getVariable["zipTie",false] || !isNil "surrender" || player getVariable["unconscious",false])) then {_handled = true;};
		if(_shift) then {_handled = true;};
		if(_shift && !isNull cursorTarget && cursorTarget isKindOf "Man" && (isPlayer cursorTarget) && alive cursorTarget && animationState player != "incapacitated" && cursorTarget distance player < 3.5 && !(cursorTarget getvariable["Escorting",false]) && !(cursorTarget getvariable["restrained",false])) then
		{
			switch (playerSide) do {
				case west:		{ [cursorTarget] call life_fnc_restrainAction; };
				case civilian:	{ [cursorTarget] call life_fnc_zipTie; };
			};
		};
	};

	/*2 key Surrender*/
	case 3:
	{
		if (!_shift && !_alt && !_ctrlKey && !(player getVariable["juryDecide",false])) then
		{
			if (isNull objectParent player && !(player getVariable ["restrained", false]) && !(player getVariable ["Escorting", false]) && !(player getVariable ["zipTie", false])) then {
				if (!isNil "surrender") then {
					surrender = nil;
				} else {
					[] spawn life_fnc_surrender;
				};
			};
			_handled = true;
		};
	};

	case 34:
	{
		if(life_houseRequest && _ctrlKey && !_shift) exitWith {
			life_soldHouse = true;
		};
		if(_shift) then {_handled = true;};
		if(_shift && !life_dueling && !isNull cursorTarget && cursorTarget isKindOf "Man" && isPlayer cursorTarget && alive cursorTarget && cursorTarget distance player < 4 && speed cursorTarget < 1) then
		{
			if((animationState cursorTarget) != "Incapacitated" && (currentWeapon player == primaryWeapon player OR currentWeapon player == handgunWeapon player) && currentWeapon player != "" && !life_knockout && !(player getVariable["restrained",false]) && !life_istazed) then
			{
				[cursorTarget] spawn life_fnc_knockoutAction;
			};
		};
	};

	/* O Key, police gate opener*/
	case 24:
	{
		if (!_shift && !_alt && !_ctrlKey && (playerSide == west)) then {
			[] call life_fnc_copOpener;
		};
		if(!_shift && _ctrlKey) then {
switch (true) do
{
        case ( soundVolume >= 0.6 ) :
        {      
                2 fadeSound 0.1;
                hint "Sound Faded.";
        };
               
        case ( soundVolume < 0.6 ) :
        {      
                2 fadeSound 1;
                hint "Sound returned to normal.";
        };
};
};
	};

	/*T Key (Trunk)*/
	case 20:
	{
		if(!_alt && !_ctrlKey) then
		{
			if(!isNull objectParent player && alive vehicle player) then
			{
				if((vehicle player) in life_vehicles) then
				{
					[vehicle player] call life_fnc_openInventory;
				};
			}
				else
			{
				if((cursorTarget isKindOf "Car" OR cursorTarget isKindOf "Air" OR cursorTarget isKindOf "Ship" OR cursorTarget isKindOf "House_F" OR typeOf cursorTarget in["I_supplyCrate_F","Box_IND_Wps_F"]) && player distance cursorTarget < 7 && isNull objectParent player && alive cursorTarget) then
				{
					if(typeOf cursorTarget in["I_supplyCrate_F","Box_IND_Wps_F"] OR cursorTarget in life_vehicles OR {!(cursorTarget getVariable ["locked",true])} OR (!(cursorTarget isKindOf "House_F") && locked cursorTarget < 2 && !(currentWeapon player in["Binocular","Rangefinder",""]) && player ammo currentWeapon player > 0)) then
					{
						[cursorTarget] call life_fnc_openInventory;
					};
				};
			};
		};
		if( !_shift && _ctrlKey && !_alt) then
		{
			if(!(cursorTarget isKindOf "AllVehicles")) exitWith {};
			if(!(isPlayer cursorTarget) && {count crew cursorTarget == 0}) exitWith {};
			if(cursorTarget isKindOf "Man") then {
				//life_smartphoneTarget = call compile format["%1", cursorTarget];
			} else {
				life_smartphoneTarget = crew cursorTarget;
				if(isNil "life_smartphoneTarget") exitWith {};
				[4] call life_fnc_smartphone;
			};
		};
	};
	
	/*L Key*/
	case 38:
	{
		/*If cop run checks for turning lights on.*/
		if(_shift && playerSide == west && (driver vehicle player) == player) then {
			if(!isNull objectParent player && life_lock) then {
				life_lock = false;
				if(!isNil {vehicle player getVariable "lights"}) then {
					[vehicle player] call life_fnc_sirenLights;
					_handled = true;
				} else {
					vehicle player setVariable ["lights", false, true];
					_handled = true;
				};
				[] spawn { sleep 1; life_lock = true; };
			};
		};
		if(_shift && playerSide == independent && (driver vehicle player) == player) then {
			if(!isNull objectParent player && life_lock) then {
				life_lock = false;
				if(!isNil {vehicle player getVariable "lights"}) then {
					[vehicle player] call life_fnc_medicSirenLights;
					_handled = true;
				}else{
					vehicle player setVariable ["lights", false, true];
					_handled = true;
				};
				[] spawn { sleep 1; life_lock = true; };
			};
		};

		if(!_alt && !_ctrlKey) then { [] call life_fnc_radar; };
	};
	
	/*Y Player Menu*/
	case 21:
	{
		if(!_alt && !_ctrlKey && !dialog) then
		{
			[] call life_fnc_p_openMenu;
		};
	};

	/*V Key*/
	case 47:
	{
		if(player getvariable["restrained",false]  OR player getVariable["zipTie",false]) then {_handled = true;};
	};
	
	/*F Key*/
	case 33:
	{
		if(!isNil "life_getOut") exitWith{life_getOut = nil; if(primaryWeapon player == "") then {player selectWeapon handgunWeapon player} else {player selectWeapon primaryWeapon player}};
		if(playerSide == west && !isNull objectParent player && !life_siren_active && ((driver vehicle player) == player)) then
		{
			[] spawn
			{
				life_siren_active = true;
				sleep 4.7;
				life_siren_active = false;
			};
			_veh = vehicle player;
			if(isNil {_veh getVariable "siren"}) then {_veh setVariable["siren",false,true];};
			if((_veh getVariable "siren")) then
			{
				titleText ["Sirens Off","PLAIN"];
				_veh setVariable["siren",false,true];
			}
				else
			{
				titleText ["Sirens On","PLAIN"];
				_veh setVariable["siren",true,true];
				[_veh] remoteExec ["life_fnc_copSiren",0];
			};
		};

		if(playerSide == independent && !isNull objectParent player && !life_siren_active && ((driver vehicle player) == player)) then
		{
			[] spawn
			{
				life_siren_active = true;
				sleep 1;
				life_siren_active = false;
			};
			_veh = vehicle player;
			if(isNil {_veh getVariable "siren"}) then {_veh setVariable["siren",false,true];};
			if((_veh getVariable "siren")) then
			{
				titleText ["Sirens Off","PLAIN"];
				_veh setVariable["siren",false,true];
			}
				else
			{
				titleText ["Sirens On","PLAIN"];
				_veh setVariable["siren",true,true];
				[_veh] remoteExec ["life_fnc_medicSiren",0];
			};
		};
	};

	/*U Key*/
	case 22:
	{	if(player getvariable["restrained",false]  OR player getVariable["zipTie",false] OR !isNil "surrender" or (animationState player == "Incapacitated")) exitWith {};
		if(!_alt && !_ctrlKey) then {
			if(isNull objectParent player) then {
				_veh = cursorTarget;
			} else {
				_veh = vehicle player;
			};
			
			if((_veh isKindOf "House_F") && playerSide == civilian) then {
				if(_veh in life_vehicles && !(_veh getVariable["breached",false])) then {
					_door = [_veh] call life_fnc_nearestDoor;
					if(_door == 0) exitWith {hint localize "STR_House_Door_NotNear"};
					_locked = _veh getVariable [format["bis_disabled_Door_%1",_door],0];
					if(_locked == 0) then {
						_veh setVariable[format["bis_disabled_Door_%1",_door],1,true];
						_veh animate [format["door_%1_rot",_door],0];
						systemChat localize "STR_House_Door_Lock";
					} else {
						_veh setVariable[format["bis_disabled_Door_%1",_door],0,true];
						_veh animate [format["door_%1_rot",_door],1];
						systemChat localize "STR_House_Door_Unlock";
					};
				};
			} else {
				_locked = locked _veh;
				if(_veh in life_vehicles && player distance _veh < 8) then {
					if(_locked == 2) then {
						if(local _veh) then {
							_veh lock 0;
							_veh setVariable["locked",nil,true];
							_veh enableRopeAttach true;
						} else {
							[_veh,0] remoteExec ["life_fnc_lockVehicle",_veh,false];
						};
						systemChat localize "STR_MISC_VehUnlock";
						PlaySound "car_unlock";
					} else {
						if(local _veh) then {
							_veh lock 2;
							_veh setVariable["locked",true,true];
							_veh enableRopeAttach false;
						} else {
							[_veh,2] remoteExec ["life_fnc_lockVehicle",_veh,false];
						};	
						systemChat localize "STR_MISC_VehLock";
						PlaySound "car_lock";
					};
				};
			};
		};
	};
};
if(_code in (actionKeys "User12")) then {
        if(!(cursorTarget isKindOf "AllVehicles")) exitWith {};
        if(!(isPlayer cursorTarget)) then {
        if(count crew cursorTarget == 0) exitWith {};
        };
        if(cursorTarget isKindOf "Man") then {
        life_smartphoneTarget = call compile format["%1", cursorTarget];
        } else {
        life_smartphoneTarget = call compile format["%1", driver cursorTarget];
        };
		if(isNil "life_smartphoneTarget") exitWith {};
        [4] call life_fnc_smartphone;
};
if(_code in (actionKeys "User11")) then {
switch (true) do
{
        case ( soundVolume >= 0.6 ) :
        {      
                2 fadeSound 0.1;
                hint "Sound Faded.";
        };
               
        case ( soundVolume < 0.6 ) :
        {      
                2 fadeSound 1;
                hint "Sound returned to normal.";
        };
};
};
if(_code in (actionKeys "User1")) then {
	player playMove "AmovPercMstpSnonWnonDnon_exerciseKata";
};
if(_code in (actionKeys "User3")) then {
	player playMove "AmovPercMstpSnonWnonDnon_exercisePushup";
};
if(_code in (actionKeys "User2") && handgunWeapon player == currentWeapon player) then {
	if(animationState player != "amovpercmstpsraswpstdnon") exitWith {};
	[] spawn {player playmove "Acts_starterPistol_fire"; sleep 5.5; player forceWeaponFire [currentWeapon player, "Single"];};
};
if (_code in (actionKeys "User9")) then { if(!_alt && !_ctrlKey && playerSide == west && !(player getVariable["zipTie",false])) then { closeDialog 0; _handled = true; if(!isNull life_spikestrip) exitWith {hint "You already have a Spike Strip active in deployment"};	if(([false,"spikeStrip",1] call life_fnc_handleInv)) then { [] spawn life_fnc_spikeStrip; }; }; };
if (_code in (actionKeys "User8")) then { call life_fnc_adminImpound };
if (_code in (actionKeys "Throw") && (player getvariable["restrained",false]  OR player getVariable["zipTie",false] OR !isNil "surrender" or (animationState player == "Incapacitated"))) then {
	_handled = true;
};


/*Thanks to Asylum*/
if (_code in (actionKeys "TacticalView")) then
{
	_handled = true;
};

if (_code in (actionKeys "PushToTalk") || _code in (actionKeys "PushToTalkSide")) then
{
	if (playerSide == civilian) then
	{
		if (currentChannel == 7) then { systemChat "You are not allowed to use VON over the OOC Channel."; _handled = true; };
		if (currentChannel == 8) then { systemChat "You are not allowed to use VON over the Trade Channel."; _handled = true; };
	};
};
if (_code==41 || _code in (actionKeys "SelectAll") || _code in (actionKeys "SwitchCommand")) then
{
	if (!life_targetTag) then { life_targetTag = true };
	_handled = true;
};
if ((player getVariable["blindfolded",false] || player getVariable["zipTie",false] || player getVariable["restrained",false]) && (_code in (actionKeys "ShowMap") || _code in (actionKeys "MiniMap") || _code in (actionKeys "MiniMapToggle"))) then
{
	systemChat "How could you read a map in this state...?" ;
	_handled = true;
};

_handled;