/*
	File: fn_handleDamage.sqf

	Description:
	Master damage handling system for STS Altis Life Server
*/
private["_damage","_source","_projectile","_sel","_curWep"];
_sel = param[1];
_damage = param[2];
_source = param[3];
_projectile = param[4];
if(life_paintBalling) then { life_paintBalling = false; player allowDamage false; _damage = 0; player playMoveNow "Incapacitated"; [] spawn { sleep 1; [player] joinSilent life_myGrp; player switchMove ""; player setPosATL life_originalPos; [true] call life_fnc_optiloadGear; player allowDamage true;};};
if(life_dueling) then {_damage = 0; player playMoveNow "Incapacitated"; [] spawn { sleep 1; life_dueling = false};};
_curWep = if(isPlayer _source && {_source isKindOf "Man"}) then {currentWeapon _source} else {""};
/* Stun grenades*/
if (_projectile in ["mini_Grenade","G_40mm_HE"]) then {
	_damage = 0;
	[] spawn life_fnc_handleFlashbang;
};

if(_curWep in ["hgun_P07_snds_F","arifle_SDAR_F"] && {((_source getVariable["bountyHunter",false]) || (side _source == west))} && {_projectile in["B_9x21_Ball","B_556x45_dual"]}) then
{
	_damage = 0;
	if(!(player getVariable["unconscious",false]) && {!(side _source == west && playerSide == west)}) then
	{
		[player,_source] spawn life_fnc_tazed;
	};
};
if((vehicle player) isKindOf "Car" && {isNull _source || _source == player}) then
{
	if(life_seatbelt) then { _damage = _damage * 0.75 };
};
if(vehicle _source isKindOf "LandVehicle" && {driver (vehicle _source) == _source}) then
{
	_damage = 0;
	player setDamage 0;
};
if(_sel == "") then
{
	if(_source getVariable["lethal",false] && {player getVariable["unconscious",false]} && {_source != player} && {lethal_death}) exitWith {
		player setVariable["executed",true,true];
		_source setVariable["lethal",false,true]; 
		if(side player != west) then {
			[getPlayerUID _source,name _source,"187",[player getVariable["realname",name player],getPos player,"lethal bullet"]] remoteExec ["life_fnc_wantedAdd",2]; 
		} else {
			[getPlayerUID _source,name _source,"187A",[player getVariable["realname",name player],getPos player,"lethal bullet"]] remoteExec ["life_fnc_wantedAdd",2]; 
		};
		[2,"You are a murderer"] remoteExecCall ["life_fnc_broadcast",_source];
		_damage = 1;
	};
	if ((((getDammage player) + _damage)/2) > 0.999 || _damage > 0.999) then
	{
		_damage = 0;
		if(!(player getVariable ["unconscious", false])) then 
		{
			if(vehicle _source isKindOf "LandVehicle" && {driver (vehicle _source) == _source}) then
			{
				[_source,false,true] spawn life_fnc_handleDowned;
			} else {
				if(isNull _source || _source == player) then
				{
					if(!(life_isdowned)) then {
						player setVariable["unconscious",true,true];
						[] spawn life_fnc_unconscious;
						[0,format["%1 was critically wounded by an environmental collision.", player getVariable["realname",name player]]] remoteExec ["life_fnc_broadcast",0];
					};
				} else {
					_silencer = if(isPlayer _source && {!(["B_127",_projectile] call BIS_fnc_InString || ["minigun",_projectile] call BIS_fnc_InString)}) then {_source weaponAccessories currentMuzzle _source select 0} else {""};
					_hasSilencer = !isNil "_silencer" && {_silencer != ""};
					if ((side _source == west || _source getVariable["bountyHunter",false]) && {(_hasSilencer || currentWeapon _source in ["arifle_SDAR_F","SMG_02_F","srifle_DMR_04_F"])}) then {
						[_source] spawn life_fnc_handleDowned;
					} else {
						player setVariable["unconscious",true,true];
						_variable = _projectile call {
							if(_this == "B_9x21_Ball") exitWith {"mm"};
							if(["B_45A",_this] call BIS_fnc_inString) exitWith {"acp"};
							if(["65x39",_this] call BIS_fnc_InString) exitWith {"heavy"};
							if(["B_556",_this] call BIS_fnc_InString) exitWith {"rifle"};
							if(["B_762",_this] call BIS_fnc_InString) exitWith {"sniper"};
							if(["B_127",_this] call BIS_fnc_InString) exitWith {"fucked"};
						};
						player setVariable[_variable,true];
						[] spawn life_fnc_unconscious;
						if(side _source == civilian && {side player != west} && {!life_paintBalling} && {!life_dueling}) then {
							_code = if(life_governor) then {"Ass"} else {"245"};
							[getPlayerUID _source,name _source,_code,[player getVariable["realname",name player],getPos player,_curWep]] remoteExec ["life_fnc_wantedAdd",2];
						} else {
							if(side _source == civilian && {side player == west}) then {
								[getPlayerUID _source,name _source,"245A",[player getVariable["realname",name player],getPos player,_curWep]] remoteExec ["life_fnc_wantedAdd",2];
							} else {
								if(side _source == west && {playerSide != west}) then {
									player setVariable ["shotByCop",true,true];
									life_copRecieve = _source;
								};
							};
						};
						[0,format["%1 was critically wounded by %2", player getVariable["realname",name player],_source getVariable["realname",name _source]]] remoteExec ["life_fnc_broadcast",0];
						player setVariable["arrowToTheKnee",true,true];
					};
				};
			};
		};
	};
}
else
{
	_ghp = switch (_sel) do
	{
		case "face_hub": { "HitFace" };
		case "neck": { "HitNeck" };
		case "head": { "HitHead" };
		case "pelvis": { "HitPelvis" };
		case "spine1": { "HitAbdomen" };
		case "spine2": { "HitDiaphragm" };
		case "spine3": { "HitChest" };
		case "body": { "HitBody" };
		case "arms": { "HitArms" };
		case "hands": { "HitHands" };
		case "legs": { "HitLegs" };		
		default {""};
	};
	if(_ghp in ["HitLegs","HitHands","HitArms"]) exitWith {};
	if (_ghp != "" && {(((player getHitPointDamage _ghp) + _damage) / 2) > 0.999 || _damage > 0.999}) then
	{
		player setHitPointDamage [_ghp,0.999];
		[player,"",1,_source,_projectile] call life_fnc_handleDamage;
		_damage = 0;
	};

};
_damage;