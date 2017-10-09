/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Blasting charge is used for the federal reserve vault and nothing  more.. Yet.
*/
private["_vault","_handle"];
_vault = param [0,ObjNull,[ObjNull]];
if(isNull _vault) exitWith {}; /*Bad object*/
if(_vault getVariable["security",0] == 3) exitWith { [cursorTarget] spawn life_fnc_copBreakDoor };
if((_vault isKindOf "House_F") && _vault getVariable["security",0] < 3) exitWith { hint "That blasting charge seems like a bit of over kill for this simple door."};
if(typeOf _vault == "Land_CargoBox_V1_F" && time - (fed_bank getVariable ["cooldown",time]) < 5400) exitWith {hint "The federal bank was robbed too recently!";};
if(typeOf _vault != "Land_CargoBox_V1_F" && typeOf _vault != "Land_Cargo40_Yellow_F") exitWith {hint "You may only use this at the federal reserve or the jail.";};
if(_vault getVariable["chargeplaced",false]) exitWith {hint "A charge has already been placed on this object!";};
if(_vault getVariable["safe_open",false]) exitWith {hint localize "STR_ISTR_Blast_AlreadyOpen"};
_int = 0;
{
    if(side _x == west) then {_int = _int + (_x getVariable["rank",0])};
} forEach playableUnits;
if(playersNumber west < 9 || _int < 9) exitWith {hint "There are not enough police online to complete this action!"; };
if(!([false,"blastingcharge",1] call life_fnc_handleInv)) exitWith {}; /*Error?*/

/*Begin bank robbery*/
if(typeOf _vault == "Land_CargoBox_V1_F") then {
	if(player distance (markerPos "fed_reserve") > 100) exitWith {};
	[getPlayerUID player,profileName,"906"] remoteExec ["life_fnc_wantedAdd",2];
	_vault setVariable["chargeplaced",true,true];
	[1,localize "STR_ISTR_Blast_Placed"] remoteExec ["life_fnc_broadcast",west];
	hint localize "STR_ISTR_Blast_KeepOff";
	_handle = [true] spawn life_fnc_demoChargeTimer;
	[true] remoteExec ["life_fnc_demoChargeTimer",west];
	[_vault, "bank_alarm",50] remoteExec ["life_fnc_playSound",0];

	waitUntil {scriptDone _handle};
	sleep 0.9;
	if(!(fed_bank getVariable["chargeplaced",false])) exitWith {
		hint "The charge has been defused, cops win!"; 
		fed_bank setVariable["safe_open",false,true];
		fed_bank setVariable["cooldown",time,true];
	};

	_charge = "Bo_GBU12_LGB_MI10" createVehicle [getPosATL fed_bank select 0, getPosATL fed_bank select 1, (getPosATL fed_bank select 2)];
	_charge setPosATL [getPosATL fed_bank select 0, getPosATL fed_bank select 1, (getPosATL fed_bank select 2)];
	fed_bank setVariable["chargeplaced",false,true];
	fed_bank setVariable["safe_open",true,true];

	hint localize "STR_ISTR_Blast_Opened";
	[fed_bank,ObjNull,1] remoteExec ["TON_fnc_blastingChargeMonitor",2];
/*Begin jail break next*/
}
else
{
	if(time - (_vault getVariable["cooldown",0]) < 900) exitWith {hint format["The jail was broken into too recently, try again in about %1 minutes",ceil(15 - ((time - (_vault getVariable["cooldown",0]))/60))]};
	_vault setvariable["cooldown",time,true];
	[getPlayerUID player,profileName,"460"] remoteExec ["life_fnc_wantedAdd",2];
	_vault setVariable["chargeplaced",true,true];
	[1,"A charge has been planted on the wall of the jail!"] remoteExec ["life_fnc_broadcast",west];
	hint "You have planted the charge, don't let the cops defuse it!";
	_handle = [] spawn life_fnc_demoChargeTimer;
	[] remoteExec ["life_fnc_demoChargeTimer",west];
	[_vault, "bank_alarm",50] remoteExec ["life_fnc_playSound",0];

	waitUntil {scriptDone _handle};
	sleep 0.9;
	if(!(Jail_Target getVariable["chargeplaced",false])) exitWith {hint "The charge was defused before it could detonate!";};

	_charge = "Bo_GBU12_LGB_MI10" createVehicle [getPosATL Jail_Target select 0, getPosATL Jail_Target select 1, (getPosATL Jail_Target select 2)];
	_charge setPosATL [getPosATL Jail_Target select 0, getPosATL Jail_Target select 1, (getPosATL Jail_Target select 2)];
	_charge spawn {
		waitUntil {isNull _this};
		Jail_Target setVariable["jailBreak",true,true];
	};
	Jail_Target setVariable["chargeplaced",false,true];
	Jail_Target setpos [10,10,0];


	hint "The jail wall has been broken! 45 seconds until it regenerates completely!";

	[Jail_Target,jailRef,0] remoteExec ["TON_fnc_blastingChargeMonitor",2];
};