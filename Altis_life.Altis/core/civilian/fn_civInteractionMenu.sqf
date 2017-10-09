/*
	File: fn_copInteractionMenu.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Replaces the mass addactions for various civilian actions towards another player.
*/
#define Txt1 37450
#define Btn1 37451
#define Btn2 37452
#define Btn3 37453
#define Btn4 37454
#define Btn5 37455
#define Btn6 37456
#define Btn7 37457
//#define Btn8 37458

#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_Btn9"];

if(!dialog) then {
	createDialog "STS_cInteraction_Menu";
};
disableSerialization;

_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target*/
if(!isPlayer _curTarget && side _curTarget == civilian && side _curTarget == west) exitWith {closeDialog 0;}; /*Bad side check?*/
/*Can't interact while restrained or dead*/
if (player getVariable["zipTie",false] || player getVariable["restrained",false] || !isNil "surrender" || player getVariable ["unconscious",false]) exitWith {closeDialog 0;};

if (playerSide == west || playerSide == independent) exitWith {closeDialog 0;};


_display = findDisplay 37400;
_tName = _display displayCtrl Txt1;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
/*
_Btn8 = _display displayCtrl Btn8;
_Btn9 = _display displayCtrl Btn9;
*/

private["_tRest","_tZip","_tUnc","_tEsc","_tSur","_tKout"];
_tRest = _curTarget getVariable ["restrained",false];
_tZip = _curTarget getVariable ["zipTie",false];
_tUnc = _curTarget getVariable ["unconscious",false];
_tEsc = _curTarget getVariable ["Escorting",false];
_tSur = (animationState _curTarget == "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon");
_tBlind = _curTarget getVariable ["blindfolded",false];
_tTaze = _curTarget getVariable ["tazed",false];
_tDown = _curTarget getVariable ["downed",false];
if (animationState _curTarget == "Incapacitated") then { _tKout = true; } else { _tKout = false; };

life_pInact_curTarget = _curTarget;



/*Set target name text*/
_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
if((headgear _curTarget) in _headgear || (goggles _curTarget) in _goggles) then {
	_tName ctrlSetText "Masked Man";
} else {
	_tName ctrlSetText (_curTarget getVariable["realname",name _curTarget]);
};
/*Button 1: Restrain / unrestrain || Stabilise*/
if (_tUnc) then {
	if("Medikit" in (items player) || "FirstAidKit" in (items player) || life_inv_medkit > 0) then { _Btn1 ctrlEnable true; } else { _Btn1 ctrlEnable false; };
	
	_Btn1 ctrlSetText localize "STR_pInAct_Stabilise";
	_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_stabilise; closeDialog 0;";
} else {
	if((_tZip || _tKout || _tSur || _tTaze || _tDown || _tUnc) && !(currentWeapon player in ["","Binocular","Rangefinder"])) then { _Btn1 ctrlEnable true; } else { _Btn1 ctrlEnable false; };
	if (_tZip) then {
		_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
		_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_unzip; closeDialog 0;";
	} else {
		_Btn1 ctrlSetText localize "STR_pInAct_Restrain";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_zipTie; closeDialog 0;";
	};
};


/*Button 2: Escort || Drag*/
if(_tUnc) then {
	if(!(player getVariable["isDragging",false])) then { _Btn2 ctrlEnable true; } else { _Btn2 ctrlEnable false; };
	
	_Btn2 ctrlSetText localize "STR_pInAct_Drag";
	_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_drag; closeDialog 0;";
} else {
	if(_tEsc) then {
		_Btn2 ctrlSetText localize "STR_pInAct_StopEscort";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; closeDialog 0;";
	} else {
		if(_tZip) then {
		_Btn2 ctrlSetText localize "STR_pInAct_Escort";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
		} else {
			_Btn2 ctrlSetText localize "STR_pInAct_Escort";
			_Btn2 ctrlEnable false; 
		};
	};
};


/*Button 3: Put in Vehicle*/
if(_tEsc || _tUnc || _tZip) then { _Btn3 ctrlEnable true; } else { _Btn3 ctrlEnable false; };

_Btn3 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar; closeDialog 0;";


/*Button 4: Rob person || Execute*/
if(_tUnc) then {
	if(license_civ_rebel && (primaryWeapon player != "" || handGunWeapon player != "") && life_inv_lethali > 0) then { _Btn4 ctrlEnable true; } else { _Btn4 ctrlEnable false; };
	
	_Btn4 ctrlSetText localize "STR_pInAct_Execute";
	_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_execute; closeDialog 0;";
} else {
	if((_tZip || _tSur || _tKout) && !_tEsc && (primaryWeapon player != "" || handGunWeapon player != "")) then { _Btn4 ctrlEnable true; } else { _Btn4 ctrlEnable false; };
	
	_Btn4 ctrlSetText localize "STR_pInAct_RobPerson";
	_Btn4 buttonSetAction "player playMove 'AinvPknlMstpSnonWnonDnon_medic1'; [life_pInact_curTarget] call life_fnc_robAction; closeDialog 0;";
};
	
/*Button 5 blindfolding || body looting*/
if(_tBlind) then {
	_Btn5 ctrlSetText "Remove Blindfold";
	_Btn5 buttonSetAction "[life_pInact_curTarget] call life_fnc_blindfoldRemove; closeDialog 0;";
} else {
	if(_tZip) then {
		_Btn5 ctrlSetText "Blindfold";
		_Btn5 buttonSetAction "[life_pInact_curTarget] call life_fnc_blindfold; closeDialog 0;";
	} else {
		if(_tUnc) then {
			_Btn5 ctrlSetText "Loot Body";
			_Btn5 buttonSetAction "player playMove 'AinvPknlMstpSnonWnonDnon_medic1'; [life_pInact_curTarget] call life_fnc_robAction; closeDialog 0;";
			if(currentWeapon player in["","Rangefinder","Binocular"]) then { _Btn5 ctrlEnable false; };
		} else {
			_Btn5 ctrlShow false;
		};
	};
};

if(_tZip && !(_curTarget getVariable["reZipped",false])) then {
	_Btn6 ctrlSetText "ReZip";
	_Btn6 buttonSetAction "life_pInact_curTarget setVariable[""reZipped"",true,true]; hint ""Target's zip-ties successfully tightened, they should last at least another 10 minutes"";";
} else {
	_Btn6 ctrlShow false;
};
if((_tZip || _tSur) && (primaryWeapon _curTarget != "" || handgunWeapon _curTarget != "") && !(currentWeapon player in["","Rangefinder","Binocular"]) && !_tUnc) then {
	_Btn7 ctrlSetText "Rob Weapon";
	_Btn7 buttonSetAction "closeDialog 0; titletext['Targets weapons dropped to the ground','PLAIN']; [player,true] remoteExecCall ['life_fnc_seizePlayerWeaponAction',life_pInact_curTarget]";
} else {_Btn7 ctrlShow false};