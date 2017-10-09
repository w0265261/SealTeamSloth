/*
        File: fn_radar.sqf
        Author: Silly Aussie kid named Jaydon
        Format Edit by Mike McCrow **Delay & Changed Speeds are not endorsed by original author**
		Vehicle info such as driver and registered owners added by Kevin.
*/
if(playerSide != west && life_inv_bhTool < 1) exitWith {};
private ["_speed","_vehicle","_owners","_driver","_headgear","_goggles","_unit"];
_vehicle = cursorTarget;
if ((vehicle player distance _vehicle) > 750 && !(typeOf vehicle player in["I_Heli_light_03_unarmed_F","B_UAV_01_F","B_UAV_02_F"])) exitWith {};
_speed = round speed _vehicle;
_owners = _vehicle getVariable "vehicle_info_owners";
_owners = _owners select 0;
_owners = [[_owners]] call life_fnc_vehicleOwners;

if(_vehicle isKindOf "Car" || _vehicle isKindOf "Air" || _vehicle isKindOf "ship") then
{
        switch (true) do
        {
                case ((_speed <= 120)) :
                {      
                        hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar")+ "<br/><t color='#33CC33'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed")+"<br/>"+(localize "STR_NOTF_SearchVeh2")+"<br/>",round  _speed,_owners];
                };
               
                case ((_speed > 120 && _speed <= 140)) :
                {      
                        hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar")+ "<br/><t color='#E87600'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed")+"<br/>"+(localize "STR_NOTF_SearchVeh2")+"<br/>",round  _speed,_owners];
                };
                case ((_speed > 140)) :
                {      
                        hint parseText format ["<t color='#ffffff'><t size='2'><t align='center'>" +(localize "STR_Cop_Radar")+ "<br/><t color='#FF0000'><t align='center'><t size='1'>" +(localize "STR_Cop_VehSpeed")+"<br/>"+(localize "STR_NOTF_SearchVeh2")+"<br/>",round  _speed,_owners];
                };
        };
};

_wanted = false;
{if(_owners == (_x select 0)) then {_wanted = true}; if(_wanted) exitWith {};} forEach life_wanted_list;
if(_wanted) then {systemChat "It appears the vehicle's owner was recorded as being wanted recently."}
