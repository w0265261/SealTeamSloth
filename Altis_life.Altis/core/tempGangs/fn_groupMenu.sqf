/*
	File: fn_gangMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Checks whether it needs to open the gang management menu or the choice menu.
*/
if(!isNull life_my_gang) then
{
	createDialog "STS_Life_My_Group_Diag";
}
	else
{
	createDialog "STS_Life_Gang_Prompt";
};