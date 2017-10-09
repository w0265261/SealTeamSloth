/*
fn_keyUpHandler.sqf
Kevin Webb
For things which would better serve their purposes as a keyup, not a keydown event
*/
_code = _this select 1;
_handled = false;
if (_code==41 || _code in (actionKeys "SelectAll") || _code in (actionKeys "SwitchCommand")) then
{
	if (life_targetTag) then { life_targetTag = false };
	_handled = true;
};
switch(_code) do {
	case 9:
	{
		if (life_phone_status == 1) then
		{
			life_phone_status = 0;
			_handled = true;
		}
	};
	case 10:
	{
		if (life_phone_status == 1) then
		{
			life_phone_status = 3;
			_handled = true;
		};
	};
};
_handled;