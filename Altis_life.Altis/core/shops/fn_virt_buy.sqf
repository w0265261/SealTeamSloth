#include <macro.h>
/*
	File: fn_virt_buy.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Buy a virtual item from the store.
*/
private["_type","_price","_amount","_diff","_name","_hideout"];
if((lbCurSel 2401) == -1) exitWith {hint localize "STR_Shop_Virt_Nothing"};
_type = lbData[2401,(lbCurSel 2401)];
_price = lbValue[2401,(lbCurSel 2401)];
_amount = ctrlText 2404;
_diff = [_type,parseNumber(_amount),life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
_amount = parseNumber(_amount);
if(_diff <= 0) exitWith {hint localize "STR_NOTF_NoSpace"};
_amount = _diff;
_hideout = {if(player distance _x < 50) exitWith {true}; false} forEach [gang_flag_1,gang_flag_2,gang_flag_3];
_price = (_price * __GETC__(life_vip_discount));
if((_price * _amount) > life_handpaper && {_hideout && {!isNil {group player getVariable "gang_bank"}} && {(group player getVariable "gang_bank") <= _price * _amount}}) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};

_name = [([_type,0] call life_fnc_varHandle)] call life_fnc_varToStr;

if(([true,_type,_amount] call life_fnc_handleInv)) then
{
	if(_hideout && {!isNil {group player getVariable "gang_bank"}} && {(group player getVariable "gang_bank") >= _price}) then {
		_action = [
			format[(localize "STR_Shop_Virt_Gang_FundsMSG")+ "<br/><br/>" +(localize "STR_Shop_Virt_Gang_Funds")+ " <t color='#8cff9b'>$%1</t><br/>" +(localize "STR_Shop_Virt_YourFunds")+ " <t color='#8cff9b'>$%2</t>",
				[(group player getVariable "gang_bank")] call life_fnc_numberText,
				[life_handpaper] call life_fnc_numberText
			],
			localize "STR_Shop_Virt_YourorGang",
			localize "STR_Shop_Virt_UI_GangFunds",
			localize "STR_Shop_Virt_UI_YourCash"
		] call BIS_fnc_guiMessage;
		if(_action) then {
			if(count life_gangData == 0) exitWith {hint "An error occurred, if you just joined this gang try relogging."};
			if(group player getVariable["gang_name",""] != (life_gangData select 2)) exitWith {hint "An error occurred, if you just joined this gang try relogging."};
			if(life_gang_rank < 3) exitWith {hint "You are not currently authorized to use the gang's funds."};
			hint format[localize "STR_Shop_Virt_BoughtGang",_amount,_name,[(_price * _amount)] call life_fnc_numberText];
			_funds = group player getVariable "gang_bank";
			_funds = _funds - (_price * _amount);
			group player setVariable["gang_bank",_funds,true];
			[1,group player,_funds] remoteExec ["TON_fnc_updateGang",2];
			PlaySound "purchase";
		} else {
			if((_price * _amount) > life_handpaper) exitWith {[false,_type,_amount] call life_fnc_handleInv; hint localize "STR_NOTF_NotEnoughMoney";};
			hint format[localize "STR_Shop_Virt_BoughtItem",_amount,_name,[(_price * _amount)] call life_fnc_numberText];
			["cash","take",floor(_price*_amount)] call life_fnc_handlePaper;
			PlaySound "purchase";
		};
	} else {
		_oldPrice = _price;
		_tax = false;
		_toSelect = ((life_capture_list) select 0);
		if(life_virt_shop in["rebel"] && (_toSelect select 2) == 1 && (_toSelect select 0) != group player getVariable["gang_name",""]) then {
			_price = _price * 1.04;
			_tax = true;
		} else {
			if(playerSide == civilian) then {
				_govtax = round (_price * (life_rules select 1) / 100);
				_price = _price + _govtax;
				if(_price > life_handpaper) exitWith {hint localize "STR_NOTF_NotEnoughMoney"};
				life_tax = life_tax + _govtax;
				if(life_tax == _govtax) then {
					if(!life_diagWaiting) then {
						life_diagWaiting = true;
						[] spawn {
							waitUntil{!dialog};
							life_diagWaiting = false;
							if(life_tax > 0) then {
								[life_tax] remoteExecCall ["life_fnc_updateGovBank",2];
							};
							life_tax = 0;
						};
					};
				};
			};
		};
		if((_price * _amount) > life_handpaper) exitWith {hint localize "STR_NOTF_NotEnoughMoney"; [false,_type,_amount] call life_fnc_handleInv;};
		hint format[localize "STR_Shop_Virt_BoughtItem",_amount,_name,[(_price * _amount)] call life_fnc_numberText];
		["cash","take",floor(_price*_amount)] call life_fnc_handlePaper;
		PlaySound "purchase";
		if(_tax) then {
			_taxed = round (_price - _oldPrice);
			if(_taxed < 1) exitWith {};
			systemChat format["A tax of %1 was taken by the owners of %2",_taxed,(_toSelect select 0)];
			life_tax = life_tax + _taxed;
			if(life_tax == _taxed) then {
				[_toSelect select 0] spawn {
					waitUntil{!dialog};
					[5,nil,(_this select 0),life_tax] remoteExec ["TON_fnc_updateGang",2];
					life_tax = 0;
				};
			};
		};
	};
	[false] call life_fnc_virt_update;
};