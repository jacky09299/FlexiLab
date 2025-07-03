; �p�u��� NSIS �w�˸}��
; �s�X: UTF-8
; �䴩: �����w�ˡB�R�q��s�B��ʭ��Ʀw��

; �򥻳]�w
!define PRODUCT_NAME "FlexiTools"
!define PRODUCT_VERSION "1.0.0"
!define PRODUCT_PUBLISHER "���T�t"
!define PRODUCT_WEB_SITE "https://github.com/jacky09299/FlexiTools"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\FlexiTools.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; �]�t�{�N UI
!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "FileFunc.nsh"

; �]�w�w���ɮ��ݩ�
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "FlexiToolsInstaller.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

; �n�D�޲z���v��
RequestExecutionLevel admin

; �R�q�w�ˤ䴩
SilentInstall normal

; �����]�w
!define MUI_ABORTWARNING
!define MUI_ICON "tools.ico"
!define MUI_UNICON "tools.ico"

; �w�ﭶ��
!insertmacro MUI_PAGE_WELCOME

; ���v��ĳ�����]�i��^
; !insertmacro MUI_PAGE_LICENSE "license.txt"

; ��ܦw�˥ؿ�����
!insertmacro MUI_PAGE_DIRECTORY

; ��ܤ��󭶭�
!insertmacro MUI_PAGE_COMPONENTS

; �w�˭���
!insertmacro MUI_PAGE_INSTFILES

; ��������
!define MUI_FINISHPAGE_RUN "$INSTDIR\FlexiTools.exe"
!insertmacro MUI_PAGE_FINISH

; ��������
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; �y���]�w
!insertmacro MUI_LANGUAGE "TradChinese"

; ������T
VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "Comments" "FlexiToolsInstaller"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalTrademarks" ""
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalCopyright" "c ${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileDescription" "${PRODUCT_NAME} �w�˵{��"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductVersion" "${PRODUCT_VERSION}"

; �����ܼ�
Var IsUpdateMode
Var IsFirstInstall
Var SavesBackupPath

; �D�n�w�˰Ϭq
Section "Main Program" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  ; �ˬd�O�_����s�Ҧ��A�p�G�O�h�ƥ� saves ��Ƨ�
  ${If} $IsUpdateMode == "1"
    DetailPrint "Update mode detected, backing up user data..."
    IfFileExists "$INSTDIR\_internal\modules\saves\*.*" 0 +3
      CreateDirectory "$TEMP\FlexiTools_Backup"
      CopyFiles /SILENT "$INSTDIR\_internal\modules\saves\*.*" "$TEMP\FlexiTools_Backup"
      StrCpy $SavesBackupPath "$TEMP\FlexiTools_Backup"
  ${EndIf}
  
  ; �ƻs�D�{���ɮ�
  File "dist\FlexiTools\FlexiTools.exe"
  
  ; �إߪ����ɮ�
  FileOpen $0 "$INSTDIR\version.txt" w
  FileWrite $0 "v${PRODUCT_VERSION}"
  FileClose $0
  
  ; �ƻs _internal �ؿ��Ψ�Ҧ����e
  File /r "dist\FlexiTools\_internal"
  
  ; �p�G�O��s�Ҧ��A��_ saves ��Ƨ�
  ${If} $IsUpdateMode == "1"
    ${AndIf} $SavesBackupPath != ""
      DetailPrint "Restoring user data..."
      CreateDirectory "$INSTDIR\_internal\modules\saves"
      CopyFiles /SILENT "$SavesBackupPath\*.*" "$INSTDIR\_internal\modules\saves"
      RMDir /r "$SavesBackupPath"
  ${EndIf}
  
  ; �u�b�����w�˩Τ�ʦw�ˮɫإ߱��|
  ${If} $IsUpdateMode != "1"
    ; �إ߶}�l�\����|
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\FlexiTools.exe"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\���� ${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
  ${EndIf}
SectionEnd

; �ୱ���|�Ϭq�]�i��^
Section "Desktop Shortcut" SEC02
  ; �u�b�D��s�Ҧ��ɫإ߮ୱ���|
  ${If} $IsUpdateMode != "1"
    CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\FlexiTools.exe"
  ${EndIf}
SectionEnd

; �ֳt�Ұʱ��|�Ϭq�]�i��^
Section "Quick Launch Shortcut" SEC03
  ; �u�b�D��s�Ҧ��ɫإߧֳt�Ұʱ��|
  ${If} $IsUpdateMode != "1"
    CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\FlexiTools.exe"
  ${EndIf}
SectionEnd

; �Ϭq�y�z
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "Install the main program files of ${PRODUCT_NAME}"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Create a ${PRODUCT_NAME} shortcut on the desktop"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "Create a ${PRODUCT_NAME} shortcut in the Quick Launch bar"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; �w�˫�B�z
Section -AdditionalIcons
  ; �u�b�D��s�Ҧ��ɫإߺ����s��
  ${If} $IsUpdateMode != "1"
    WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\�x�����.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  ${EndIf}
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\FlexiTools.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\FlexiTools.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; �����Ϭq
Section Uninstall
  ; �R���ɮשM�ؿ�
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\FlexiTools.exe"
  Delete "$INSTDIR\version.txt"
  
  ; �R�� _internal �ؿ�
  RMDir /r "$INSTDIR\_internal"
  
  ; �R���}�l�\�����
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\���� ${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\�x�����.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  RMDir "$SMPROGRAMS\${PRODUCT_NAME}"
  
  ; �R���ୱ���|
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  
  ; �R���ֳt�Ұʱ��|
  Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"
  
  ; �R�����U����
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  ; �R���w�˥ؿ��]�p�G���š^
  RMDir "$INSTDIR"
  
  SetAutoClose true
SectionEnd

; �w�˫e�ˬd
Function .onInit
  ; ��l���ܼ�
  StrCpy $IsUpdateMode "0"
  StrCpy $IsFirstInstall "1"
  StrCpy $SavesBackupPath ""
  
  ; �ˬd�R�O�C�ѼƬO�_�]�t /UPDATE
  ${GetOptions} $CMDLINE "/UPDATE" $R0
  IfErrors +3 0
    StrCpy $IsUpdateMode "1"
    SetSilent silent
  
  ; �ˬd�O�_�w�w��
  ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"
  StrCmp $R0 "" first_install
  
  ; �w�w�ˡA�]�w���D�����w��
  StrCpy $IsFirstInstall "0"
  
  ; �p�G�O��s�Ҧ��A�����~��w��
  ${If} $IsUpdateMode == "1"
    Goto done
  ${EndIf}
  
  ; ��ʦw�˼Ҧ��G�߰ݬO�_�����ª�
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "${PRODUCT_NAME} is already installed.$\n$\nClick OK to remove the previous version or Cancel to cancel this installation." \
  /SD IDOK IDOK uninst
  Abort
  
uninst:
  ClearErrors
  ExecWait '$R0 _?=$INSTDIR'
  
  IfErrors no_remove_uninstaller done
    no_remove_uninstaller:
    
  Goto done
  
first_install:
  ; �����w��
  StrCpy $IsFirstInstall "1"
  
done:
FunctionEnd

; �����e�T�{
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove ${PRODUCT_NAME} and all of its components?" /SD IDYES IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME} has been successfully removed from your computer." /SD IDOK
FunctionEnd