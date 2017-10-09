/*
File: fn_RepaintMenu.sqf
Author: MooN-Gaming

Description: What could it do bro?!

*/
if(playerSide != civilian) exitWith {hint "This service is only available to civilians"; };
if(!life_use_atm) exitWith { hint "You expect me to paint your car after robbing my co-worker?"; };
private["_display","_vehicles","_objects","_color","_haha","_pic","_text"];
createDialog "STS_Life_vehicle_repaint";
disableSerialization;
if(!isNull (findDisplay 2300)) then {
_display = findDisplay 2300;
_vehicles = _display displayCtrl 2302;

_objects = nearestObjects[getPos (_this select 0),["Car","Air"],20];
_xx = _objects select 0;



/*List vehicles*/
{
			
			if(vehicle player != _x) then {
			_color = [(typeOf _xx),(_xx getVariable "Life_VEH_color")] call life_fnc_vehicleColorStr;
			_pic = getText(configFile >> "CfgVehicles" >> typeOf _x >> "picture");			
			_text = format["(%1)",_color];
			_haha = typeOf _x;			
			if(_text == "()") then
			{
			_text = "";
			};			
			_vehicles lbAdd format ["%1 || %2", getText(configFile >> "cfgVehicles" >> typeOf _x >> "DisplayName"), _text];		
			_vehicles lbSetPicture [(lbSize _vehicles)-1,_pic];	
			_vehicles lbSetData [(lbSize _vehicles)-1,_haha];
		};		
	} foreach  _objects;
};