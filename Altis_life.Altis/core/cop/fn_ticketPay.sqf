/*
	File: fn_ticketPay.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pays the ticket.
*/
if(isnil {life_ticket_val} OR isNil {life_ticket_cop}) exitWith {};
if(life_handpaper < life_ticket_val) exitWith
{
	if(life_myfunds < life_ticket_val) exitWith 
	{
		life_poorBoy = true;
		hint localize "STR_Cop_Ticket_NotEnough";
		[1,format[localize "STR_Cop_Ticket_NotEnoughNOTF",profileName]] remoteExec ["life_fnc_broadcast",life_ticket_cop,false];
		closeDialog 0;
		[] spawn { sleep 1; life_poorBoy = false; };
	};
	hint format[localize "STR_Cop_Ticket_Paid",[life_ticket_val] call life_fnc_numberText];
	["atm","take",life_ticket_val] call life_fnc_handlePaper;
	life_ticket_paid = true;
	[0,format[localize "STR_Cop_Ticket_PaidNOTF",profileName,[life_ticket_val] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",west];
	[2,format["%1 has paid the ticket, and $%2 has been sent to your bank account.",profileName,life_ticket_val/2]] remoteExec ["life_fnc_broadcast",life_ticket_cop,false];
	["atm","add",life_ticket_val/2] remoteExec ["life_fnc_handlePaper",life_ticket_cop,false];
	[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",2];
	life_wanted = false;
	closeDialog 0;
	[] spawn {
	_action = ["Do you wish to provide valuable feedback on your experience with the ALE today? We are looking for constructive criticism from our players to help improve the police force.", "ALE Survey", "Yes", "No"] call BIS_fnc_guiMessage;
	if(!_action) exitWith {};
	createDialog "STS_life_feedback";
	};
};

["cash","take",life_ticket_val] call life_fnc_handlePaper;
life_ticket_paid = true;

[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",2];
[0,format[localize "STR_Cop_Ticket_PaidNOTF",profileName,[life_ticket_val] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",west];
closeDialog 0;
[2,format["%1 has paid the ticket, and $%2 has been sent to your bank account.",profileName,life_ticket_val/2]] remoteExec ["life_fnc_broadcast",life_ticket_cop,false];
["atm","add",life_ticket_val/2] remoteExec ["life_fnc_handlePaper",life_ticket_cop,false];
life_wanted = false;
[] spawn {
	_action = ["Do you wish to provide valuable feedback on your experience with the ALE today? We are looking for constructive criticism from our players to help improve the police force. You will be compensated for doing so.", "ALE Survey", "Yes", "No"] call BIS_fnc_guiMessage;
	if(!_action) exitWith {};
	createDialog "STS_life_feedback";
};