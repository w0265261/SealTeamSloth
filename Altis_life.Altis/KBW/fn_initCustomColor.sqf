/*
Kevin Webb
fn_initCustomColor.sqf
initializes the process
*/
if(life_handPaper < 1000) exitWith {hint "You don't seem to have enough money on hand for this transaction"};
_nearVehicles = nearestObjects[player,["Car","Air","Ship"],30];
_vehicle = objNull;
_isMyVeh = false;
if(count _nearVehicles > 0) then
{
	{
		if(!isNull _vehicle) exitWith {}; /*Kill the loop.*/
		_vehData = _x getVariable["vehicle_info_owners",[]];
		if(count _vehData  > 0) then
		{
			_vehOwner = (_vehData select 0) select 0;
			if((getPlayerUID player) == _vehOwner) exitWith
			{
				_vehicle = _x; _isMyVeh = true;
			};
			if(_x in life_vehicles) exitWith {_vehicle = _x};
		};
	} foreach _nearVehicles;
};
if(count _nearVehicles == 0 || isNull _vehicle) exitWith {hint "No vehicle that you own was found nearby."};
life_myVehicle = _vehicle;
_OriginalTexture = [];
{_OriginalTexture pushBack[_forEachIndex,_x]} forEach getObjectTextures _vehicle;
numOfSelections = count getObjectTextures _vehicle;
my_selection = 0;
createDialog "STS_customColor";
{sliderSetRange [_x, 0, 1]} forEach [2901,2911,2921,2931];
if(numOfSelections < 2) then {ctrlShow[1994,false]};
sliderSetPosition[2931,1];
{sliderSetPosition [_x, 0.5]} forEach [2901,2911,2921];
for [{_i=0},{_i<numOfSelections},{_i=_i+1}] do
{_vehicle setObjectTexture [_i,format["#(rgb,8,8,3)color(%1,%2,%3,%4)",0.5,0.5,0.5,1]]};
_shop_cam = "CAMERA" camCreate getPos _vehicle;
showCinemaBorder false;
_shop_cam cameraEffect ["Internal", "Back"];
_shop_cam camSetPos (_vehicle modelToWorld [5,1,1]);
_shop_cam camSetTarget _vehicle;
_shop_cam camSetFOV 1;
_shop_cam camSetFocus [50, 0];
_shop_cam camCommit 0;

waitUntil{isNull findDisplay 2900};
if(isNil "Accept_recolor") then {
	{_vehicle setObjectTexture _x} forEach _OriginalTexture;
} else {
	["cash","take",1000] call life_fnc_handlePaper;
	Accept_recolor = nil;
	_newTex = [];
	{_newTex pushBack [_forEachIndex,_x]} forEach getObjectTextures _vehicle;
	{_vehicle setObjectTextureGlobal _x} forEach _newTex;
	if(_isMyVeh) then {[_vehicle,_newTex] remoteExecCall ["KBW_fnc_UpdateVehColor",2]};
	_vehicle setVariable["life_veh_color",_newTex,true];
};
_shop_cam cameraEffect ["TERMINATE","BACK"];
camDestroy _shop_cam;
my_selection = nil;
redscale = 0.5;
bluescale = 0.5;
greenscale = 0.5;
opacity = 1;