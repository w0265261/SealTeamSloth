/*

	Get market price, otherwise returns -1
	
	INT getPrice [SHORTNAME]

*/

private["_shortname","_ret","_temp"];

_shortname = _this select 0;
_ret = -1;

{
	if( (_x select 0) == _shortname) then
	{
		_temp = _x select 1;
		if(!isNil "_temp") then {
			if(_temp != 0) then {
				_ret = _x select 1;
			};
		};
	};
}
foreach life_market_prices;

_ret;