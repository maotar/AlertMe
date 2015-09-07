 #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
#Persistent ; Keep the script running until the user exits it.
#SingleInstance

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

IfNotExist, %A_StartupCommon%\AlertMe.exe
{
	FileCopy, %A_ScriptDir%\AlertMe.exe, %A_StartupCommon% 
}


; Create tray menu
Menu, Tray, NoStandard 
Menu, tray, add, Start,Start
Menu, tray, add, Stop,Stop  
Menu, tray, add
Menu, tray, add, Settings,Settings
Menu, tray, add, Exit,ExitOut

; Check if ini file folder exists

FileCreateDir, %A_AppData%\AlertMe

IniFile = %A_AppData%\AlertMe\Settings.ini

IfNotExist, %IniFile%
{
	Gosub, Settings
}
else
{
	Gosub, Start
}

return

Settings:
Gui, Color, C0C0C0

Gui, Add, Checkbox, x20 y20 vCheck1
Gui, Add, Text, x60 y20, Show alert every :
Gui, Add, Edit, x160 y16 w50
Gui, Add, UpDown, vAlertInterval1 Range1-120, 15
Gui, Add, Text, x220 y20, Minutes
Gui, Add, Text, x330 y20, Text to display :
Gui, Add, Edit, x420 y16 w340 vDisplayText1,

Gui, Add, Checkbox, x20 y60 vCheck2
Gui, Add, Text, x60 y60, Show alert every :
Gui, Add, Edit, x160 y56 w50
Gui, Add, UpDown, vAlertInterval2 Range1-120, 30
Gui, Add, Text, x220 y60, Minutes
Gui, Add, Text, x330 y60, Text to display :
Gui, Add, Edit, x420 y56 w340 vDisplayText2,

Gui, Add, Checkbox, x20 y100 vCheck3
Gui, Add, Text, x60 y100, Show alert every :
Gui, Add, Edit, x160 y96 w50
Gui, Add, UpDown, vAlertInterval3 Range1-120, 60
Gui, Add, Text, x220 y100, Minutes
Gui, Add, Text, x330 y100, Text to display :
Gui, Add, Edit, x420 y96 w340 vDisplayText3,

Gui, Add, Checkbox, x20 y160 vCheck4
Gui, Add, Text, x60 y160, Show alert at :
Gui, Add, DateTime, x160 y156 wp vAlertTime1 1, HH:mm
Gui, Add, Text, x330 y160, Text to display :
Gui, Add, Edit, x420 y156 w340 vDisplayText4,

Gui, Add, Checkbox, x20 y200 vCheck5
Gui, Add, Text, x60 y200, Show alert at :
Gui, Add, DateTime, x160 y196 wp vAlertTime2 1, HH:mm
Gui, Add, Text, x330 y200, Text to display :
Gui, Add, Edit, x420 y196 w340 vDisplayText5,

Gui, Add, Checkbox, x20 y240 vCheck6
Gui, Add, Text, x60 y240, Show alert at :
Gui, Add, DateTime, x160 y236 wp vAlertTime3 1, HH:mm
Gui, Add, Text, x330 y240, Text to display :
Gui, Add, Edit, x420 y236 w340 vDisplayText6,

Gui, Add, Button, Default x350 y320 gSaveSettings, Save Settings



Gui, Show, w780 h360, AlertMe Settings

IfExist, %IniFile%
{
	Gosub, ReadSettings
	Gosub, SetSettings
}

return

GuiClose:

Gui, Destroy
return

ReadSettings:
	IniRead, Check1, %IniFile%, Checkboxes, Checkbox1
	IniRead, Check2, %IniFile%, Checkboxes, Checkbox2
	IniRead, Check3, %IniFile%, Checkboxes, Checkbox3
	IniRead, Check4, %IniFile%, Checkboxes, Checkbox4
	IniRead, Check5, %IniFile%, Checkboxes, Checkbox5
	IniRead, Check6, %IniFile%, Checkboxes, Checkbox6

	IniRead, AlertInterval1, %IniFile%, Intervals, Interval1
	IniRead, AlertInterval2, %IniFile%, Intervals, Interval2
	IniRead, AlertInterval3, %IniFile%, Intervals, Interval3

	IniRead, AlertTime1, %IniFile%, Times, Time1
	IniRead, AlertTime2, %IniFile%, Times, Time2
	IniRead, AlertTime3, %IniFile%, Times, Time3

	IniRead, DisplayText1, %IniFile%, Texts, Text1
	IniRead, DisplayText2, %IniFile%, Texts, Text2
	IniRead, DisplayText3, %IniFile%, Texts, Text3
	IniRead, DisplayText4, %IniFile%, Texts, Text4
	IniRead, DisplayText5, %IniFile%, Texts, Text5
	IniRead, DisplayText6, %IniFile%, Texts, Text6


