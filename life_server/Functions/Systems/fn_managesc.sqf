/*
	File: fn_managesc.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	User management of whether or not they want to be on a sidechat for their side.
*/
private["_unit","_bool","_side"];
_unit = param [0,ObjNull,[ObjNull]];
_bool = param [1,false,[false]];
_side = param [2,civilian,[west]];

if(isNull _unit) exitWith {};

switch (_side) do
{
	case west:
	{
		if(_bool) then
		{
			life_radio_west radioChannelAdd [_unit];
		}
			else
		{
			life_radio_west radioChannelRemove [_unit];
		};
	};
	
	case civilian:
	{
		if(_bool) then
		{
			life_radio_civ radioChannelAdd [_unit];
			life_radio_civTrade radioChannelAdd [_unit];
		}
			else
		{
			life_radio_civ radioChannelRemove [_unit];
			life_radio_civTrade radioChannelRemove [_unit];

		};
	};
};