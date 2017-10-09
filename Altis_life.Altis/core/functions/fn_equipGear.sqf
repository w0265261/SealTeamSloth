#include <macro.h>
/*
	File: fn_equipGear.sqf
	Author: John "Paratus" VanderZwet

	Description:
	Initializes custom gear textures
*/
switch (true) do {
	case ((uniform player) == "U_IG_Guerilla2_1" && playerSide == west): {
		switch (__GETC__(life_coplevel)) do {
			/*case 0: { [player,"images\Clean_Uni.jpg"] call life_fnc_setUniform; };
			case 1: { [player,"images\Cadet_Uni.jpg"] call life_fnc_setUniform; };
			case 2: { [player,"images\PO_Uni.jpg"] call life_fnc_setUniform; };
			case 3: { [player,"images\SPO_Uni.jpg"] call life_fnc_setUniform; };*/
			case 4: { [player,"images\Corp_Uni.jpg"] call life_fnc_setUniform; };
			case 5: { [player,"images\Serg_Uni.jpg"] call life_fnc_setUniform; };
			case 6: { [player,"images\Lieut_Uni.jpg"] call life_fnc_setUniform; };
			case 7: { [player,"images\Capt_Uni.jpg"] call life_fnc_setUniform; };
			case 8: { [player,"images\SuperInt_Uni.jpg"] call life_fnc_setUniform; };
		};		
	};
	
	case ((uniform player) == "U_Rangemaster" && playerSide == west): {
		switch (__GETC__(life_coplevel)) do {
			case 0: { [player,"images\Pub_Uni.jpg"] call life_fnc_setUniform; };
			case 1: { [player,"images\Pub_Uni.jpg"] call life_fnc_setUniform; };
			case 2: { [player,"images\PO.jpg"] call life_fnc_setUniform; };
			case 3: { [player,"images\SPO.jpg"] call life_fnc_setUniform; };
			case 4: { [player,"images\Corp.jpg"] call life_fnc_setUniform; };
			case 5: { [player,"images\Serg.jpg"] call life_fnc_setUniform; };
			case 6: { [player,"images\Lieu.jpg"] call life_fnc_setUniform; };
			case 7: { [player,"images\Capt.jpg"] call life_fnc_setUniform; };
			case 8: { [player,"images\Super.jpg"] call life_fnc_setUniform; };
		};		
	};
	
	case ((uniform player) == "U_C_WorkerCoveralls" && life_is_arrested): {
		[player,"images\prisoner_uniform.jpg"] call life_fnc_setUniform;
	};

	case ((uniform player) == "U_I_CombatUniform" && playerSide == independent): {
		[player,"images\ems_uni.jpg"] call life_fnc_setUniform;
	};
	
	case ((uniform player) == "U_C_Poloshirt_blue"): {
		[player,"images\polosts.jpg"] call life_fnc_setUniform;
	};

	case ((uniform player) == "U_C_Poloshirt_stripped"): {
		[player,"images\lumberjack1.paa"] call life_fnc_setUniform;
	};
};
if (playerSide == west) then {
	player setVariable ["coplevel",__GETC__(life_coplevel)];
};