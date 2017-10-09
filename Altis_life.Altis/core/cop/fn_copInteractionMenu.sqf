/*
	File: fn_copInteractionMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Replaces the mass addactions for various cop actions towards another player.
*/
#define Title 37401
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Btn9 37458
#define Btn10 37459

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn9","_Btn10","_headgear","_goggles"];
_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
if(!dialog) then {
	createDialog "STS_pInteraction_Menu";
};

disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target*/
	
if(!isPlayer _curTarget && side _curTarget == civilian) exitWith {closeDialog 0;}; /*Bad side check?*/
_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
_Btn9 = _display displayCtrl Btn9;
_Btn10 = _display displayCtrl Btn10;
life_pInact_curTarget = _curTarget;

/*Button 1: Restrain / unrestrain || Stabilise*/
if (_curTarget getVariable ["unconscious",false]) then {
	if("Medikit" in (items player) || "FirstAidKit" in (items player) || life_inv_medkit > 0) then { _Btn1 ctrlEnable true; } else { _Btn1 ctrlEnable false; };
	
	_Btn1 ctrlSetText localize "STR_pInAct_Stabilise";
	_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_stabilise; closeDialog 0;";
} else {
	if(life_pInact_curTarget getVariable ["restrained",false]) then {
		_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
		_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_unrestrain; closeDialog 0; closeDialog 0;";
	} else {
		if(life_pInact_curTarget getVariable ["zipTie",false]) then {
			_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
			_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_unzip; closeDialog 0;";
		} else {
			_Btn1 ctrlSetText localize "STR_pInAct_Restrain";
			_Btn1 buttonSetAction "if(animationState player != ""incapacitated"") then { [life_pInact_curTarget] call life_fnc_restrainAction; }; closeDialog 0;";
		};
	};
};
/*Set Check Licenses Button*/
_Btn2 ctrlSetText localize "STR_pInAct_checkLicenses";
_Btn2 buttonSetAction "[player] remoteExec [""life_fnc_licenseCheck"",life_pInact_curTarget,FALSE]";

/*Set Search Button*/
_Btn3 ctrlSetText localize "STR_pInAct_SearchPlayer";
_Btn3 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_searchAction; closeDialog 0;";
if (call life_coplevel == 0) then { _Btn3 ctrlEnable false; };

/*Escort & Drag*/
if(_curTarget getVariable ["unconscious",false]) then {
	if(!(player getVariable["isDragging",false])) then { _Btn4 ctrlEnable true; } else { _Btn4 ctrlEnable false; };
	
	_Btn4 ctrlSetText localize "STR_pInAct_Drag";
	_Btn4 buttonSetAction "[life_pInact_curTarget] call life_fnc_drag; closeDialog 0;";
} else {
	if((_curTarget getVariable["Escorting",false])) then {
		_Btn4 ctrlSetText localize "STR_pInAct_StopEscort";
		_Btn4 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; closeDialog 0;";
	} else {
		if((_curTarget getVariable["restrained",false]) || (_curTarget getVariable["zipTie",false])) then {
			_Btn4 ctrlSetText localize "STR_pInAct_Escort";
			_Btn4 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
		} else {
			_Btn4 ctrlSetText localize "STR_pInAct_Escort";
			_Btn4 ctrlEnable false;
		};
	};
};

/*Set Ticket Button*/
_Btn5 ctrlSetText localize "STR_pInAct_TicketBtn";
_Btn5 buttonSetAction "[life_pInact_curTarget] call life_fnc_ticketAction;";
if(side life_pInact_curTarget == west) then { _Btn5 ctrlEnable false; };
if (call life_coplevel == 0) then { _Btn5 ctrlEnable false; };

_Btn6 ctrlSetText localize "STR_pInAct_Arrest";
_Btn6 buttonSetAction "[life_pInact_curTarget] call life_fnc_arrestAction;";
if(!(_curTarget getVariable["restrained",false] || _curTarget getVariable["zipTie",false])) then { _Btn6 ctrlEnable false; };
if (call life_coplevel == 0) then { _Btn6 ctrlEnable false; };

_Btn7 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn7 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar; closeDialog 0;";
if (!(_curTarget getVariable["restrained",false]) && !(_curTarget getVariable["unconscious",false]) && !(_curTarget getVariable["zipTie",false])) then {
_Btn7 ctrlEnable false;
};

/*seizing weapons*/
if((_curTarget getVariable ["unconscious",false])) then { _Btn8 ctrlEnable false; };
if (call life_coplevel == 0) then { _Btn8 ctrlEnable false; };
_Btn8 ctrlSetText "Seize Weapons";
_Btn8 buttonSetAction "[life_pInact_curTarget] call life_fnc_seizePlayerWeapon; closeDialog 0;";

if(!(_curTarget getVariable ["restrained",false]) && !(_curTarget getVariable["zipTie",false])) then {
	_Btn8 ctrlEnable false;
};

/*revoke license*/
_Btn9 ctrlSetText "Revoke Drivers License";
_Btn9 buttonSetAction "[life_pInact_curTarget] call life_fnc_revokeLicense; closeDialog 0;";

/*Check that you are near a place to jail them.*/
if(!((player distance (getMarkerPos "jail_marker") < 50) OR (player distance (getMarkerPos "cop_spawn_1") < 50) OR  (player distance (getMarkerPos "cop_spawn_2") < 50) OR (player distance (getMarkerPos "cop_spawn_3") < 50) OR (player distance (getMarkerPos "cop_spawn_4") < 50) OR (player distance (getMarkerPos "cop_spawn_5") < 50) OR (player distance (getMarkerPos "cop_spawn_6") < 50))) then 
{
	_Btn6 ctrlEnable false;
};

/*remove mask*/
_Btn10 ctrlSetText "Remove Mask";
_Btn10 buttonSetAction "[life_pInact_curTarget] call life_fnc_removeMask; closeDialog 0;";
if((!(headGear _curTarget in _headgear) && !(goggles _curTarget in _goggles)) || !(_curTarget getvariable["restrained",false] || _curTarget getVariable["zipTie",false])) then { _Btn10 ctrlEnable false; };