/*
	File: fn_govMenu.sqf
	Author: John "Paratus" VanderZwet
	Edited by Kevin for compatibility and optimization
	Description:
	Shows governor menu
*/

disableSerialization;

_display = findDisplay 1900;
if(isNull _display) then
{
	createDialog "STS_life_governor_menu";
};
if(!life_governor) then {((findDisplay 1900) displayCtrl 1865) ctrlSetText format["Current President: %1",life_rules select 5]};
sliderSetRange [1901, 0, 10];	// Set max sales tax

sliderSetPosition [1901, life_rules select 1];

ctrlSetText[1902,format["%1%2",round(life_rules select 1),"%"]];

switch(life_rules select 2) do {
	case 0: {
		((findDisplay 1900) displayCtrl 1994) ctrlSetTextColor [1,0,0,1];
		((findDisplay 1900) displayCtrl 1994) ctrlSetText "Costly Healthcare";
	};
	case 1: {
		((findDisplay 1900) displayCtrl 1994) ctrlSetTextColor [1,1,0,1];
		((findDisplay 1900) displayCtrl 1994) ctrlSetText "Subsidized Healthcare";
	};
	case 2: {
		((findDisplay 1900) displayCtrl 1994) ctrlSetTextColor [0,1,0,1];
		((findDisplay 1900) displayCtrl 1994) ctrlSetText "Free Healthcare";
	};
};
switch(life_rules select 6) do {
	case 0: {
		((findDisplay 1900) displayCtrl 1995) ctrlSetTextColor [1,0,0,1];
		((findDisplay 1900) displayCtrl 1995) ctrlSetText "Reduced Police Pay";
	};
	case 1: {
		((findDisplay 1900) displayCtrl 1995) ctrlSetTextColor [1,1,0,1];
		((findDisplay 1900) displayCtrl 1995) ctrlSetText "Standard Police Pay";
	};
	case 2: {
		((findDisplay 1900) displayCtrl 1995) ctrlSetTextColor [0,1,0,1];
		((findDisplay 1900) displayCtrl 1995) ctrlSetText "Police Bonus";
	};
};
switch(life_rules select 7) do {
	case 0: {
		((findDisplay 1900) displayCtrl 1996) ctrlSetTextColor [1,0,0,1];
		((findDisplay 1900) displayCtrl 1996) ctrlSetText "Reduced Welfare";
	};
	case 1: {
		((findDisplay 1900) displayCtrl 1996) ctrlSetTextColor [1,1,0,1];
		((findDisplay 1900) displayCtrl 1996) ctrlSetText "Standard Welfare";
	};
	case 2: {
		((findDisplay 1900) displayCtrl 1996) ctrlSetTextColor [0,1,0,1];
		((findDisplay 1900) displayCtrl 1996) ctrlSetText "Increased Welfare";
	};
};
if (life_rules select 3) then
{
	((findDisplay 1900) displayCtrl 1926) ctrlSetTextColor [0,1,0,1];
	((findDisplay 1900) displayCtrl 1926) ctrlSetText "Marijuana LEGAL";
}
else
{
	((findDisplay 1900) displayCtrl 1926) ctrlSetTextColor [1,0,0,1];
	((findDisplay 1900) displayCtrl 1926) ctrlSetText "Marijuana ILLEGAL";
};

if (!(life_rules select 4)) then
{
	((findDisplay 1900) displayCtrl 1928) ctrlSetTextColor [0,1,0,1];
	((findDisplay 1900) displayCtrl 1928) ctrlSetText "No Death Penalty";
}
else
{
	((findDisplay 1900) displayCtrl 1928) ctrlSetTextColor [1,0,0,1];
	((findDisplay 1900) displayCtrl 1928) ctrlSetText "DEATH PENALTY";
};