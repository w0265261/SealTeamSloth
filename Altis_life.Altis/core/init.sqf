#include <macro.h>
/*
	Master client initialization file
*/
life_firstSpawn = true;
life_session_completed = false;
private["_handle","_timeStamp"];
0 cutText["Setting up client, please wait...","BLACK FADED"];
0 cutFadeOut 9999999;
_timeStamp = diag_tickTime;
waitUntil {!isNull player && player == player}; /*Wait till the player is ready*/
/*Setup initial client core functions*/
[] call compile PreprocessFileLineNumbers "core\configuration.sqf";
[] call life_fnc_setupEVH;
waitUntil {(!isNil {clientGangLeader})};
0 cutText ["Waiting for the server to be ready...","BLACK FADED"];
0 cutFadeOut 99999999;
waitUntil{!isNil "life_server_isReady"};
waitUntil{(life_server_isReady OR !isNil "life_server_extDB_notLoaded")};
if(!isNil "life_server_extDB_notLoaded") exitWith {
	999999 cutText ["The server-side extension extDB was not loaded into the engine, report this to the server admin.","BLACK FADED"];
	999999 cutFadeOut 99999999;
};
{
	_var = format["undercover_%1",_x];
	if((missionNamespace getVariable[_var,ObjNull]) == player) exitWith {undercover = true};
} forEach [1,2,3,4];
[] call SOCK_fnc_dataQuery;
waitUntil {life_session_completed};
0 cutText["Finishing client setup procedure","BLACK FADED"];
0 cutFadeOut 9999999;

[] spawn life_fnc_escInterupt;

switch (playerSide) do
{
	case west:
	{
		_handle = [] spawn life_fnc_initCop;
		waitUntil {scriptDone _handle};
	};
	
	case civilian:
	{
		/*Initialize Civilian Settings*/
		_handle = [] spawn life_fnc_initCiv;
		waitUntil {scriptDone _handle};
	};
	
	case independent:
	{
		/*Initialize Medics and blah*/
		_handle = [] spawn life_fnc_initMedic;
		waitUntil {scriptDone _handle};
	};
};

[] execFSM "core\fsm\client.fsm";

waitUntil {!(isNull (findDisplay 46))};

