/*
	File: fn_jurySummons.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Summoned to jury duty.
*/
_defendant = param [0,objNull,[objNull]];
if(life_wanted || player in (units _defendant) || life_is_arrested) exitWith {}; //Not eligible!
["GovMessage",["You have received a Jury Summons!"]] call bis_fnc_showNotification;
hint parseText format ["<t color='#00FF00'><t size='2'><t align='center'>Jury Summons<br/><br/><br/><t align='left'><t size='1'><t color='#ffffff'>You have been summoned to jury duty for the case of %2 v. %1! You will be <t color='#00FF00'>rewarded with $2,000</t>. Sign in at the nearest <t color='#00FF00'>courthouse</t> within 5 minutes to attend.", worldName, name _defendant];

life_jury_registered = false;