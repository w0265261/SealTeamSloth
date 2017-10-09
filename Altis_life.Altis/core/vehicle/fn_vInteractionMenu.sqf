/*
	File: fn_vInteractionMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Replaces the mass addactions for various vehicle actions
*/
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8"];
if(!dialog) then {
	createDialog "STS_vInteraction_Menu";
};
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target*/
_isVehicle = if((_curTarget isKindOf "landVehicle") OR (_curTarget isKindOf "Ship") OR (_curTarget isKindOf "Air")) then {true} else {false};
if(!_isVehicle) exitWith {closeDialog 0;};
_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
life_vInact_curTarget = _curTarget;

/*Set Repair Action*/
_Btn1 ctrlSetText localize "STR_vInAct_Repair";
_Btn1 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_repairTruck;";

if(damage _curTarget < 1) then {_Btn1 ctrlEnable true;} else {_Btn1 ctrlEnable false;};

if(playerSide == west) then {
	if(!(life_vInact_curTarget in life_vehicles)) then {
		_Btn2 ctrlSetText localize "STR_vInAct_Registration";
		_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_searchVehAction;";
	} else {
		_Btn2 ctrlSetText "Designate Unit";
		_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_setUnitNumber;";
	};
	_Btn3 ctrlSetText localize "STR_vInAct_SearchVehicle";
	_Btn3 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_vehInvSearch;";
	
	_Btn4 ctrlSetText localize "STR_vInAct_PullOut";
	_Btn4 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_pulloutAction;";
	if(count crew _curTarget == 0 || speed _curTarget > 10) then {_Btn4 ctrlEnable false;};
	
	if(_curTarget isKindOf "Ship") then {
		_Btn6 ctrlSetText localize "STR_vInAct_PushBoat";
		_Btn6 buttonSetAction "[] spawn life_fnc_pushObject; closeDialog 0;";
		if(_curTarget isKindOf "Ship" && {count crew _curTarget == 0}) then { _Btn6 ctrlEnable true;} else {_Btn6 ctrlEnable false};
	} else {
		if(typeOf (_curTarget) in ["C_Kart_01_F"]) then {
			_Btn6 ctrlSetText localize "STR_vInAct_GetInKart";
			_Btn6 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
			if(count crew _curTarget == 0 && {canMove _curTarget} && {locked _curTarget == 0}) then {_Btn6 ctrlEnable true;} else {_Btn6 ctrlEnable false};
		} else {
			_Btn6 ctrlSetText localize "STR_vInAct_Unflip";
			_Btn6 buttonSetAction "life_vInact_curTarget setPos [getPos life_vInact_curTarget select 0, getPos life_vInact_curTarget select 1, (getPos life_vInact_curTarget select 2)+0.5]; closeDialog 0;";
			if(count crew _curTarget == 0) then { _Btn6 ctrlEnable true;} else {_Btn6 ctrlEnable false;};
		};
	};
	
} else {
	if(playerSide == independent) then {
		_Btn2 ctrlSetText localize "STR_vInAct_Registration";
		_Btn2 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_searchVehAction;";
	} else {
	if(_curTarget isKindOf "Ship") then {
		_Btn2 ctrlSetText localize "STR_vInAct_PushBoat";
		_Btn2 buttonSetAction "[] spawn life_fnc_pushObject; closeDialog 0;";
		if(_curTarget isKindOf "Ship" && {local _curTarget} && {count crew _curTarget == 0}) then { _Btn2 ctrlEnable true;} else {_Btn2 ctrlEnable false};
	} else {
		if(typeOf (_curTarget) in ["C_Kart_01_Blu_F","C_Kart_01_Red_F","C_Kart_01_Fuel_F","C_Kart_01_Vrana_F"]) then {
			_Btn2 ctrlSetText localize "STR_vInAct_GetInKart";
			_Btn2 buttonSetAction "player moveInDriver life_vInact_curTarget; closeDialog 0;";
			if(count crew _curTarget == 0 && {canMove _curTarget} && {locked _curTarget == 0}) then {_Btn2 ctrlEnable true;} else {_Btn2 ctrlEnable false};
		} else {
			_Btn2 ctrlSetText localize "STR_vInAct_Unflip";
			_Btn2 buttonSetAction "life_vInact_curTarget setVectorUp[0,0,1]; closeDialog 0;";
			if(!(_curTarget in life_vehicles)) then { _Btn2 ctrlEnable false;} else {_Btn2 ctrlEnable true;};
		};
	};
	};
	/*Button 3: Pull out of Vehicle*/
	if(playerSide == civilian && primaryWeapon player == "" && handGunWeapon player == "") then {_Btn3 ctrlEnable false;};
	if(count crew _curTarget == 0 || speed _curTarget > 10) then {_Btn3 ctrlEnable false;};
	_Btn3 ctrlSetText localize "STR_vInAct_PullOut";
	_Btn3 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_pulloutAction; closeDialog 0;";
	if(playerSide == independent) then {
		_Btn4 ctrlSetText localize "STR_vInAct_Unflip";
		_Btn4 buttonSetAction "life_vInact_curTarget setPos [getPos life_vInact_curTarget select 0, getPos life_vInact_curTarget select 1, (getPos life_vInact_curTarget select 2)+0.5]; closeDialog 0;";
		if(count crew _curTarget == 0 && _curTarget in life_vehicles) then { _Btn4 ctrlEnable true;} else {_Btn4 ctrlEnable false;};
	} else {
		
	if(!(typeOf _curTarget in["O_Truck_03_fuel_F","B_Truck_01_fuel_F","C_Van_01_fuel_F","O_Truck_03_device_F"])) then { _Btn4 ctrlShow false;};
	
	if(typeOf _curTarget == "O_Truck_03_device_F") then {
		_Btn4 ctrlSetText "Auto Mine";
		_Btn4 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_deviceMine";
		if(!isNil {(_curTarget getVariable "mining")} OR !(_curTarget in life_vehicles)) then {
			_Btn4 ctrlEnable false;
		} else {
			_Btn4 ctrlEnable true;
		};
	};
	if(typeOf _curTarget in["O_Truck_03_fuel_F","B_Truck_01_fuel_F","C_Van_01_fuel_F"]) then {
		_Btn4 ctrlSetText "Drill for Oil";
		_Btn4 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_oilDrill";
		if(!isNil {(_curTarget getVariable "mining")} OR !local _curTarget && {_curTarget in life_vehicles}) then {
			_Btn4 ctrlEnable false;
		} else {
			_Btn4 ctrlEnable true;
		};
	};
	};
	if(playerSide == civilian && !(_curTarget in life_vehicles)) then {
		_Btn5 ctrlSetText "Purchase";
		_Btn5 buttonSetAction "[life_vInact_curTarget,true] spawn life_fnc_buyPlayerHouse;";
	} else { _Btn5 ctrlShow false; };
	_Btn6 ctrlShow false;
	_Btn7 ctrlshow false;
};

if(playerSide in [west]) then {
	_Btn5 ctrlShow true;
	_Btn5 ctrlEnable true;
	_Btn5 ctrlSetText localize "STR_vInAct_Impound";
	_Btn5 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_impoundAction;";
};

if(playerSide in [west]) then {
	_Btn7 ctrlShow true;
	_Btn7 ctrlEnable true;
	_Btn7 ctrlSetText "Crush";
	_Btn7 buttonSetAction "[life_vInact_curTarget] spawn life_fnc_copCrush;";
	_Btn8 ctrlShow true;
	_Btn8 ctrlEnable true;
	_Btn8 ctrlSetText "Remove Weapons";
	_Btn8 buttonSetAction "[life_vInact_curTarget] call life_fnc_seizeVehicleWeapon;";
} else {
	_Btn7 ctrlShow false;
	_Btn8 ctrlShow false;
};