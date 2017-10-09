/*
	File: fn_packupSpikes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Packs up a deployed spike strip.
*/
private["_spikes"];
_spikes = _this;
if(isNil "_spikes") exitWith {};

if(([true,"spikeStrip",1] call life_fnc_handleInv)) then
{
	titleText[localize "STR_NOTF_SpikeStrip","PLAIN"];
	deleteVehicle _spikes;
};