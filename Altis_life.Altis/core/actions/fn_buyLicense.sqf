/*
	File: fn_buyLicense.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when purchasing a license. May need to be revised.
	3 License system envisioned by Bobbus, coded by Kevin.
*/
private["_type"];
_type = _this select 3;

_price = [_type] call life_fnc_licensePrice;
_license = [_type,0] call life_fnc_licenseType;

if(life_handpaper < _price) exitWith {cutText ["You do not have enough money for this license, return with the money in your pockets!","PLAIN"];};

["cash","take",_price] call life_fnc_handlePaper;
missionNamespace setVariable[(_license select 0),true];

if (_type == "rebel") then
{
	cutText ["This license allows you to illegally purchase higher calibre firearms and other tools. This training will be lost on death.","PLAIN"];
	_other = ["c3",0] call life_fnc_licenseType;
	_others = ["bh",0] call life_fnc_licenseType;
	if (missionNamespace getVariable[_other select 0,false]) then
	{
		hint "Because you have acquired rebel training, you have forfeited your class 3 weapons license.";
		missionNamespace setVariable[_other select 0,false];
	};
	if (missionNamespace getVariable[_others select 0,false]) then
	{
		hint "Because you have acquired rebel training, you have forfeited your bounty hunter license.";
		player setVariable["bountyHunter", false, true];
		missionNamespace setVariable[_others select 0,false];
	};
	
};

if(_type == "c3") then
{
	if(player getVariable["criminal",false]) exitWith {
		hint "I don't sell to criminals!";
		license_civ_c3 = false;
		["cash","add",_price] call life_fnc_handlePaper;
	};
	cutText ["This license allows you to legally purchase & carry 5.56mm rifles for your own protection. This license will be lost on arrest, do not abuse it!.","PLAIN"];
	_other = ["rebel",0] call life_fnc_licenseType;
	_others = ["bh",0] call life_fnc_licenseType;
	if (missionNamespace getVariable[_other select 0,false]) then
	{
		hint "Because you have purchased a class 3 license, you have forfeited your rebel license.";
		missionNamespace setVariable[_other select 0,false];
	};
	if (missionNamespace getVariable[_others select 0,false]) then
	{
		hint "Because you have acquired a class 3 weapons license, you have forfeited your bounty hunter license.";
		player setVariable["bountyHunter", false, true];
		missionNamespace setVariable[_others select 0,false];
	};
};

if(_type == "bh") then
{
	if(player getVariable["criminal",false]) exitWith {
		hint "I don't sell to criminals!";
		license_civ_bh = false;
		["cash","add",_price] call life_fnc_handlePaper;
	};
	if(!(player getVariable["approved",false])) exitWith {
		hint "You are required to have a SGT/Admin's approval to buy this license. Apply at sealteamsloth.com, 'in character discussion' section, or to a SGT/Admin in ts3.sealteamsloth.com";
		license_civ_bh = false;
		["cash","add",_price] call life_fnc_handlePaper;
	};
	cutText ["This license allows you to purchase & use tazer weapons as well as secure bounties from wanted individuals by turning them in to the police. You must ROLE PLAY, tazing without RP will be considered RDM!","PLAIN"];
	_other = ["rebel",0] call life_fnc_licenseType;
	_others = ["c3",0] call life_fnc_licenseType;
	player setVariable["bountyHunter", true, true];
	if (missionNamespace getVariable[_other select 0,false]) then
	{
		hint "Because you have purchased a bounty hunter license, you have forfeited your rebel training.";
		missionNamespace setVariable[_other select 0,false];
	};
	if (missionNamespace getVariable[_others select 0,false]) then
	{
		hint "Because you have acquired a bounty hunter license, you have forfeited your class 3 weapons license.";
		missionNamespace setVariable[_others select 0,false];
	};
};
if(!(_type in ["c3","bh","rebel"])) then { titleText[format[localize "STR_NOTF_B_1", _license select 1,[_price] call life_fnc_numberText],"PLAIN"]; };
[2] call SOCK_fnc_updatePartial;