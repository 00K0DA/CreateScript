'**************************************************************************************
'* �v���O������ �F �f�X�N�g�b�v�̕ǎ��ύX�X�N���v�g                                   *
'* �����T�v     �F ���W�X�g�����g�p���f�X�N�g�b�v�̕ǎ���������������B             *
'*                 ����������A�f�X�N�g�b�v�̕ǎ��̏������b�Z�[�W�{�b�N�X�ɂĕ\���A *
'*                 �ǎ��̃p�X���N���b�v�{�[�h�ɕۑ����܂��B                           *
'* ����         �F                                                                    *
'**************************************************************************************

Option Explicit

'--------------------------------------
' �萔
'--------------------------------------
'�ύX����ǎ��̃p�X�ݒ�
Dim cWallPaperPath : cWallPaperPath = "�ݒ肵�����ǎ��̃t���p�X"

'���W�X�g���𑀍삷�邽�߂�WMI���\�b�h���Ăяo�����߂Ɏg�p���郋�[�g�L�[
Dim cHKEY_CURRENT_USER : cHKEY_CURRENT_USER = &H80000001

'���W�X�g���ɍ쐬����L�[���
Dim cCreateRegistryKey : cCreateRegistryKey = "Control Panel\Desktop"

'���W�X�g���ɒl���Z�b�g���閼�O
Dim cSetRegistryValueName : cSetRegistryValueName = "Wallpaper"

'���W�X�g���̓��e����ʂɑ������f�����邽�߂̏��������s�����
Dim cRunRegistryReflectCount : cRunRegistryReflectCount = 10

'���W�X�g���̓��e����ʂɑ������f�����邽�߂̖���
Dim cRegistryReflectOrder : cRegistryReflectOrder    = "RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters "

'--------------------------------------
' �ϐ��錾�E�C���X�^���X�쐬
'--------------------------------------
Dim objShell   : Set objShell   = WScript.CreateObject("WScript.Shell")   'WScript.Shell�I�u�W�F�N�g

'���C�����������s
Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '--------------------------------------
    ' �R���s���[�^�����擾
    '--------------------------------------
    '�R���s���[�^��񂩂�R���s���[�^�����擾
    Dim mComputerInfo : Set mComputerInfo = GetComputerInfo()
    Dim mComputerName : mComputerName     = mComputerInfo.Name

    '--------------------------------------
    ' ���W�X�g���ɕǎ��̏����Z�b�g
    '--------------------------------------
    '���W�X�g�����擾
    Dim mObjRegistry  : Set mObjRegistry = GetObject("winmgmts:\\" & mComputerName & "\root\default:StdRegProv")
    
    '�ǎ����Z�b�g����p�̃��W�X�g�����쐬����
    mObjRegistry.CreateKey cHKEY_CURRENT_USER, cCreateRegistryKey

    '���W�X�g���Ƀf�X�N�g�b�v�̕ǎ����Z�b�g����
    mObjRegistry.SetStringValue cHKEY_CURRENT_USER, cCreateRegistryKey, cSetRegistryValueName, cWallPaperPath
    
    Set mObjRegistry = Nothing

    '--------------------------------------
    ' ���W�X�g���̓��e����ʂɔ��f������
    '--------------------------------------
    '��������s���Ȃ��Ɣ��f����Ȃ����߉�������s����
    Dim i
    For i = 1 To cRunRegistryReflectCount

        objShell.Run cRegistryReflectOrder, 1, true
         WScript.Sleep(1000)                         '�P�b�҂�

    Next

    '--------------------------------------
    ' ���[�U�[�����擾
    '--------------------------------------
    'WScript.Network�I�u�W�F�N�g���쐬
    Dim mObjNetWork : Set mObjNetWork = WScript.CreateObject("WScript.Network")
    
    '���O�C�����[�U�[�����쐬�i�R���s���[�^�� �{ \ �{ ���[�U�[���j
    Dim mLoginUserName : mLoginUserName = mComputerName & "\" & mObjNetWork.UserName
    
    Set mObjNetWork= Nothing
    
    '--------------------------------------
    ' �ǎ��̏�����ʂɕ\��
    '--------------------------------------
    '���[�J���R���s���[�^�ɐڑ� 
    '���l�b�g���[�N�̃p�\�R���ɃA�N�Z�X���鎞�̓��[�U�[���ƃp�X���[�h���Z�b�g���邱��
    '  �T���v���R�[�h�Fhttp://www.wmifun.net/step/vb6_06.html
    Dim mLocator : Set mLocator = WScript.CreateObject("WbemScripting.SWbemLocator")
    Dim mService : Set mService = mLocator.ConnectServer
    
    '�f�X�N�g�b�v�����擾
    Dim mDesktopInfos : Set mDesktopInfos = mService.ExecQuery("Select * From Win32_Desktop")

    '���[�U�[���ƌJ��Ԃ����
    Dim mDesktopInfo, mWallPaperPath
    For Each mDesktopInfo In mDesktopInfos

        '���[�U�[�������O�C�����Ă��郆�[�U�[���ƈ�v������
        If mLoginUserName = mDesktopInfo.Name Then

            '�ǎ��̃p�X���擾
            mWallPaperPath = mDesktopInfo.Wallpaper
            Exit For
        
        End If
    
    Next

    '--------------------------------------
    ' �ǎ��̃p�X���N���b�v�{�[�h�ɃR�s�[
    '--------------------------------------
    Dim mClipBoardCopyText : mClipBoardCopyText = "cmd.exe /c ""echo " & mWallPaperPath & "| clip"""
    objShell.Run mClipBoardCopyText, 0

    '�ǎ��̏���\��
    MsgBox "�ݒ肳��Ă���ǎ��̃p�X�͈ȉ��̒ʂ�ł�" & _
           vbCrLf & _
           vbCrLf & _
           mWallPaperPath & _
           vbCrLf & _
           vbCrLf & _
           "���ǎ��̃p�X�̓N���b�v�{�[�h�ɃR�s�[����܂���"

    '--------------------------------------
    ' �I�u�W�F�N�g�̔j������
    '--------------------------------------
    Set objShell = Nothing    

End Sub

'***********************************************************************
'* ������   �F �R���s���[�^�̏����擾                                *
'* ����     �F �Ȃ�                                                    *
'* �������e �F WMI���g�p���R���s���[�^�̏����擾����                 *
'*               Domain             �F�h���C��(���[�N�O���[�v)         *
'*               Manufacturer       �F���[�J�[                         *
'*               Model              �F�^��                             *
'*               Name               �F�R���s���[�^��                   *
'*               PrimaryOwnerName   �F���L��(�����Z�b�g�A�b�v���ɍ쐬  *
'*                                    �����A�J�E���g��)                *
'*               TotalPhysicalMemory�F��������                         *
'* �߂�l   �F �R���s���[�^����ێ�����Object                        *
'***********************************************************************
Function GetComputerInfo()

   'WMI����R���s���[�^�̏����擾����
    Dim mObjWMIService : Set mObjWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\." & "\root\cimv2")
    Dim mSystemInfos   : Set mSystemInfos  = mObjWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
    
    '�R���s���[�^�̏����Z�b�g
    Dim mSystemInfo
    For Each mSystemInfo In mSystemInfos
    
        Set GetComputerInfo = mSystemInfo
        
    Next

End Function
