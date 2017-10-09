/*
	File: welcomecredits.sqf
	Author: HellsGate
	Date: 14/12/2013
	Description:
	Creates an intro on the bottom-right hand corner of the screen.
	Modified by Kevin for STS
*/

_onScreenTime = 1.5; /*<-- How long is the text on the screen for ? Recommended: 1 */

sleep 28; /*Wait in seconds before the credits start after player is in-game*/

_role1 = "Welcome To";
_role1names = ["The Seal Team Sloth Altis Life Server."];
_role2 = "Community Managers:";
_role2names = ["Marvel","Sly","Cage","Flawless","Kenny","Woolsy","GZR"];
_role3 = "Senior Administrators:";
_role3names = ["Bamies"];
_role4 = "Server Administrators:";
_role4names = ["BrianPc","Lama","Holmes","Smoothie"];
_role5 = "Developers";
_role5names = ["Marvel","Kevin","Josh"];
_role6 = "Website:";
_role6names = ["WWW.Sealteamsloth.Life"];
_role7 = "TeamSpeak:";
_role7names = ["ts.sealteamsloth.life"];
_role8 = "Important Notice:";
_role8names = ["Cops and Medics MUST be on TeamSpeak"];
_role9 = "Important Notice:";
_role9names = ["Please press M and read the server rules, controls, and tutorial"];
_role10 = "Current President";
_role10names = [format["%1",life_rules select 5]];

{
sleep 2;
_memberFunction = _x select 0;
_memberNames = _x select 1;
_finalText = format ["<t size='0.55' color='#a6f20b' align='right'>%1<br /></t>", _memberFunction];
_finalText = _finalText + "<t size='0.70' color='#FFFFFF' align='right'>";
{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
_finalText = _finalText + "</t>";
_onScreenTime + (((count _memberNames) - 1) * 0.9);
[
_finalText,
[safezoneX + safezoneW - 0.5,0.35],
[safezoneY + safezoneH - 0.8,0.7],
_onScreenTime,
0.5
] spawn BIS_fnc_dynamicText;
sleep (_onScreenTime);
} forEach [
/*The list below should have exactly the same amount of roles as the list above*/
[_role1, _role1names],
[_role2, _role2names],
[_role3, _role3names],
[_role4, _role4names],
[_role5, _role5names],
[_role6, _role6names],
[_role7, _role7names],
[_role8, _role8names],
[_role9, _role9names],
[_role10, _role10names]
];