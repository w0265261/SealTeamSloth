/*
        Version: 1.0
       
        Author: Stephen "Aceshooter11" MacDonald
        Edited: 2.9.2013
        Updated By: N/A
        This is for Use only on Seal Team Sloth
*/
private ["_pos"];

if (player getVariable ["unconscious",false]) exitWith {};


surrender = true;
while { !isNil "surrender" }  do { 
	player playMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon"; /* hands up*/
};
player playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"; /* hands down*/

