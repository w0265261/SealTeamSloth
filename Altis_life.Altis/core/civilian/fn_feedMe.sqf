/*
	Created by: Kevin for STS
	Function Name: fn_feedMe.sqf
	Description: sell food and water to customer
*/

if(life_handpaper < 20) exitWith {titleText["You don't have enough money!","PLAIN"]};

["cash","take",20] call life_fnc_handlePaper;
titleText["Thank you, come again!","PLAIN"];
life_thirst = 100;
life_hunger = 100;


[] call life_fnc_hudUpdate;
