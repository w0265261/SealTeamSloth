#include <macro.h>
/*
Kevin Webb
fn_feedLBChange.sqf
Handles displaying information
*/
disableSerialization;
_control = _this select 0;
_index = _this select 1;

/*Fetch some information.*/
_dataArr = _control lbData _index; 
_dataArr = call compile format["%1",_dataArr];
_reporterName = (_dataArr select 0) select 0;
_string = "";
_cops = _dataArr select 1;
{_string = _string + format["%1; ",_x]} forEach _cops;
_rating = _dataArr select 2;
_message = _dataArr select 3;
_time = _dataArr select 4;
(getControl(2800,2803)) ctrlSetStructuredText parseText format[
"Reported: %1<br/>Reporter: %2<br/>Rating: %3 out of 4<br/>Message: %4",
_string,
_reporterName,
_rating,
_message
];