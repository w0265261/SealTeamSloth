/*
fn_jailmonitor.sqf
Kevin Webb
Monitors the position of the jail entrance.
*/
_param = param [0,ObjNull,[ObjNull]];
_jail = param [1,ObjNull,[ObjNull]];
_case = param [2,-1,[0]];
switch(_case) do
{
case 0:
{
sleep 45;
_param setPosATL [getPos _jail select 0,getPos _jail select 1,(getPosATL _jail select 2)-2.6];
sleep 15;
Jail_Target setVariable["jailBreak",false,true];
};
case 1:
{
sleep 450;
_param setVariable["safe_open",false,true];
_param setVariable["cooldown",time,true];
};
};