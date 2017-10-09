#include <macro.h>
/*
	File: fn_p_openMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the players virtual inventory menu
*/
if(!alive player || dialog) exitWith {}; /*Prevent them from opening this for exploits while dead.*/
createDialog "STS_playerSettings";
disableSerialization;

switch(playerSide) do
{
	case west: 
	{
		ctrlShow[2011,false];
		ctrlShow[1999,false];
		ctrlShow [100,false];
		ctrlShow [101,false];
	};
	
	case independent:
	{
		ctrlShow[1999,false];
		ctrlShow[2012,false];
		ctrlShow[2011,false];
		ctrlShow [100,false];
		ctrlShow [101,false];
	};
	
	case civilian:
	{
		ctrlShow[2012,false];
		ctrlShow[3011,false];
		if(!license_civ_taxi || !life_isOnDutyTaxi) then {ctrlShow [100,false]};
		if (life_isOnDutyTaxi || !isNull life_taxiCustomer) then {ctrlShow [101,false]};
	};
};
if(life_paintBalling) then { 
ctrlShow[2011,false];
ctrlShow[1999,false];
};

if(__GETC__(style) < 1) then
{
	ctrlShow[2020,false];
	ctrlShow[2021,false];
};

[] call life_fnc_p_updateMenu;

if(__GETC__(style) < 1) then
{
	ctrlShow[2020,false];
	ctrlShow[2021,false];
};