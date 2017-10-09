life_rules = _this;
_weed = life_rules select 3;


if (!_weed) then
{
	"weed_1" setMarkerColor "ColorRed";
	"Weed_p_1" setMarkerColor "ColorRed";
	{
		if ((_x select 0) == "c") then {life_illegal_items set [_forEachIndex, ["cannabis",_x select 1]]};
		if ((_x select 0) == "m") then {life_illegal_items set [_forEachIndex, ["marijuana",_x select 1]]};
	} forEach life_illegal_items;
}
else
{
	"weed_1" setMarkerColor "ColorGreen";
	"Weed_p_1" setMarkerColor "ColorGreen";
	{
		if ((_x select 0) == "cannabis") then {life_illegal_items set [_forEachIndex, ["c",_x select 1]]};
		if ((_x select 0) == "marijuana") then {life_illegal_items set [_forEachIndex, ["m",_x select 1]]};
	} forEach life_illegal_items;
};
publicVariable "life_illegal_items";
publicVariable "life_rules";

_query = format["UPDATE rules SET sales=%1,fuel=%2,weed=%3,death=%4,police=%5,civilian=%6",(life_rules select 1),(life_rules select 2),[(life_rules select 3),0] call DB_fnc_Bool,[(life_rules select 4),0] call DB_fnc_Bool, life_rules select 6, life_rules select 7];
[_query,1] call DB_fnc_asyncCall;