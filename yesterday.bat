 @if (@x)==(@y) @end /***** jscript comment ******
     @echo off

     cscript //E:JScript //nologo "%~f0"
     exit /b 0

 @if (@x)==(@y) @end ******  end comment *********/

var d = new Date();
d.setDate(d.getDate() - 1);

var mm=(d.getMonth())+1
if (mm<10){
  mm="0"+mm;
}
var dd=d.getDate();
if (dd<10) {
 dd="0"+dd;
}
WScript.Echo(d.getFullYear()+""+mm+""+dd);