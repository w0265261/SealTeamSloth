/*
	File: fn_juryRegister.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Jury member signing in for duty at courthouse
*/
call SOCK_fnc_updateRequest;
hint "You have registered for jury duty. Please remain at the courthouse for a few minutes until court is in session.";

life_originalPos = getPosATL player;
life_jury_registered = nil;

[player,nil,true] remoteExec ["life_fnc_trialRequest",2];

[] spawn
{
	while {isNil "life_jury_registered"} do
	{
		if (player distance life_originalPos > 25 || !isNull objectParent player) exitWith
		{
			if(!isNil "life_jury_active") exitWith {};
			[player,nil,true,false] remoteExec ["life_fnc_trialRequest",2];
			life_jury_registered = false;
			hint "You moved too far from the courthouse or entered a vehicle.  You have been removed from the jury bench.  Quickly register for duty again before the trial begins if you wish to attend.";
		};
	};
};