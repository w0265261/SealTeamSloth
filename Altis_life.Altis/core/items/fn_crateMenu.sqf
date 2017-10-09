#include <macro.h>
/*
file: fn_crateMenu.sqf
Author: Kevin Webb
Description: Interaction menu for storage crates
*/
#define Btn1 37451
#define Btn2 37452

#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2"];
if(!dialog) then {
	createDialog "STS_crateInteraction_Menu";
};
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target*/

_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;

_Btn1 ctrlShow false;
_Btn2 ctrlShow false;

life_pInact_curTarget = _curTarget;

_Btn1 ctrlSetText "Drag/Drop";
if(_curTarget getVariable["Escorting",false]) then {
_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; closeDialog 0;";
} else {
	_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
};
_Btn1 ctrlShow true;
if(!(player getVariable["myCrate",false]) && life_DPBox != _curTarget) then { _Btn1 ctrlEnable false; };

_Btn2 ctrlSetText "Destroy Crate";
_Btn2 buttonSetAction "[life_pInAct_curTarget] call life_fnc_handleCrate; closeDialog 0;";
if(__GETC__(style) > 0) then {
_Btn2 ctrlShow true; };