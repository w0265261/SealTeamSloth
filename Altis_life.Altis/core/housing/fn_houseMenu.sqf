/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Building interaction menu
*/
#define Btn1 37451
#define Btn2 37452
#define Btn3 37453
#define Btn4 37454
#define Btn5 37455
#define Btn6 37456
#define Btn7 37457
#define Btn8 37458
/*
#define Btn8 37458
*/
#define Title 37401

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7"];
if(!dialog) then {
	createDialog "STS_hInteraction_Menu";
};
disableSerialization;
_curTarget = param [0,ObjNull,[ObjNull]];
if(isNull _curTarget) exitWith {closeDialog 0;}; /*Bad target*/
if(player distance gang_flag_1 < 100 || player distance ([14545.1,18825.9,0.124786]) < 50 || player distance capture_pole_3 < 75) exitWith {closeDialog 0;}; /*Gang Hideout 2, Meth Cartel, and Weed Processing*/

_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
_Btn1 ctrlShow false;
_Btn2 ctrlShow false;
_Btn3 ctrlShow false;
_Btn4 ctrlShow false;
_Btn5 ctrlShow false;
_Btn6 ctrlShow false;
_Btn7 ctrlShow false;
_Btn8 ctrlShow false;
life_pInact_curTarget = _curTarget;
if(playerSide == west) exitWith {
	if(typeOf _curTarget == "Land_MilOffices_V1_F") then {
		
		_Btn1 ctrlSetText "Lock Door";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_repairDoor; closeDialog 0;";
		_Btn1 ctrlShow true;
		
		_Btn2 ctrlSetText "Unlock Door";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_doorAnimate; closeDialog 0;";
		_Btn2 ctrlShow true;
		
	} else {
		if(!isNil {_curTarget getVariable "house_owner"}) then {
			_Btn1 ctrlSetText localize "STR_House_Raid_Owner";
			_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_copHouseOwner;";
			_Btn1 ctrlShow true;
			
			_Btn2 ctrlSetText "Breach";
			_Btn2 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_copBreakDoor; closeDialog 0;";
			_Btn2 ctrlShow true;
			
			_Btn3 ctrlSetText localize "STR_pInAct_SearchHouse";
			_Btn3 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_raidHouse; closeDialog 0;";
			_Btn3 ctrlShow true;
			
			if(player distance _curTarget > 3.6) then {
				_Btn3 ctrlEnable false;
			};
			
			_Btn4 ctrlSetText localize "STR_pInAct_LockHouse";
			_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_lockupHouse; closeDialog 0;";
			_Btn4 ctrlShow true;
			
			_Btn5 ctrlSetText "Inventory";
			_Btn5 buttonSetAction "closeDialog 0; life_pInAct_curTarget spawn life_fnc_storageBox";
			_Btn5 ctrlShow true;
			if(_curTarget getVariable["locked",true]) then {
				_Btn5 ctrlEnable false;
			};
		} else {
			closeDialog 0;
		};
	};
};
_houseCfg = [(typeOf _curTarget)] call life_fnc_houseConfig;
if(_houseCfg isEqualTo []) exitWith {closeDialog 0;};