(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call life_fnc_keyHandler"];
(findDisplay 46) displayAddEventHandler ["KeyUp", "_this call life_fnc_keyUpHandler"];
(findDisplay 46) displayAddEventHandler ["MouseZchanged", "_this spawn life_fnc_enableActions"];
player addRating 99999999;

life_sidechat = true;
_side = if(playerSide in[independent,west] && !undercover) then {west} else {civilian};
[player,life_sidechat,_side] remoteExec ["TON_fnc_managesc",2];
0 cutText ["","BLACK IN"];
[] call life_fnc_hudSetup;
LIFE_ID_PlayerTags = ["LIFE_PlayerTags","onEachFrame","life_fnc_playerTags"] call BIS_fnc_addStackedEventHandler;
[] call life_fnc_settingsInit;
player setVariable["realname",if(life_realname != "") then {life_realname} else {profileName},true];
life_fnc_moveIn = compileFinal
"
	player moveInCargo (_this select 0);
";

life_fnc_garageRefund = compileFinal
"
	_price = _this select 0;
	_unit = _this select 1;
	if(_unit != player) exitWith {};
	if(life_ShakeItOff != ((life_myfunds / 2) + 3)) exitWith {};
	life_myfunds = life_myfunds + _price;
	life_ShakeItOff = (life_myfunds / 2) + 3;
";

KK_fnc_forceRagdoll = compileFinal
"
    if (!isNull objectParent player) exitWith {};
    private ""_rag"";
    _rag = ""Land_Can_V3_F"" createVehicleLocal [0,0,0];
    _rag setMass 1e10;
    _rag attachTo [player, [0,0,0], ""Spine3""];
    _rag setVelocity [0,0,6];
    detach _rag;
    0 = _rag spawn {
        deleteVehicle _this;
    };
";

life_fnc_housePurchased = compileFinal
"
_house = param [0,ObjNull,[ObjNull]];
_price = param [1,0,[0]];
_car = param [2,false,[false]];
life_vehicles pushBack _house;
if(!_car) then {
	life_houses pushBack _house; 
	_house setVariable[""house_owner"",[getPlayerUID player, profileName],true];
} else {
	_house setVariable[""vehicle_info_owners"",[[getPlayerUID player,profileName]],true];
};
[""atm"",""take"",_price] call life_fnc_handlePaper;
hint ""You have received keys to your new asset!"";
";
life_fnc_houseSold = compileFinal
"
hint 'The house you listed for sale has been sold and the asking price has been transferred to your bank account';
_house = param [0,ObjNull,[ObjNull]];
_price = param [1,0,[0]];
life_vehicles = life_vehicles - [_house];
life_houses = life_houses - [_house];
['atm','add',_price] call life_fnc_handlePaper;
";
life_fnc_call = compileFinal 
"
_params = param[0,[]];
_code = param[1,{}];
_target = param[2,ObjNull];
_isSpawn = param[3,false];
_command = if(_isSpawn) then {'spawn'} else {'call'};
if(isNull _target) exitWith {call compile format['_params %1 _code',_command]};
[_params,_code,nil,_isSpawn] remoteExecCall ['life_fnc_call',_target];
";
life_fnc_capNotice = compileFinal
"
_zone = _this select 0;
_win = param [1,false,[false]];
_enemy = param [2,"""",[""""]];
if(_win) then {
	hint parseText format [""<t align='center'><t color='#FF0000'><t size='2'>Congratulations!</t></t><br/><br/><t color='#ffffff'>You have captured the <t color='#00ff00'>%1</t>!"",_zone];
} else {
	hint parseText format [""<t align='center'><t color='#FF0000'><t size='2'>Attention</t></t><br/><br/><t color='#ffffff'>Your territory zone, <t color='#00ff00'>%1</t>, is being captured by the gang known as %2!"",_zone,_enemy];
};
";

[] execVM "core\init_survival.sqf";
[] execVM "IgiLoad\IgiLoadInit.sqf";
[] execVM "dialog\markerFilterInit.sqf";
__CONST__(life_paycheck,life_paycheck);


player enableFatigue false;
/*[] spawn {
	while{true} do {
		sleep 300;
		call SOCK_fnc_updateRequest;
	};
};*/


_pumpClass = "Land_fs_feed_F";
_pumps = [[9205.75,12112.2,-0.0487232],[11831.6,14155.9,-0.0342026],[12024.7,15830,-0.0298138],[12026.6,15830.1,-0.0342979],[12028.4,15830,-0.0388737],[9025.78,15729.4,-0.0206451],[9023.75,15729,-0.027153],[9021.82,15728.7,-0.0293427],[16750.9,12513.1,-0.0525198],[6798.15,15561.6,-0.0441475],[6198.83,15081.4,-0.0912418],[14173.2,16541.8,-0.0946102],[5023.26,14429.6,-0.0978947],[5019.68,14436.7,-0.0114822],[4001.12,12592.1,-0.0966625],[17417.2,13936.7,-0.106519],[3757.14,13477.9,-0.0540276],[3757.54,13485.9,-0.010498],[16875.2,15469.4,0.0373325],[16871.7,15476.6,0.0102873],[8481.69,18260.7,-0.0266876],[15297.1,17565.9,-0.283808],[14221.4,18302.5,-0.0697155],[15781,17453.2,-0.285282],[19961.3,11454.6,-0.0349236],[19965.1,11447.6,-0.0483704],[5768.99,20085.7,-0.0189667],[21230.4,7116.56,-0.0604229],[20784.8,16665.9,-0.0521202],[20789.6,16672.3,-0.0213318],[23379.4,19799,-0.0544052],[25701.2,21372.6,-0.0774155]];
{
	_pump = (nearestObject [_x, _pumpClass]);
	_pump setFuelCargo 0;
	_pump addAction ["Refuel nearest vehicle", life_fnc_refuelVehicle, 1, 3, true, true, "", ' player distance _target < 5 && isNull objectParent player'];
} forEach _pumps;