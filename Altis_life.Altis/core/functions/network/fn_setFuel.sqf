if(typeName (_this select 0) == "BOOL") exitWith {
	_veh = _this select 1;
	_array = getAllHitPointsDamage _veh; 
	{
		if(_veh getHitPointDamage _x > 0.4) then {
			_veh setHitPointDamage[_x,0.4];
		};
	} forEach (_array select 0);
};
(_this select 0) setFuel (_this select 1);