if(!(_curTarget in life_vehicles)) then {

	if(isNil {_curTarget getVariable "house_owner"}) then {
		_Btn1 ctrlSetText localize "STR_pInAct_BuyHouse";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_buyHouse;";
		_Btn1 ctrlShow true;
	} else {
		_Btn1 ctrlSetText "Send Buy Req.";
		_Btn1 buttonSetAction "[life_pInAct_curTarget] spawn life_fnc_buyPlayerHouse;";
		_Btn1 ctrlShow true;		
	};
	
	if(!(_curTarget getVariable["locked",true])) then {
		_Btn2 buttonSetAction "closeDialog 0; life_pInAct_curTarget spawn life_fnc_storageBox";
		_Btn2 ctrlSetText "Inventory";
		_Btn2 ctrlShow true;
	};
} else {
	if((typeOf _curTarget) in ["Land_i_Garage_V1_F","Land_i_Garage_V2_F"]) then {
		_Btn1 ctrlSetText localize "STR_pInAct_SellGarage";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_sellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;
		
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn1 ctrlEnable false;
		};
		
		_Btn2 ctrlSetText localize "STR_pInAct_AccessGarage";
		_Btn2 buttonSetAction "[life_pInact_curTarget,""Car""] spawn life_fnc_vehicleGarage; life_myGarage = true; closeDialog 0;";
		_Btn2 ctrlShow true;
		
		_Btn3 ctrlSetText localize "STR_pInAct_StoreVeh";
		_Btn3 buttonSetAction "[life_pInact_curTarget,player] spawn life_fnc_storeVehicle; closeDialog 0;";
		_Btn3 ctrlShow true;
		
		_Btn4 ctrlSetText "Lease Management";
		_Btn4 buttonSetAction "createDialog ""STS_Life_lease"";";
		_Btn4 ctrlShow true;
		if(_curTarget getVariable "house_owner" select 0 != getPlayerUID player) then {
			_Btn4 ctrlEnable false;
		};
	} else {
		_Btn1 ctrlSetText localize "STR_pInAct_SellHouse";
		_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_sellHouse; closeDialog 0;";
		_Btn1 ctrlShow true;
		
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn1 ctrlEnable false;
		};
		
		if(_curTarget getVariable ["locked",false]) then {
			_Btn2 ctrlSetText localize "STR_pInAct_UnlockStorage";
		} else {
			_Btn2 ctrlSetText localize "STR_pInAct_LockStorage";
		};
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_lockHouse; closeDialog 0;";
		_Btn2 ctrlShow true;
		
		if(isNull (_curTarget getVariable ["lightSource",ObjNull])) then {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOn";
		} else {
			_Btn3 ctrlSetText localize "STR_pInAct_LightsOff";
		};
		
		if(typeOf life_pInact_curTarget == "Land_i_Shed_Ind_F") then {
			_Btn3 ctrlSetText localize "STR_pInAct_AccessGarage";
			_Btn3 buttonSetAction "[life_pInact_curTarget,""Car""] spawn life_fnc_vehicleGarage; life_myGarage = true; closeDialog 0;";
			_Btn3 ctrlShow true;
		
			_Btn4 ctrlSetText localize "STR_pInAct_StoreVeh";
			_Btn4 buttonSetAction "[life_pInact_curTarget,player] spawn life_fnc_storeVehicle; closeDialog 0;";
			_Btn4 ctrlShow true;
		} else {
			_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_lightHouseAction; closeDialog 0;";
			_Btn3 ctrlShow true;
		
			_Btn4 ctrlSetText localize "STR_pInAct_LockHouse";
			_Btn4 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_lockupHouse; closeDialog 0;";
			_Btn4 ctrlShow true;
			if(_curTarget getVariable["breached",false]) then {_Btn4 ctrlEnable false};
		};
		
		_Btn5 ctrlSetText "Lease Management";
		_Btn5 buttonSetAction "createDialog ""STS_Life_lease"";";
		_Btn5 ctrlShow true;
		
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn5 ctrlEnable false;
		};
		

		_Btn6 buttonSetAction "closeDialog 0; [life_pInAct_curTarget] spawn life_fnc_listHouse;";
		_Btn6 ctrlShow true;
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn6 ctrlEnable false;
		};
		
		if(_curTarget getVariable["listPrice",-1] < 0) then {
			_Btn6 ctrlSetText "List Sale";
		} else {
			_Btn6 ctrlSetText "Remove Listing";
		};
		
		_Btn7 buttonSetAction "closeDialog 0; [] spawn KBW_fnc_claimMailbox;";
		_Btn7 ctrlSetText "AE Mail";
		_Btn7 ctrlShow true;
		if(((_curTarget getVariable "house_owner") select 0) != (getPlayerUID player)) then {
			_Btn7 ctrlEnable false;
		};
		
		_Btn8 buttonSetAction "closeDialog 0; life_pInAct_curTarget spawn life_fnc_storageBox";
		_Btn8 ctrlSetText "Inventory";
		_Btn8 ctrlShow true;
	};
};