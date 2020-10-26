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

; Files to be installed
  File "amongusdiscord_windows.exe"
  ; File "AmongUsCapture.exe"
  File "shhh.ico"

SectionEnd


Var EDIT
Var CHECKBOX
Var OPTIONALEDIT
Var BUTTON


Function nsDialogsPage
    nsDialogs::Create 1018
    GetDlgItem $0 $HWNDPARENT 1 # Diable Close Button
    EnableWindow $0 0
    
    Pop $0

    Pop $EDIT
    GetFunctionAddress $0 OnChange
    nsDialogs::OnChange $EDIT $0

    ${NSD_CreateText} 0 30 100% 12u ""
    Pop $EDIT
    GetFunctionAddress $0 OnChange
    nsDialogs::OnChange $EDIT $0

    ${NSD_CreateButton} 0 -75 100% 12u "Open Folder"
    Pop $BUTTON
    GetFunctionAddress $0 OnClick
    nsDialogs::OnClick $BUTTON $0

    ${NSD_CreateCheckbox} 2 -50 100% 8u "2nd Bot Token (optional)"
    Pop $CHECKBOX
    GetFunctionAddress $0 OnCheckbox
    nsDialogs::OnClick $CHECKBOX $0

    ${NSD_CreateLabel} 0 40u 75% 40u "1. Paste Bot Token above$\n2. Open the Installation Folder with $\"Open Folder$\" and start$\n   $\"AmongUsCapture.exe$\" once for the Bot to recognise it$\n3. Close the Installer"
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

Function OnClick
    Pop $0

        ExecShell "open" "$INSTDIR"
    GetDlgItem $0 $HWNDPARENT 1 # Enable Close Button
    EnableWindow $0 1
FunctionEnd

Function OnCheckbox
    Pop $0

    ${NSD_CreateText} 0 -30 100% 12u ""
    Pop $OPTIONALEDIT
    GetFunctionAddress $0 OnChangeOptional
    nsDialogs::OnChange $OPTIONALEDIT $0
FunctionEnd


Function OnChangeOptional
    Pop $0

    System::Call user32::GetWindowText(p$OPTIONALEDIT,t.r0,i${NSIS_MAX_STRLEN})
    FileOpen $4 "$INSTDIR\final2.txt" w
    FileWrite $4 "DISCORD_BOT_TOKEN = $0"
    FileClose $4
FunctionEnd


Section "Desktop Shortcut" SectionX
    SetShellVarContext current
    CreateShortCut "$DESKTOP\AutoMuteUs.lnk" "$INSTDIR\amongusdiscord_windows.exe" "" "$INSTDIR\shhh.ico"
SectionEnd
