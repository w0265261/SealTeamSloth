/*
	File: initPlayerLocal.sqf
	
	Description:
	Starts the initialization of the player.
*/
if(!hasInterface) exitWith {[] call compile PreprocessFileLineNumbers "\life_server\fn_initHC.sqf";};
#define __CONST__(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
[] execVM "core\init.sqf";

/*Execute JIP code.*/
if((_this select 1)) then {
	[] execVM "core\jip.sqf";
};