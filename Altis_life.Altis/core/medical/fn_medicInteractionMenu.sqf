/*
	File: fn_medicInteractionMenu.sqf
	Author: Skeith
	
	Description:
	Replaces the mass addactions for various medic actions towards another player.
*/
#define Txt1 37450
#define Btn1 37451
#define Btn2 37452
#define Btn3 37453
#define Btn4 37454
#define Btn5 37455
/*
#define Btn6 37456
#define Btn7 37457
#define Btn8 37458
*/
#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2"];

if(!dialog) then {
	createDialog "STS_mInteraction_Menu";
};
disableSerialization;

_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target
if(!isPlayer _curTarget && side _curTarget == civilian) exitWith {closeDialog 0;}; /*Bad side check?*/
/*Can't interact while restrained or dead*/
if (player getVariable["zipTie",false] || player getVariable["restrained",false] || !isNil "surrender") exitWith {closeDialog 0;};
/*Double check player side*/
if (playerSide != independent) exitWith {closeDialog 0;};
if (life_reviving) exitWith {closeDialog 0;};


_display = findDisplay 37400;
_tName = _display displayCtrl Txt1;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
/*
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
*/

private["_tUnc"];
_tUnc = _curTarget getVariable ["unconscious",false];

life_pInact_curTarget = _curTarget;

/*Can't interact with the healthy*/
if (!_tUnc) exitWith {closeDialog 0;};

/*Range check DOES NOT WORK
while {dialog} do {
	if (_curTarget distance player > 5) then {
		closeDialog 0;
	};
};*/

/*Set target name text*/
_tName ctrlSetText (_curTarget getVariable["realname",name _curTarget]);

/*Button 1: Revive*/
_Btn1 ctrlSetText localize "STR_pInAct_Revive";
_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_revive; closeDialog 0;";


/*Button 2: Drag*/
if(!(player getVariable["isDragging",false])) then { _Btn2 ctrlEnable true; } else { _Btn2 ctrlEnable false; };

_Btn2 ctrlSetText localize "STR_pInAct_Drag";
_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_drag; closeDialog 0;";

/*Button 3: Stabilise*/
_Btn3 ctrlSetText localize "STR_pInAct_Stabilise";
_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_stabilise; closeDialog 0;";

/*Button 4: Examine Player*/
_Btn4 ctrlSetText localize "STR_pInAct_Examine";
_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_searchAction; closeDialog 0;";

/*Button 5: Load into car*/
_Btn5 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn5 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar; closeDialog 0;";