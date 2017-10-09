#include <macro.h>
/*
	File: fn_playerTags.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Adds the tags above other players heads when close and have visible range.
*/
#define iconID 78000
#define scale 0.8
_headgear = ["H_Shemag_tan","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk"];
_goggles = ["G_Balaclava_oli","G_Balaclava_lowprofile","G_Balaclava_combat","G_Balaclava_blk"];
if(visibleMap OR {!alive player} OR {dialog}) exitWith {
	500 cutText["","PLAIN"];
};
_units = visiblePosition player nearEntities ["Man", 250];
_cars = nearestObjects[(visiblePosition player),["Car","Air","Ship"],10];
if(!isNull objectParent player) then {_cars = _cars - [vehicle player]};
{if(count (crew _x) > 0) then {_units append (crew _x)};} forEach _cars;
_units = _units - [player];
_ui = uiNamespace getVariable ["Life_HUD_nameTags",displayNull];
if(isNull _ui) then {
	500 cutRsc["Life_HUD_nameTags","PLAIN"];
	_ui = uiNamespace getVariable ["Life_HUD_nameTags",displayNull];
};
if(count _units < life_tags) then {
	_idtag = []; 
	for [{_x=(life_tags - 1)},{_x>=(count _units)},{_x=_x-1}] do {
		_idtag pushBack (_x + 78000);
	};
	{_tag = _ui displayCtrl _x; _tag ctrlShow false} forEach _idtag;
};
life_tags = count _units;
{
	private["_text"];
	_idc = _ui displayCtrl (iconID + _forEachIndex);
	if(!(lineIntersects [eyePos player, eyePos _x, player, _x]) && {!isNil {_x getVariable "realname"}}) then {
		_pos = switch(typeOf _x) do {
			case "Land_Pallet_MilBoxes_F": {[visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1.5]};
			default {[visiblePosition _x select 0, visiblePosition _x select 1, ((_x modelToWorld (_x selectionPosition "head")) select 2)+.5]};
		};
		_sPos = worldToScreen _pos;
		if(count _sPos > 1 && {_pos distance player < 10 || (life_targetTag && cursorTarget == _x && _pos distance player < 250)}) then {
			_text = switch (true) do {
				case (!(player getVariable["invis",false] || playerSide == independent) && ((headgear _x) in _headgear || (goggles _x) in _goggles) && !(_x in (units group player)) && !(side _x == west) && !(player getVariable["unconscious",false]) && !(_x getVariable["invis",false])): {format["<t color='#000000'>Masked Man</t>"];};
				case (_x in (units group player) && playerSide == civilian && !(_x getVariable["invis",false])): {format["<t color='#00FF00'>%1</t>",(_x getVariable ["realname",name _x])];};
				case (_x getVariable["unconscious",false] && !(_x getVariable["invis",false])): {format["<t color='#FF0000'>%1 [Unconscious]</t>",(_x getVariable ["realname",name _x])];};
				case (_x getVariable["invis",false]): {""};
				case (!isNil {(_x getVariable "rank")} && !(_x getVariable["invis",false])): {format["<img image='%1' size='1'></img> %2",switch ((_x getVariable "rank")) do {
					case 0: {"icons\recruit.paa"};
					case 1: {"icons\recruit.paa"};
					case 2: {"\a3\ui_f\data\gui\cfg\Ranks\private_gs.paa"}; 
					case 3: {"icons\spo.paa"};
					case 4: {"\a3\ui_f\data\gui\cfg\Ranks\corporal_gs.paa"};
					case 5: {"\a3\ui_f\data\gui\cfg\Ranks\sergeant_gs.paa"};
					case 6: {"\a3\ui_f\data\gui\cfg\Ranks\lieutenant_gs.paa"};
					case 7: {"\a3\ui_f\data\gui\cfg\Ranks\captain_gs.paa"};
					case 8: {"\a3\ui_f\data\gui\cfg\Ranks\major_gs.paa"};
					},_x getVariable ["realname",name _x]]};
				case (side _x == independent): {format["<t color='#FF0000'><img image='a3\ui_f\data\map\MapControl\hospital_ca.paa' size='1.5'></img></t> %1",_x getVariable ["realname",name _x]]};
				case (_x getVariable["governor",false]): {format["<img image='%1' size='1'></img> %2","icons\govern.paa",_x getVariable["realname",name _x]]};
				default {
					if(!isNil {(group _x) getVariable "gang_name"} && _x getVariable["bountyHunter",false] && !(_x getVariable["hiding",false])) then {
						format["<img image='%3' size='1'></img><t color='#2E9AFE'>[BH] %1<br/><t size='0.8' color='#2E9AFE'>%2</t>",_x getVariable ["realname",name _x],(group _x) getVariable ["gang_name",""],"icons\police.paa"];
					} else {
						if(!isNil {(group _x) getVariable "gang_name"}) then {
							format["%1<br/><t size='0.8' color='#B6B6B6'>%2</t>",_x getVariable ["realname",name _x],(group _x) getVariable ["gang_name",""]];
					} else {
						if(_x getVariable["bountyHunter",false] && !(_x getVariable["hiding",false])) then {
							format["<img image='%2' size='1'></img><t color='#2E9AFE'>[BH] %1",_x getVariable ["realname",name _x],"icons\police.paa"];
						} else { _x getVariable["realname",name _x]; };
					};
				};
			};};
			_idc ctrlSetStructuredText parseText _text;
			_idc ctrlSetPosition [(_sPos select 0)-0.02, _sPos select 1, 0.4, 0.65];
			_idc ctrlSetScale scale;
			_idc ctrlSetFade 0;
			_idc ctrlCommit 0;
			_idc ctrlShow true;
		} else {
			_idc ctrlShow false;
		};
	} else {
		_idc ctrlShow false;
	};
} foreach _units;