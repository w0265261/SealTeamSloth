/*
File: vdmMonitor.sqf
Author: Kevin Webb
Description: Monitors VDM, and completes certain actions when they reach certain limits.
*/
private["_msg"];
_msg = format ["This is a message from the server, The player with the above username has reached %1 counts of VDM - perhaps admin intervention is required.",life_vdm_limit+1];
_msg2 = "The player with the above name has been automatically jailed for reaching 5 counts of VDM";
life_vdm_limit = life_vdm_limit + 1;
if(life_vdm_limit == 1) then {
	hint "Do not run people over for any reason! This is your first warning.";
	titleText["Refrain from VDMing! This is a highly bannable offence!","PLAIN"];
};
if(life_vdm_limit == 2) then {
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "";
	["DO NOT VDM"] spawn DS_double_cut;
	hintC "You have been officially warned by the server for VDM! Any further instances of this will result in punishment!";
};
if(life_vdm_limit == 3) then {
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "";
	(vehicle player) setVelocity [0,0,0];
	(vehicle player) lock 2;
	life_vehicles = [];
	player action ["GetOut",vehicle player];
	hintC "Due to continued VDM, we have taken your vehicle keys away.";
};
if(life_vdm_limit == 4) then {
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "";
	(vehicle player) setVelocity [0,0,0];
	deleteVehicle vehicle player;
	["Your vehicle has been deleted by the server due to continued VDM."] spawn DS_double_cut;
};
if(life_vdm_limit == 5) then {
	[3,-1,_msg2] call life_fnc_newMsg;
	[vehicle player] remoteExec ["TON_fnc_vehicleIsDead",2];
	sleep 0.15;
	deleteVehicle vehicle player;
	[player,false,20] spawn life_fnc_jail;
	hintC "Well, you asked for it. You have been sent to jail for repeated VDM.";
};