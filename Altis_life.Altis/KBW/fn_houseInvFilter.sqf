/*
fn_houseInvFilter.sqf
Kevin Webb
Re-used some weapon shop code
*/
_index = param [1,-1,[0]];

_itemList = ((findDisplay 38400) displayCtrl 38403);
lbClear _itemList;
_inv = (nearestBuilding (position player)) getVariable["containers",[]];
//begin temporary codeblock for converting from old inventory format
_test = if(count _inv > 0) then {_inv select 0} else {[]};
if(count _test > 0 && {typeName (_test select 1) == "ARRAY"}) then {
	_inventory = [];
	{
		_temp = _x select 1;
		{
			for [{_i=0},{_i<count (_x select 0)},{_i=_i+1}] do {
				_inventory pushBack [(_x select 0) select _i,(_x select 1) select _i];
			};
		} forEach _temp;
	} forEach _inv;
	_inv = _inventory;
	(nearestBuilding (position player)) setVariable["containers",_inv,true];
};
//end temp codeblock
uiNamespace setVariable["Weapon_Shop_Filter",_index];
switch (_index) do
{
	case 0:
	{
		{
			_itemInfo = [_x select 0] call life_fnc_fetchCfgDetails;
			_count = _x select 1;
			_displayName = _itemInfo select 1;
			_itemList lbAdd format["%1", _displayName + format[" x%1",_count]]; //format inception, yo?
			_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
			_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
			_itemList lbSetTooltip [(lbSize _itemList)-1, format["%1", _displayName]];
		} foreach _inv;
		
		((findDisplay 38400) displayCtrl 38405) ctrlSetText "Withdraw";
	};
	
	case 1:
	{
		private["_listedItems"];
		_config = [];
		_listedItems = [];
		/*Go through weapons*/
		if(primaryWeapon player != "") then {_config pushBack primaryWeapon player;};
		if(secondaryWeapon player != "") then {_config pushBack secondaryWeapon player;};
		if(handgunWeapon player != "") then {_config pushBack handgunWeapon player;};
		
		/*Go through items*/
		_config = _config + primaryWeaponItems player;
		_config = _config + (assignedItems player);
		_config = _config + (uniformItems player);
		_config = _config + (vestItems player);
		_config = _config + (backPackItems player);
		_config = _config + [vest player];
		_config = _config + [uniform player];
		_config = _config + [backPack player];
		_config = _config + [headGear player];
		_config = _config + [goggles player];
		
		((findDisplay 38400) displayCtrl 38405) ctrlSetText "Deposit";
		{
			if(!(_x in _listedItems) && _x != "") then
			{
				_itemInfo = [_x] call life_fnc_fetchCfgDetails;
				_listedItems pushBack _x;
				
				_itemCount = {_x == (_itemInfo select 0)} count _config;
				if(_itemCount > 1) then
				{
					_itemList lbAdd format["[%2] %1",_itemInfo select 1,_itemCount];
					_itemList lbSetTooltip [(lbSize _itemList)-1, format["[%2] %1",_itemInfo select 1,_itemCount]];
				}
					else
				{
					_itemList lbAdd format["%1",_itemInfo select 1];
					_itemList lbSetTooltip [(lbSize _itemList)-1, format["%1",_itemInfo select 1]];
				};
				_itemList lbSetData[(lbSize _itemList)-1,_itemInfo select 0];
				_itemList lbSetPicture[(lbSize _itemList)-1,_itemInfo select 2];
			};
		} foreach _config;
	};
};