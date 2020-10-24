Name "AutoMuteUs Installer" ; Name of The Window
OutFile "AutoMuteUs Installer.exe" ; Name of the executable Installer
Caption "$(^Name)"

Unicode True
XPStyle on
RequestExecutionLevel user

!include nsDialogs.nsh

; Default Installation Directory
InstallDir $LOCALAPPDATA\AutoMuteUs


Page components
Page directory
Page instfiles
Page custom nsDialogsPage


Section "AmongUsCompanion"

  SectionIn RO
  
  SetOutPath $INSTDIR

; Files to be installed (change name for new version)
  File "amongusdiscord_2.3.4_windows_32bit.exe"
  File "AmongUsCapture.exe"
  File "shhh.ico"

SectionEnd

Var EDIT

Function nsDialogsPage
    nsDialogs::Create 1018
    Pop $0

    Pop $EDIT
    GetFunctionAddress $0 OnChange
    nsDialogs::OnChange $EDIT $0

    ${NSD_CreateText} 0 35 100% 12u ""
    Pop $EDIT
    GetFunctionAddress $0 OnChange
    nsDialogs::OnChange $EDIT $0

    ${NSD_CreateLabel} 0 40u 75% 40u "Paste Bot Token here"
    Pop $0

    nsDialogs::Show
FunctionEnd

Function OnChange
    Pop $0

    System::Call user32::GetWindowText(p$EDIT,t.r0,i${NSIS_MAX_STRLEN})
    FileOpen $4 "$INSTDIR\final.txt" w
    FileWrite $4 "DISCORD_BOT_TOKEN = $0"
    FileClose $4
FunctionEnd

Section "Desktop Shortcut" SectionX
    SetShellVarContext current
    CreateShortCut "$DESKTOP\AutoMuteUs.lnk" "$INSTDIR\amongusdiscord_2.3.4_windows_32bit.exe" "" "$INSTDIR\shhh.ico"
SectionEnd
