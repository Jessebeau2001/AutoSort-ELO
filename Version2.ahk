slowMode = true
#InstallkeybdHook
^F5::Reload

^Numpad0::
IDfetcher()
return

^Numpad1::
IDfetcher()
Send {backspace}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Enter}{Tab}{Tab}{Tab}{Enter}
return

^Numpad2::
IDfetcher()
Send {backspace}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Down}{Enter}{Tab}{Down}{Down}{Enter}{Tab}{Tab}{Enter}
Return

^Numpad3::
Send {F4}
Clicky()
IDfetcher()
Send {Backspace}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Down}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
return

^Numpad4::
IDfetcher()
Send {Backspace}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
return

^Numpad5::
IDfetcher()
Send {Backspace}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
return

^Numpad6::
IDfetcher()
Promt()
return

^Numpad7::
IDfetcher()
Send {Backspace}{Down}{Down}{Down}{Right}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Tab}{Down}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Enter}
WinWait, Gebruiker selecteren,, 10
if ErrorLevel
{
	MsgBox, Timed out!
	return
}
else
WinActivate, Gebruiker selecteren
Sleep, 300
Send {Tab}{Tab}{Tab}{Enter}
WinWait, Er is geen user geselecteerd,, 10
if ErrorLevel
{
	MsgBox, Timed out!
	return
} else
WinActivate, Er is geen user geselecteerd
Send {Enter}
return

^Numpad8::
IDfetcher()
Send {Backspace}{Down}{Down}{Down}{Down}{Down}{Down}{Right}{Down}{Down}{Down}{Down}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
return

^Numpad9::
IDfetcher()
Send {Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}{Tab}{Down}{Down}{Enter}{Tab}{Tab}{Tab}{Tab}{Enter}
return

IDfetcher() {
	Send {F4}
	WinWait, Index voor nieuw document,, 2
	if ErrorLevel
		{
		MsgBox, Timed out!
		} else
	Sleep 100
	Send {Tab}{Tab}
	WinActivate Dossier Klanten
	Send {Home}{F2}{Home}+^{Right}+{Left}^{c}{esc}
	WinActivate Index voor nieuw document
	Send ^v
	WinMove, Index voor nieuw document,,,, 1000, 800
	Sleep, 2500
	Send {Down}{Enter}
	Send {Tab}{Tab}
}

^p::
WinActivate Dossier Klanten
Send Home
KeyWait Control
Sleep, 400
Send  {Del}
KeyWait, Enter, D
if (slowMode = "true") {
	WinWait, ahk_class OperationStatusWindow,, 2
	if ErrorLevel {
		MsgBox, Not found, Maybe you'll want to try disabling slowMode by hitting Crtl+L
		return
	} else {
	WinWaitClose, ahk_class OperationStatusWindow,, 10
		if ErrorLevel {
		MsgBox, Not closed?
		return
		}
	Sleep, 200
	}
} else
resumeDel:
Sleep, 400
ImportMoveRel()
WinActivate ELO
return

Isolate() {
	WinActivate, Dossier Klanten
	Send {F2}{Home}+{A}{Space}{Enter}
	Sleep, 2000
	Send {Home}
}

Promt() {
	InputBox, notFound, Available?, Customer registered y/n?, 640, 480, , 10, y/n
	if ErrorLevel {
		MsgBox, Are you still there?
	} else if (notFound = "y") {
		Send {Esc}
	} else if (notFound = "n"){
		WinActivate Index voor nieuwe document
		Send {Esc}
		WinActivate ELO
		Sleep, 400
		Send ^{a}^{Del}
		WinWait, Bestand(en),, 10
		if ErrorLevel {
			MsgBox, Error!
			return
			} else
		Send {Enter}
		Sleep, 1000
		Isolate()
		Sleep, 200
		WinActivate Dossier Klanten
		MouseClickDrag, Left, 250, 125, -1700, 400, 5
		WinActivate ELO
		Sleep, 2500
		Send ^t{Up}
	} else {
		MsgBox, Out of range, can only be y/n
		Promt()
	}
}

Clicky() {
	WinWait Index voor nieuw document
	WinMove Index voor nieuw document,,,, 1000, 800
	WinActivate Index voor nieuw document
	MouseClick Left, 40, 250
}

^l::
if (slowMode = "true") {
	slowMode = false
	MsgBox,,slowMode , SlowMode is now disabled!, 2
	return
	} else
slowMode = true
MsgBox,,slowMode , SlowMode is now enabled!, 2
return

^m::
if FileExist("conf.txt") {
	MsgBox, Exists!!
	} else {
		FileAppend,, conf.txt
		MsgBox, Created new config file beacause there was not an existing one!
	}
return

ImportMoveRel(){
WinActivate, ELO
MouseMove, 90, 240, 2
WinActivate, Dossier Klanten
MouseGetPos, ELO_X, ELO_Y
MouseMove, 250, 125, 2
MouseGetPos, Dos_X, Dos_Y
MouseClickDrag, Left, Dos_X, Dos_Y, ELO_X, ELO_Y, 2
}
