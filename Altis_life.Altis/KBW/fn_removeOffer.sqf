/*
fn_removeOffer.sqf
Kevin Webb
Gives us back our item we decided not to sell
Copyright © 2015 Kevin Webb, All rights reserved
Written for Seal Team Sloth ™ LLC
*/
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_id = lbValue[2802,(lbCurSel 2802)];
_dataArr = lbData[2802,(lbCurSel 2802)];
_dataArr = call compile format["%1",_dataArr];
_price = _dataArr select 1;
_buySell = _dataArr select 2;
_className = _dataArr select 3;
_type = _dataArr select 4;
_amount = _dataArr select 5;
_vehicleID = _dataArr select 6;
if(_buySell == 0 && _type == "Weapon" && primaryWeapon player != "") exitWith {hint "You will need to have your hands free before reclaiming your weapon"};
[3,_id,_className,_type,player,_amount,_buySell,_vehicleID,_price] remoteExec ["KBW_fnc_listing",2];
closeDialog 0;
hint "Your item/funds are being returned to you now.";