Return

SetSettings:
Loop,6
{
If(Check%A_Index%=0)
	Control, Uncheck,, Button%A_Index%

If(Check%A_Index%=1)
	Control, Check,, Button%A_Index%, AlertMe
}

ControlSetText, Edit1, %AlertInterval1%, AlertMe
ControlSetText, Edit3, %AlertInterval2%, AlertMe
ControlSetText, Edit5, %AlertInterval3%, AlertMe

ControlSetText, Edit2, %DisplayText1%, AlertMe
ControlSetText, Edit4, %DisplayText2%, AlertMe
ControlSetText, Edit6, %DisplayText3%, AlertMe

ControlSetText, Edit7, %DisplayText4%, AlertMe
ControlSetText, Edit8, %DisplayText5%, AlertMe
ControlSetText, Edit9, %DisplayText6%, AlertMe

GuiControl, , SysDateTimePick321, %AlertTime1%
GuiControl, , SysDateTimePick322, %AlertTime2%
GuiControl, , SysDateTimePick323, %AlertTime3%

return

SaveSettings:
Gui, Submit
Gui, Destroy

IniWrite, %Check1%, %IniFile%, Checkboxes, Checkbox1
IniWrite, %Check2%, %IniFile%, Checkboxes, Checkbox2
IniWrite, %Check3%, %IniFile%, Checkboxes, Checkbox3
IniWrite, %Check4%, %IniFile%, Checkboxes, Checkbox4
IniWrite, %Check5%, %IniFile%, Checkboxes, Checkbox5
IniWrite, %Check6%, %IniFile%, Checkboxes, Checkbox6

IniWrite, %AlertInterval1%, %IniFile%, Intervals, Interval1
IniWrite, %AlertInterval2%, %IniFile%, Intervals, Interval2
IniWrite, %AlertInterval3%, %IniFile%, Intervals, Interval3

IniWrite, %AlertTime1%, %IniFile%, Times, Time1
IniWrite, %AlertTime2%, %IniFile%, Times, Time2
IniWrite, %AlertTime3%, %IniFile%, Times, Time3

IniWrite, %DisplayText1%, %IniFile%, Texts, Text1
IniWrite, %DisplayText2%, %IniFile%, Texts, Text2
IniWrite, %DisplayText3%, %IniFile%, Texts, Text3
IniWrite, %DisplayText4%, %IniFile%, Texts, Text4
IniWrite, %DisplayText5%, %IniFile%, Texts, Text5
IniWrite, %DisplayText6%, %IniFile%, Texts, Text6

Goto, Start


Start:
Menu, Tray, Uncheck, Stop
Menu, Tray, Check, Start

Gosub, ReadSettings

If(Check1=1)
{	
	Time1 := AlertInterval1 * 60000
	SetTimer, Timer1, %Time1%
}

If(Check2=1)
{	
	Time2 := AlertInterval2 * 60000
	SetTimer, Timer2, %Time2%
}

If(Check3=1)
{	
	Time3 := AlertInterval3 * 60000
	SetTimer, Timer3, %Time3%
}



StringMid, Timehhmm1, AlertTime1, 9 ,4
StringMid, Timehhmm2, AlertTime2, 9 ,4
StringMid, Timehhmm3, AlertTime3, 9 ,4


Loop,
{
	FormatTime, CurrentTime, , HHmm

	If(Check4=1)
	{
		If(Timehhmm1 = CurrentTime)
		{
			Gosub, Timer4
			Sleep, 70000
		}
	}

	If(Check5=1)
	{
		If(Timehhmm2 = CurrentTime)
		{
			Gosub, Timer5
			Sleep, 70000
		}
	}

	If(Check6=1)
	{
		If(Timehhmm3 = CurrentTime)
		{
			Gosub, Timer6
			Sleep, 70000
		}
	}

	Sleep, 20000
}






return


Timer1:

MsgBox,262144, AlertMe Notification, %DisplayText1%
return

Timer2:

MsgBox,262144, AlertMe Notification, %DisplayText2%
return

Timer3:

MsgBox,262144, AlertMe Notification, %DisplayText3%
return

Timer4:

MsgBox,262144, AlertMe Notification, %DisplayText4%
return

Timer5:

MsgBox,262144, AlertMe Notification, %DisplayText5%
return

Timer6:

MsgBox,262144, AlertMe Notification, %DisplayText6%
return

ExitOut:

ExitApp


Stop:

Menu, Tray, Uncheck, Start
Menu, Tray, Check, Stop


SetTimer, Timer1, Off
SetTimer, Timer2, Off
SetTimer, Timer3, Off

Loop,
{
	Sleep, 100000
}
return
