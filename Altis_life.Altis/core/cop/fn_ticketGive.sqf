/*
	File: fn_ticketGive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Gives a ticket to the targeted player.
*/
private["_val","_pubCop"];

_pubCop = player getVariable "rank";
if(_pubCop < 1) exitWith {hint "No Ticketing for Public Cops. Contact a Whitelisted Officer.";};

if(isNil {life_ticket_unit}) exitWith {hint localize "STR_Cop_TicketNil"};
if(isNull life_ticket_unit) exitWith {hint localize "STR_Cop_TicketExist"};
_val = ctrlText 2652;
if(!([_val] call fnc_isnumber)) exitWith {hint localize "STR_Cop_TicketNum"};
if((parseNumber _val) > 100000) exitWith {hint localize "STR_Cop_TicketOver100"};
[0,format[localize "STR_Cop_TicketGive",profileName,[(parseNumber _val)] call life_fnc_numberText,life_ticket_unit getVariable["realname",name life_ticket_unit]]] remoteExec ["life_fnc_broadcast",0];
[player,(parseNumber _val)] remoteExec ["life_fnc_ticketPrompt",life_ticket_unit,false];
closeDialog 0;