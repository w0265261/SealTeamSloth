/*
fn_openDuelUI.sqf
Kevin Webb
Description: As you can see, opens and sets up the duel UI.
*/
createDialog "STS_KBW_Duel";
waitUntil{dialog};
_arr = if(count _this > 0) then {[] spawn { ctrlShow[101,false]; sleep 0.2; ctrlShow[100,true]}; _this} else {(player nearEntities ["Man", 20])};
{
	if(isPlayer _x && _x != player) then {
		_index = lbAdd[15101,format["%1",_x getVariable["realname",name _x]]];
		lbsetData [15101,_index,str _x];
	};
} forEach _arr;
[] spawn {
	waitUntil{!dialog};
	if(!life_racing) then {life_racers = []};
};