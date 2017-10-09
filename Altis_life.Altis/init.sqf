
enableSaving[false,false];

[] execVM "KRON_Strings.sqf";
if(isDedicated || !hasInterface) exitWith {};
[] execVM "outlw_magRepack\MagRepack_init_sv.sqf";
[] execVM "briefing.sqf";
[] execVM "intro.sqf";
[] execVM "zlt_fastrope.sqf";