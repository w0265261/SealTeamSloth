/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Defuses blasting charges for the cops?
*/
private["_vault","_ui","_title","_progressBar","_cP","_titleText"];
_vault = param [0,ObjNull,[ObjNull]];
if(isNull _vault) exitWith {};
if(!(_vault getVariable["chargeplaced",false])) exitWith {hint localize "STR_ISTR_Defuse_Nothing"};

life_action_inUse = true;
/*Setup the progress bar*/
disableSerialization;
_title = localize "STR_ISTR_Defuse_Process";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleText = _ui displayCtrl 38202;
_titleText ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

while {true} do
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + .01742;
	_progressBar progressSetPosition _cP;
	_titleText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR player getVariable["unconscious",false]) exitWith {};
	if(life_interrupted) exitWith {};
};

/*Kill the UI display and check for various states*/
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(player getVariable["unconscious",false] OR !alive player) exitWith {life_action_inUse = false;};
if(life_interrupted) exitWith {life_interrupted = false; titleText[localize "STR_NOTF_ActionCancel","PLAIN"]; life_action_inUse = false;};

life_action_inUse = false;
_vault setVariable["chargeplaced",false,true];
[player, "CT_Win",50] remoteExec ["life_fnc_playSound",0];
[2,localize "STR_ISTR_Defuse_Success"] remoteExec ["life_fnc_broadcast",west];