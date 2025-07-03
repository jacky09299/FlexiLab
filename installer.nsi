; �p�u��� NSIS �w�˸}��
; �s�X: UTF-8

; �򥻳]�w
!define PRODUCT_NAME "�p�u���"
!define PRODUCT_VERSION "1.0.0"
!define PRODUCT_PUBLISHER "���T�t"
!define PRODUCT_WEB_SITE "https://your-website.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\�p�u���.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; �]�t�{�N UI
!include "MUI2.nsh"

; �]�w�w���ɮ��ݩ�
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "ToolsInstaller.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

; �n�D�޲z���v��
RequestExecutionLevel admin

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
!define MUI_FINISHPAGE_RUN "$INSTDIR\�p�u���.exe"
!insertmacro MUI_PAGE_FINISH

; ��������
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; �y���]�w
!insertmacro MUI_LANGUAGE "TradChinese"

; ������T
VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "Comments" "�p�u��զw�˵{��"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalTrademarks" ""
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "LegalCopyright" "c ${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileDescription" "${PRODUCT_NAME} �w�˵{��"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_TRADCHINESE} "ProductVersion" "${PRODUCT_VERSION}"

; �D�n�w�˰Ϭq
Section "�D�{��" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  ; �ƻs�D�{���ɮ�
  File "dist\Tools\Tools.exe"
  
  ; �ƻs _internal �ؿ��Ψ�Ҧ����e
  File /r "dist\Tools\_internal"
  
  ; �إ߶}�l�\����|
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\�p�u���.exe"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\���� ${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
SectionEnd

; �ୱ���|�Ϭq�]�i��^
Section "�ୱ���|" SEC02
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\�p�u���.exe"
SectionEnd

; �ֳt�Ұʱ��|�Ϭq�]�i��^
Section "�ֳt�Ұʱ��|" SEC03
  CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\�p�u���.exe"
SectionEnd

; �Ϭq�y�z
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "�w�� ${PRODUCT_NAME} �D�{���ɮ�"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "�b�ୱ�إ� ${PRODUCT_NAME} ���|"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "�b�ֳt�ҰʦC�إ� ${PRODUCT_NAME} ���|"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; �w�˫�B�z
Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\�x�����.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\�p�u���.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\�p�u���.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd



; �����Ϭq
Section Uninstall
  ; �R���ɮשM�ؿ�
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\�p�u���.exe"
  
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
  ; �ˬd�O�_�w�w��
  ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"
  StrCmp $R0 "" done
  
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "${PRODUCT_NAME} �w�g�w�ˡC$\n$\n�I���u�T�w�v�������e�����A���I���u�����v�����w�ˡC" \
  /SD IDOK IDOK uninst
  Abort
  
uninst:
  ClearErrors
  ExecWait '$R0 _?=$INSTDIR'
  
  IfErrors no_remove_uninstaller done
    no_remove_uninstaller:
    
done:
FunctionEnd

; �����e�T�{
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "�z�T�w�n�������� ${PRODUCT_NAME} �Ψ�Ҧ�����ܡH" /SD IDYES IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME} �w���\�q�z���q�������C" /SD IDOK
FunctionEnd