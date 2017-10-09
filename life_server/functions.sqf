fnc_nearATM =
compileFinal "
private [""_position"", ""_radius"", ""_atms"", ""_objStrLen"", ""_objStr"", ""_dis""];

_position = _this select 0; 
_radius   = _this select 1;

assert (_radius <= 20);
if (typeName _position == ""OBJECT"") then { _position = getPos _position };

_objStr = """";
_objStrLen = 0;
_atms = [];
{
	if ("""" == typeOf _x) then {
		_objStr = toUpper(str _x);
		_objStrLen = count _objStr;
		if(_objStrLen >= 13 ) then {
			_dis = [(position player) select 0, (position player) select 1,0] distance [(position _x) select 0, (position _x) select 1,0];
			if(_objStr select [(_objStrLen - 12), 3] == ""ATM"" && floor(_dis) < 5) then {
				_atms = _atms + [_x];
			};
		};
	};
}forEach nearestObjects [_position, [], _radius];
_atms;
";

publicVariable "fnc_nearAtm";

fnc_atmAction = 
compileFinal "
	STS_actions = STS_actions + [player addAction[""<t color='#ADFF2F'>ATM</t>"",life_fnc_atmMenu,"""",0,false,false,"""",' count([player,3] call fnc_nearATM) > 0 && (vehicle player) == player ']];
";
publicVariable "fnc_atmAction";

fnc_nearPhone =
compileFinal "
private [""_position"", ""_radius"", ""_phones"", ""_objStrLen"", ""_objStr"", ""_dis""];

_position = _this select 0; 
_radius   = _this select 1;

assert (_radius <= 20);
if (typeName _position == ""OBJECT"") then { _position = getPos _position };

_objStr = """";
_objStrLen = 0;
_phones = [];
{
	if ("""" == typeOf _x) then {
		_objStr = toUpper(str _x);
		_objStrLen = count _objStr;
		if(_objStrLen >= 10 ) then {
			_dis = [(position player) select 0, (position player) select 1,0] distance [(position _x) select 0, (position _x) select 1,0];
			if(_objStr select [(_objStrLen - 19), 10] == ""PHONEBOOTH"" && floor(_dis) < 5) then {
				_phones = _phones + [_x];
			};
		};
	};
}forEach nearestObjects [_position, [], _radius];
_phones;
";

publicVariable "fnc_nearPhone";

