/*
Kevin Webb
addFakeName.sqf
Lets civs change their name to be temporarily incognito
*/
if(typeName _this == "BOOL") exitWith {
	player setVariable["realname",name player,true];
	[getPlayerUID player,""] remoteExecCall ["DB_fnc_updateFakeName",2];
	hint "Your name has been returned to normal.";
};
[] spawn {
	if(life_handPaper < 20000) exitWith {hint "Fake identities cost 20,000; come back with the cash in hand!"};
	createDialog "STS_KBW_price_diag";
	waitUntil{!isNull (findDisplay 13371)};
	ctrlSetText[2651,"Type your fake name"];
	waitUntil{isNull (findDisplay 13371) || life_charged};
	if(!(life_charged)) exitWith {};
	["cash","take",20000] call life_fnc_handlePaper;
	life_charged = false;
	_name = ctrlText 7331;
	player setVariable["realname",_name,true];
	life_realname = _name;
	closeDialog 0;
	[getPlayerUID player,_name] remoteExecCall["DB_fnc_updateFakeName",2];
	hint format["You have purchased a fake identity under the name %1 - this will last until you commit a crime or remove it manually at a gang turf like this one.",_name];
};