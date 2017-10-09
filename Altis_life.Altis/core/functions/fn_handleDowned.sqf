/*
	File: fn_handleDowned.sqf
	Author: Skalicon
	
	Description: Downed state for rubber bullets
*/
private["_time","_downed","_hndlBlur","_hndlBlack","_eff1","_eff2","_effects","_source","_vehSource","_curMags","_curWep","_attach"];
player setDamage 0;
_vehSource = false;
_curMags = magazines player;
_shanked = param [1,false,[false]];
_obj = objNull;
if (!life_isdowned && !life_istazed) then {
	_source = param [0,Objnull,[Objnull]];
	if(param[2,false]) then
	{
		_vehSource = true;
		[0,format["%1 was run over by %2!", name player, name _source]] remoteExec ["life_fnc_broadcast",0];
		if(side _source == civilian && {_source != player}) then {
			[getPlayerUID _source,name _source,"481",[name player,getPos player,getText(configFile >> "CfgVehicles" >> (typeOf vehicle _source) >> "displayName")]] remoteExec ["life_fnc_wantedAdd",2];
			[] remoteExec ["life_fnc_vdmMonitor",_source,false];
		};
	};
	if(!(_vehSource) && !(_shanked)) then { [0,format["%1 was stunned by %2!", name player,_source getVariable["realname",name _source]]] remoteExec ["life_fnc_broadcast",0]; };
	player allowDamage false;
	if(_shanked) then {
		call KK_fnc_forceRagdoll;
		titleText[format["You were shanked by %1!",name _source],"PLAIN"];
	};
	life_isdowned = true;
	if(!isNull objectParent player) then
	{
		player action["GetOut",vehicle player];
		waitUntil{isNull objectParent player};
	};
	_curWep = currentWeapon player;
	_curMags = magazines player;
	_attach = if(primaryWeapon player != "") then {primaryWeaponItems player} else {[]};
	{player removeMagazine _x} foreach _curMags;
	player removeWeapon _curWep;
	player addWeapon _curWep;
	if(count _attach != 0 && primaryWeapon player != "") then
	{
		{
			player addPrimaryWeaponItem _x;
		} foreach _attach;
	};
	if(count _curMags != 0) then
	{
		{player addMagazine _x;} foreach _curMags;
	};
	player setVariable["downed",true,true];
	disableUserInput true;
	if(!_shanked) then {
		_obj = "Land_ClutterCutter_small_F" createVehicle (getPosATL player);
		_obj setPosATL (getPosATL player);
		player attachTo [_obj,[0,0,0]];
		[player,"AinjPfalMstpSnonWnonDf_carried_fallwc"] remoteExec ["life_fnc_animSync",0];
	};

	_hndlBlur = ppEffectCreate ["DynamicBlur", 501];
	_hndlBlur ppEffectEnable true;
	_hndlBlur ppEffectAdjust [5];
	_hndlBlur ppEffectCommit 0;

	_hndlBlack = ppEffectCreate ["colorCorrections", 1501];
	_hndlBlack ppEffectEnable true;
	_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, 0.9], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
	_hndlBlack ppEffectCommit 0;
	_effects = true;
	_eff1 = 5;
	_eff2 = 0.9;
	_time = 0;
	_downed = true;
	disableUserInput true;
	while {_downed} do {
		if (player getVariable ["restrained",false] || player getVariable ["zipTie",false]) exitWith {_downed = false};
		if (_time == 8) then {[player,"incapacitated"] remoteExec ["life_fnc_animSync",0];};
		if ((_vehSource && _time == 10) || (!_vehSource && _time == 30) || (_shanked && _time == 20)) then {
			[player,"amovppnemstpsraswrfldnon"] remoteExec ["life_fnc_animSync",0];
			_downed = false;
		};
		_time = _time + 1; 
		sleep 1;
	};
	disableUserInput false;
	[_hndlBlur,_hndlBlack,_eff1,_eff2,_effects] spawn {
		_hndlBlur = _this select 0;
		_hndlBlack = _this select 1;
		_eff1 = _this select 2;
		_eff2 = _this select 3;
		_effects = _this select 4;
		while {_effects} do {
			_eff1 = _eff1 - 0.025;
			_eff2 = _eff2 - 0.0045;

			_hndlBlur ppEffectAdjust [_eff1];
			_hndlBlur ppEffectCommit 0;
			
			_hndlBlack ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, _eff2], [1.0, 1.0, 1.0, 1.0],[1.0, 1.0, 1.0, 0.0]];
			_hndlBlack ppEffectCommit 0;

			sleep 0.01;
			if (_eff2 <= 0) then {_effects = false;};
		};
		ppEffectDestroy _hndlBlur;
		ppEffectDestroy _hndlBlack;
	};
	life_isdowned = false;
	player allowDamage true;
	player setVariable["downed",false,true];
	player playMoveNow "amovppnemstpsraswrfldnon";
	disableUserInput false;
};
if(!isNull _obj) then {deleteVehicle _obj};