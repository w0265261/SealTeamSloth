/*
   Created by: BWG_Joe and Adapted by STS Dev Team
   Function Name: life_fnc_coplights.sqf
   Description: Sets the lights for police vehicles.
*/

private ["_vehicle","_lightRd","_lightB","_lightL","_lightR","_leftRed","_lumens","_attach"];

_vehicle = _this select 0;
if (isNil "_vehicle" || isNull _vehicle || !(_vehicle getVariable "lights")) exitWith {};

switch (typeOf _vehicle) do
{
	case "C_Hatchback_01_F": { _attach = [[-0.6, 2, -0.95], [0.6, 2, -0.95]]; };
	case "C_Offroad_01_F": { _attach = [[-0.37, 0.0, 0.56], [0.37, 0.0, 0.56]]; };
	case "C_SUV_01_F": { _attach = [[-0.4, 2.3, -0.55], [0.4, 2.3, -0.52]]; };
	case "C_Hatchback_01_sport_F": { _attach = [[-0.6, 2, -0.95], [0.6, 2, -0.95]]; };
};

_lightRd = [20, 0.5, 0.5];
_lightB = [1, 1, 1];

_lightL = createVehicle ["#lightpoint", getPos _vehicle, [], 0, "CAN_COLLIDE"];
sleep 0.2;
_lightL setLightColor _lightRd;
_lightL setLightBrightness 0;
_lightL lightAttachObject [_vehicle, _attach select 0];
_lightL setLightAttenuation [0.181, 0, 1000, 130];
_lightL setLightIntensity 10;
_lightL setLightFlareSize 0.38;
_lightL setLightFlareMaxDistance 150;
_lightL setLightUseFlare true;
_lightL setLightDayLight true;
_lightL setLightAmbient [0.1,0.1,1];

_lightR = createVehicle ["#lightpoint", getPos _vehicle, [], 0, "CAN_COLLIDE"];
sleep 0.2;
_lightR setLightColor _lightB;
_lightR setLightBrightness 0;
_lightR lightAttachObject [_vehicle, _attach select 1];
_lightR setLightAttenuation [0.181, 0, 1000, 130];
_lightR setLightIntensity 10;
_lightR setLightFlareSize 0.38;
_lightR setLightFlareMaxDistance 150;
_lightR setLightUseFlare true;
_lightR setLightDayLight true;
_lightR setLightAmbient [0.1,0.1,1];

if (sunOrMoon < 1) then {
	_lumens = 10;
} else {
	_lumens = 50;
};

_leftRed = true;
while {(alive _vehicle)} do
 {
	if (!(_vehicle getVariable "lights")) exitWith {};
		if ((_leftRed)) then
			{
			_leftRed = false;
			_lightR setLightBrightness 0;
			sleep 0.03;
			_lightL setLightBrightness _lumens;  }
		 else {
		_leftRed = true;
		_lightL setLightBrightness 0;
		sleep 0.03;
		_lightR setLightBrightness _lumens;
	};

	sleep 0.25;
};
deleteVehicle _lightL;
deleteVehicle _lightR;