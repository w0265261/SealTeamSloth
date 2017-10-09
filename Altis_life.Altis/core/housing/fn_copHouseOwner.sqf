/*
	Displays the house owner
*/
private["_house","_leasers","_out"];
_house = param [0,ObjNull,[ObjNull]];
if(isNull _house OR (!(_house isKindOf "House_F"))) exitWith {};
if(isNil {(_house getVariable "house_owner")}) exitWith {hint localize "STR_House_Raid_NoOwner"};
_leasers = [];
{_leasers pushBack  (_x select 1)} forEach (_house getVariable["leasers",[]]);
_out = format["<t color='#FF0000'><t size='2'>" +(localize "STR_House_Raid_Owner")+ "</t></t><br/>%1",(_house getVariable "house_owner") select 1];
{_out = _out + format["<br/>%1",_x]} forEach _leasers;
hint parseText _out;