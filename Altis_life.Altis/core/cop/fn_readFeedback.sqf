/*
Kevin Webb
fn_readFeedback.sqf
Sends the request off to get our data from the good ole' database
*/
_case = param[0,0];
switch(_case) do {
	case 0: {
		player remoteExecCall ["life_fnc_getFeedback",2];   
		createDialog "STS_Read_Feedback";     
	};
	case 1: {
		disableSerialization;
		_info = param[1];
		if(count _info == 0) exitWith {hint "No feedback found."};
		ctrlShow[2811,false]; ctrlShow[2810,false];
		_control = ((findDisplay 2800) displayCtrl 2802);
		lbClear _control;
		{
			_reporter = (_x select 0) select 0;
			_control lbAdd _reporter;
			_control lbSetData [(lbSize _control)-1,str _x];
		} forEach _info;
	};
};