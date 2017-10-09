/*
file: fn_removeMask.sqf
author: Kevin Webb
description: allows police to remove the mask of  "masked men"
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
removeHeadgear _unit;
removeGoggles _unit;