fnc_phoneAction = 
compileFinal "
	STS_actions = STS_actions + [player addAction[""Use Payphone"",{life_anon = true; createDialog ""STS_Life_my_smartphone""; [] spawn {waitUntil{sleep 0.5; !dialog}; life_anon = false};},"""",0,false,false,"""",' count([player,3] call fnc_nearPhone) > 0 && (vehicle player) == player ']];
";
publicVariable "fnc_phoneAction";

life_fnc_sidechat =
compileFinal "
	if(life_sidechat) then {life_sidechat = false;} else {life_sidechat = true;};
	[player,life_sidechat,playerSide] remoteExec [""TON_fnc_managesc"",2];
	[] call life_fnc_settingsMenu;
";

publicVariable "life_fnc_sidechat";

life_fnc_environment =
compileFinal "
	if(life_environ) then {life_environ = false; enableEnvironment false;} else {life_environ = true; enableEnvironment true;};
	[] call life_fnc_settingsMenu;
";

publicVariable "life_fnc_environment";

fnc_index =
compileFinal "
	private[""_find"",""_limit"",""_select"",""_array"",""_return""];
	_find = _this select 0;
	_array = _this select 1;

	_limit = (count _array)-1;
	for ""_i"" from 0 to _limit do
	{
		_select = _array select _i;
		if((_find in _select) && (isNil {_return})) then
		{
			_return = _i;
		};
	};

	if(isNil {_return}) then {_return = -1;};
	_return;
";

fnc_player_query =
compileFinal "
	private[""_ret""];
	_ret = _this select 0;
	if(isNull _ret) exitWith {};
	if(isNil ""_ret"") exitWith {};
	
	[life_myfunds,life_handpaper,owner player,player] remoteExec [""life_fnc_admininfo"",_ret,false];
";
publicVariable "fnc_player_query";

publicVariable "fnc_index";

WireReceive =
compileFinal "
	private[""_unit"",""_val"",""_from""];
	_val = _this select 0;
	_from = _this select 1;
	if(!([str(_val)] call fnc_isnumber)) exitWith {};
	if(_from == """") exitWith {};
	[""atm"",""add"",_val] call life_fnc_handlePaper;
	hint format[""%1 has wire transferred $%2 to you."",_from,[_val] call life_fnc_numberText];
	
";
publicVariable "WireReceive";

fnc_isnumber =
compileFinal "
	private[""_valid"",""_value"",""_compare""];
	_value = _this select 0;
	_valid = [""0"",""1"",""2"",""3"",""4"",""5"",""6"",""7"",""8"",""9""];
	_array = [_value] call KRON_StrToArray;
	_return = true;
	
	{
		if(_x in _valid) then	
		{}
		else
		{
			_return = false;
		};
	} foreach _array;
	_return;
";

publicVariable "fnc_isnumber";

clientGangKick =
compileFinal "
	private[""_unit"",""_group""];
	_unit = _this select 0;
	_group = _this select 1;
	_perm = param [2,false,[false]];
	if(isNil ""_unit"" OR isNil ""_group"") exitWith {};
	if(player == _unit && (group player) == _group) then
	{
		life_my_gang = ObjNull;
		[player] joinSilent (createGroup civilian);
		hint ""You have been kicked out of the gang."";
		if(!_perm) then {
		[] spawn life_fnc_initGang;
		};
	};
";
publicVariable "clientGangKick";

clientGetKey =
compileFinal "
	private[""_vehicle"",""_unit"",""_giver""];
	_vehicle = _this select 0;
	_unit = _this select 1;
	_giver = _this select 2;
	if(isNil ""_unit"" OR isNil ""_giver"") exitWith {};
	if(player == _unit && !(_vehicle in life_vehicles)) then
	{
		_name = getText(configFile >> ""CfgVehicles"" >> (typeOf _vehicle) >> ""displayName"");
		hint format[""%1 has gave you keys for a %2"",_giver,_name];
		life_vehicles pushBack _vehicle;
	};
";

publicVariable "clientGetKey";

clientGangLeader =
compileFinal "
	private[""_unit"",""_group""];
	_unit = _this select 0;
	_group = _this select 1;
	_perm = param [2,false,[false]];
	if(isNil ""_unit"" OR isNil ""_group"") exitWith {};
	if(player == _unit && (group player) == _group) then
	{
		player setRank ""COLONEL"";
		_group selectLeader _unit;
		hint ""You have been made the new leader."";
		if(_perm) then {
		life_gang_rank = 5;
		player setVariable[""gang_rank"",5,true];
		};
	};
";

publicVariable "clientGangLeader";
/*
	Cell Phone Messaging
	-fnc_cell_textmsg
	-fnc_cell_textcop
	-fnc_cell_textadmin
	-fnc_cell_adminmsg
	-fnc_cell_adminmsgall
*/

/*To Medics*/
fnc_cell_textmedic =
compileFinal "
	private[""_msg""];
	ctrlShow[3020,false];
	_msg = ctrlText 3003;
	if(_msg == """") exitWith {hint ""You must enter a message to send!"";ctrlShow[3020,true];};

	[_msg,name player,5,position player] remoteExec [""clientMessage"",independent,false];
	[] call life_fnc_cellphone;
	hint format[""You sent Emergency Medical Services a message: %1"",_msg];
	ctrlShow[3020,true];
";
/*To One Person*/
fnc_cell_textmsg =
compileFinal "
	private[""_msg"",""_to""];
	ctrlShow[3015,false];
	_msg = ctrlText 3003;
	if(lbCurSel 3004 == -1) exitWith {hint ""You must select a player you are sending the text to!""; ctrlShow[3015,true];};
	_to = call compile format[""%1"",(lbData[3004,(lbCurSel 3004)])];
	if(isNull _to) exitWith {ctrlShow[3015,true];};
	if(isNil ""_to"") exitWith {ctrlShow[3015,true];};
	if(_msg == """") exitWith {hint ""You must enter a message to send!"";ctrlShow[3015,true];};
	_from = """";
	if(life_anon) then { _from = ""Anonymous""; } else { _from = name player; };
	[_msg,_from,0] remoteExec [""clientMessage"",_to,false];
	[] call life_fnc_cellphone;
	hint format[""You sent your target a message: %1"",_msg];
	if(life_anon) exitWith { life_anon = false; closeDialog 0; };
	ctrlShow[3015,true];
";
/*To All Cops*/
fnc_cell_textcop =
compileFinal "
	private[""_msg"",""_to""];
	if(count _this != 0) then { _msg = _this select 0; } else {
	ctrlShow[3016,false];
	_msg = ctrlText 3003; };
	_to = ""The Police"";
	if(_msg == """" || isNil ""_msg"") exitWith {hint ""You must enter a message to send!"";ctrlShow[3016,true];};
	_from = """";
	if(life_anon) then { _from = ""Anonymous""; } else { _from = name player; };
	[_msg,_from,1,position player] remoteExec [""clientMessage"",west,false];
	if(count _this != 0) exitWith {};
	[] call life_fnc_cellphone;
	hint format[""You sent %1 a message: %2"",_to,_msg];
	if(life_anon) exitWith { life_anon = false; closeDialog 0; };
	ctrlShow[3016,true];
";
/*To All Admins*/
fnc_cell_textadmin =
compileFinal "
	private[""_msg"",""_to"",""_from""];
	if(count _this != 0) then { _msg = _this select 0; } else {
	ctrlShow[3017,false];
	_msg = ctrlText 3003; };
	_to = ""The Admins"";
	if(_msg == """" || isNil ""_msg"") exitWith {hint ""You must enter a message to send!"";ctrlShow[3017,true];};

	[_msg,name player,2] remoteExec [""clientMessage"",0];
	if(count _this != 0) exitWith {};
	[] call life_fnc_cellphone;
	hint format[""You sent %1 a message: %2"",_to,_msg];
	ctrlShow[3017,true];
";
/*Admin To One Person*/
fnc_cell_adminmsg =
compileFinal "
	if(isServer && isDedicated) exitWith {};
	if((call style) < 1) exitWith {hint ""You are not an admin!"";};
	private[""_msg"",""_to""];
	_msg = ctrlText 3003;
	_to = call compile format[""%1"",(lbData[3004,(lbCurSel 3004)])];
	if(isNull _to) exitWith {};
	if(_msg == """") exitWith {hint ""You must enter a message to send!"";};

	[_msg,name player,3] remoteExec [""clientMessage"",_to,false];
	[] call life_fnc_cellphone;
	hint format[""Admin Message Sent To: %1 - Message: %2"",name _to,_msg];
";

fnc_cell_adminmsgall =
compileFinal "
	if(isServer && isDedicated) exitWith {};
	if((call style) < 1) exitWith {hint ""You are not an admin!"";};
	private[""_msg"",""_from""];
	if(count _this != 0) then { _msg = _this select 0; } else {
	_msg = ctrlText 3003; };
	if(_msg == """" || isNil ""_msg"") exitWith {hint ""You must enter a message to send!"";};

	[_msg,name player,4] remoteExec [""clientMessage"",0];
	if(count _this != 0) exitWith {};
	[] call life_fnc_cellphone;
	hint format[""Admin Message Sent To All: %1"",_msg];
";

publicVariable "fnc_cell_textmsg";
publicVariable "fnc_cell_textcop";
publicVariable "fnc_cell_textadmin";
publicVariable "fnc_cell_adminmsg";
publicVariable "fnc_cell_adminmsgall";
publicVariable "fnc_cell_textmedic";

/*Client Message*/
/*
	0 = private message
	1 = police message
	2 = message to admin
	3 = message from admin
	4 = admin message to all
	5 = medic message
*/
clientMessage =
compileFinal "
	private[""_msg"",""_from"", ""_type"", ""_pos"", ""_posx"", ""_posy"", ""_loc""];
	_msg = _this select 0;
	_from = _this select 1;
	_type = _this select 2;
	_pos = _this select 3;
	if(_from == """") exitWith {};
	switch (_type) do
	{
		case 0 :
		{
			private[""_message""];
			_message = format["">>>MESSAGE FROM %1: %2"",_from,_msg];
			hint parseText format [""<t color='#FFCC00'><t size='2'><t align='center'>New Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>You<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2"",_from,_msg];

			[""TextMessage"",[format[""You Received A New Private Message From %1"",_from]]] call bis_fnc_showNotification;
			systemChat _message;
			playSound ""sms"";
		};

		case 1 :
		{
			if(side player != west) exitWith {};
			private[""_message""];
			_message = format[""---911 DISPATCH FROM %1: %2"",_from,_msg];
			_loc = mapGridPosition _pos;
			hint parseText format [""<t color='#316dff'><t size='2'><t align='center'>New Dispatch<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Officers<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><t color='#33CC33'>Message: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Location: <br/><t color='#ffffff'>%3"",_from,_msg,_loc];

			[""PoliceDispatch"",[format[""A New Police Report From: %1"",_from]]] call bis_fnc_showNotification;
			systemChat _message;
		};

		case 2 :
		{
			if((call style) < 1) exitWith {};
			private[""_message""];
			_message = format[""???ADMIN REQUEST FROM %1: %2"",_from,_msg];
			hint parseText format [""<t color='#ffcefe'><t size='2'><t align='center'>Admin Request<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>Admins<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%2"",_from,_msg];

			[""AdminDispatch"",[format[""%1 Has Requested An Admin!"",_from]]] call bis_fnc_showNotification;
			systemChat _message;
			playSound ""sms"";
		};

		case 3 :
		{
			private[""_message""];
			_message = format[""!!!ADMIN MESSAGE: %1"",_msg];
			_admin = format[""Sent by admin: %1"", _from];
			hint parseText format [""<t color='#FF0000'><t size='2'><t align='center'>Admin Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>You<br/><t color='#33CC33'>From: <t color='#ffffff'>An Admin<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1"",_msg];

			[""AdminMessage"",[""You Have Received A Message From An Admin!""]] call bis_fnc_showNotification;
			systemChat _message;
			if((call style) > 0) then {systemChat _admin;};
			playSound ""sms"";
		};

		case 4 :
		{
			private[""_message"",""_admin""];
			_message = format[""!!!ADMIN MESSAGE: %1"",_msg];
			_admin = format[""Sent by admin: %1"", _from];
			hint parseText format [""<t color='#FF0000'><t size='2'><t align='center'>Admin Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Players<br/><t color='#33CC33'>From: <t color='#ffffff'>The Admins<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1"",_msg];

			[""AdminMessage"",[""You Have Received A Message From An Admin!""]] call bis_fnc_showNotification;
			systemChat _message;
			if((call style) > 0) then {systemChat _admin;};
			playSound ""sms"";
		};

		case 5 :
		{
			if(side player != independent) exitWith {};
			private[""_message""];
			_message = format[""---911 DISPATCH FROM %1: %2"",_from,_msg];
			_posx = _pos select 0;
			_posx = floor(_posx / 100);
			switch (true) do {
				case (_posx < 100): { _posx = format[""0%1"",_posx]; };
				case (_posx < 10): { _posx = format[""00%1"",_posx]; };
			};
			_posy = _pos select 1;
			_posy = floor(_posy / 100);
			switch (true) do {
				case (_posy < 100): { _posy = format[""%1"",_posy]; };
				case (_posy < 10): { _posy = format[""00%1"",_posy]; };
			};
			_loc = format[""%1%2"",_posx,_posy];
			hint parseText format [""<t color='#316dff'><t size='2'><t align='center'>New Dispatch<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Medics<br/><t color='#33CC33'>From: <t color='#ffffff'>%1<br/><t color='#33CC33'>Message: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Location: <br/><t color='#ffffff'>%3"",_from,_msg,_loc];

			[""PoliceDispatch"",[format[""A New Medic Request From: %1"",_from]]] call bis_fnc_showNotification;
			systemChat _message;
			playSound ""sms"";
		};
		
		case 6 :
		{
			hint parseText format [""<t color='#3ADF00'><t size='2'><t align='center'>Presidential Message<br/><br/><t color='#33CC33'><t align='left'><t size='1'>To: <t color='#ffffff'>All Players<br/><t color='#33CC33'>From: <t color='#ffffff'>%2<br/><br/><t color='#33CC33'>Message:<br/><t color='#ffffff'>%1"",_msg,_from];

			[""GovMessage"",[""You Have Received A Message From The President!""]] call bis_fnc_showNotification;
			systemChat _msg;
			playSound ""sms"";
		};
	};
";
publicVariable "clientMessage";
fnc_findChargeAmt = {
switch(_this) do
{
	case "Murder": {5000};
	case "Murder of an Officer": {7500};
	case "Kidnapping": {2000};
	case "Mugging": {1000};
	case "Armed Robbery": {2200};
	case "Att. GTA": {800};
	case "Assault with Firearm": {3000};
	case "Firing on an Officer": {4000};
	case "Breaking and Entering": {500};
	case "Initiating Jailbreak": {900};
	case "Tampering with the Fed": {1000};
	case "Att. Burglary": {300};
	case "Hit and run": {1300};
	case "Search Warrant - Alcohol": {0};
	case "GTA": {1000};
	case "Supplying Chop Shop": {1500};
	case "Criminal Threatening": {200};
	case "Obstruction of Justice": {800};
	case "Aviation Violation": {700};
	case "2nd Degree GTA": {500};
	case "Moving Violation": {100};
	case "Possession": {200};
	case "Felony Possession": {1000};
	case "Search Warrant - Drugs": {0};
	case "Aiding Escape": {500};
	case "Bank Robbery": {2000};
	case "Att. Murder": {1500};
	case "Presidential Assassination": {10000};
	case "Evasion": {1000};
	case "Proven Drug Trafficking": {2200};
	case "Poaching": {1100};
	default {0};
};
};
publicVariable "fnc_findChargeAmt";