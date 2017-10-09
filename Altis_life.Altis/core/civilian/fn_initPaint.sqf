/*
fn_initPaint
Kevin Webb
Does the client side paintball stuff
*/
private["_case","_myTeam"];
_case = param [0,0,[0]];
_myTeam = "";
switch(_case) do
{
	case 0:
	{
		if(life_paintRequest) exitWith {};
		life_myGrp = group player;
		life_paintRequest = true;
		[player] remoteExec ["TON_fnc_paintBall",2];
		hint "Attempting to enter the paintball queue. Be sure to stay nearby or you will forfeit your position!";
		[] spawn { sleep 150; life_paintRequest = false; };
	};
	case 1:
	{
		life_paintRequest = false;
		hint "The paintball wait period has passed, but you were the only entry.";
	};
	case 2:
	{
		life_paintRequest = false;
		life_paintBalling = true;
		life_originalPos = getPosATL player;
		call life_fnc_saveThat;
		RemoveAllWeapons player;
		{player removeMagazine _x;} foreach (magazines player);
		removeUniform player;
		removeVest player;
		removeBackpack player;
		removeGoggles player;
		removeHeadGear player;
		{
			player unassignItem _x;
			player removeItem _x;
		} foreach (assignedItems player);
		_team = param [2,true,[true]];
		_assignedNumber = param [1,0,[0]];
		if(_team) then {
			_myTeam = "red";
			player forceAddUniform "U_O_Protagonist_VR"; 
			player addItem "SmokeShellRed";
			_marker = format["red_%1",_assignedNumber];
			player setDir (markerDir _marker);
			player setPos (getMarkerPos _marker);
		} else {
			_myTeam = "blue";
			player forceAddUniform "U_B_Protagonist_VR"; 
			player addItem "SmokeShellBlue";
			_marker = format["blue_%1",_assignedNumber];
			player setDir (markerDir _marker);
			player setPos (getMarkerPos _marker);
		};
		player addItem "NVGoggles_OPFOR";
		player assignItem "NVGoggles_OPFOR";
		player addWeapon "SMG_01_Holo_pointer_snds_F";
		player addWeapon "hgun_Pistol_heavy_01_snds_F";
		player addHandgunItem "optic_MRD";
		player addMagazines ["11Rnd_45ACP_Mag",4];
		player addMagazines ["30Rnd_45ACP_Mag_SMG_01_tracer_green",6];
		hint format["The paintball match has now begun! You are on the %1 team.",_myTeam];
		_myTeam spawn {
			_myTeam = _this;
			while {life_paintBalling} do {
				if(!(cameraView in ["INTERNAL","GUNNER"])) then {player switchCamera "INTERNAL"};
				if(player distance (getMarkerPos "paint_arena") > 110 || getPosASL player select 2 < 0) then {
					switch(_myTeam) do {
						case "red": {
							player setPos (getMarkerPos "red_1");
						}; 
						case "blue": {
							player setPos (getMarkerPos "blue_1"); 
						};
					};
					hintSilent "You mustn't stray too far from the paintball area! Get back in there and fight!";
				};
			};
		};
	};
	case 3: {
		life_paintRequest = false;
		hint "The paintball session is currently active, try again later!";
	};
	case 4: {
		if(!life_paintBalling) exitWith {};
		[player] joinSilent life_myGrp;
		life_paintBalling = false;
		[true] call life_fnc_optiloadGear; 
		player setPosATL life_originalPos;
		hint "Congratulations, you won!";
	};
};