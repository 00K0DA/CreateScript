'**************************************************************************************
'* �v���O������ �F �X�^�[�g�A�b�v�����X�N���v�g                                       *
'* �����T�v     �F �X�^�[�g�A�b�v���Ɏ��s����X�N���v�g�B���s���ꂽ�h���C�u����Orchis *
'*                 �Ŏg�p����V���[�g�J�b�g�t�@�C���̃����N����쐬�������BRSS�����  *
'*                  �_�ǂ݂����̃p�X�ݒ�����s���ꂽ�h���C�u�p�ɏ���������B�X�^�[  *
'*                 �g�A�b�v���Ɏ��s����ė~�����v���O�������ꊇ�Ŏ��s����             *
'* ����         �F ���̃t�@�C�����V���[�g�J�b�g�ɂ��ăR�}���h���C���������w�肷�邱�� *
'*                 ���g�p�ၚ                                                         *
'*                   C:\Tools\CreateScript\RunStartUp\RunStartUp.vbs "Company"        *
'*                   C:\Tools\CreateScript\RunStartUp\RunStartUp.vbs "House"          *
'*                   C:\Tools\CreateScript\RunStartUp\RunStartUp.vbs "NotePC"         *
'*                 �����s������ɂ��R�}���h���C��������ύX���鎖                 *
'*                 URL�t�@�C���̍쐬���@                                              *
'*                   �t�@�C�������u������.url�v�`���ɂ��V���[�g�J�b�g���URL���w��    *
'* �ݒ�         �F ���̃X�N���v�g�̃f�t�H���g�ݒ��USB�Ŏ��s����܂�                  *
'**************************************************************************************

'--------------------------------------
' �ݒ�
'--------------------------------------
'�����s�敪�uCompany�F��ЁAHouse�F�ƁAUSB�FUSB�ANotePC�F�m�[�g�p�\�R���v
'  �f�t�H���g��USB�ł�
Dim runKbn : runKbn = "USB"

'�R�}���h���C���������擾�����s�敪�ɃZ�b�g����
'���R�}���h���C���������擾�o�����Ƃ������Z�b�g����
If WScript.Arguments.Count > 0 Then

    runKbn = WScript.Arguments(0)

End If

'--------------------------------------
' �ϐ��錾�E�C���X�^���X�쐬
'--------------------------------------
Dim objShell   : Set objShell   = WScript.CreateObject("WScript.Shell")              'WScript.Shell�I�u�W�F�N�g
Dim objAppli   : Set objAppli   = WScript.CreateObject("Shell.Application")          'WScript.Application�I�u�W�F�N�g
Dim objFso     : set objFso     = WScript.CreateObject("Scripting.FileSystemObject") 'FileSystemObject
Dim fileInfo   : Set fileInfo   = WScript.CreateObject("Scripting.Dictionary")       '�t�@�C�����i�[Dictionary
Dim runFile    : Set runFile    = WScript.CreateObject("Scripting.Dictionary")       '���sEXE�i�[Dictionary
Dim orchisDirectory                                                                  'Orchis���s�f�B���N�g��

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '--------------------------------------
    ' �������s�����[�U�[�ɑΘb
    '--------------------------------------
    '���b�Z�[�W�{�b�N�X�̕\��
    Dim msgResult : msgResult = MsgBox("�X�^�[�g�A�b�v���������s���܂��B" & vbCrLf & "��낵���ł����H", vbOKCancel, "�X�^�[�g�A�b�v����")

    '�L�����Z���������ꂽ���͏������I��
    If msgResult = vbCancel Then Wscript.Quit()

    '--------------------------------------
    ' ���s�h���C�u���擾
    '--------------------------------------
    Dim runDrive : runDrive = objFSo.GetDriveName(WScript.ScriptFullName)

    '--------------------------------------
    ' RSS����̖_�ǂ݂����̃p�X�ݒ�ύX
    '--------------------------------------
    Dim bouyomiC           : bouyomiC           = "C:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiD           : bouyomiD           = "D:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiE           : bouyomiE           = "E:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiF           : bouyomiF           = "F:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiG           : bouyomiG           = "G:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiH           : bouyomiH           = "H:\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim bouyomiAfterPath   : bouyomiAfterPath   = runDrive & "\Tools\BouyomiChan\RemoteTalk\RemoteTalk.exe"
    Dim rssNewsSettingPath : rssNewsSettingPath = runDrive & "\Tools\RssNews\setting.xml"

    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiC,bouyomiAfterPath,"UTF-8")
    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiD,bouyomiAfterPath,"UTF-8")
    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiE,bouyomiAfterPath,"UTF-8")
    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiF,bouyomiAfterPath,"UTF-8")
    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiG,bouyomiAfterPath,"UTF-8")
    Call ReplaceTextDetail(rssNewsSettingPath,bouyomiH,bouyomiAfterPath,"UTF-8")

    '--------------------------------------
    ' �t�@�C���̎��s����
    '--------------------------------------
    '���s�Ώۃt�@�C����ǉ�
    Call AddRunFile(runFile,runDrive,orchisDirectory)

    '�t�@�C���̈ꊇ���s����
    For Each key In runFile.Keys

        'EXE�̎��s����
        objShell.Run runFile(key)

        'MouseGestureL�̎��͋N����P�O�b�ԑ҂�(���S�ɋN������܂ő҂�)
        '��MouseGestureL��AutoHotKeyTool�̑����̖��AMouseGestureL�̋N����ɗ���
        '  �グ�Ȃ���AutoHotKeyTool�Őݒ肵���V���[�g�J�b�g�������Ȃ��Ȃ邽��
        If(key = "MouseGestureL") Then WScript.Sleep(10000)

    Next

    '--------------------------------------
    ' �V���[�g�J�b�g�ꊇ�쐬
    '--------------------------------------
    '�V���[�g�J�b�g���쐬����t�@�C������ǉ�
    Call AddShortCutFile(fileInfo,runDrive,orchisDirectory)

    '�V���[�g�J�b�g�쐬����
    For Each key In fileInfo.Keys

        '�쐬����؂蕪����i�@�V���[�g�J�b�g�p�X�A�A�o�̓t�H���_�A�B�R�}���h���C�������A�C�A�C�R�����j
        Dim aryFileInfo : aryFileInfo = Split(fileInfo(key),"|")

        'lnk�t�@�C���̃t�@�C��������V���[�g�J�b�g���쐬����f�B���N�g�����擾
        Dim fileName : fileName = key
        Dim path : path = aryFileInfo(1) & fileName

        '�V���[�g�J�b�g�쐬���̃t�H���_�����������ꍇ�̓t�H���_���쐬����
        '��Bookmark�t�H���_�쐬�p�ɋL�q
        CreateNotExistFolder(aryFileInfo(0))

        '�쐬��f�B���N�g���̃t�H���_�����������ꍇ�̓t�H���_���쐬����
        CreateNotExistFolder(path)

        '�V���[�g�J�b�g�I�u�W�F�N�g���쐬���o�͐�p�X�A�R�}���h���C�������A�A�C�R�����w��
        Set shortCut = objShell.CreateShortcut(path)                               '�V���[�g�J�b�g�I�u�W�F�N�g���쐬
        shortCut.TargetPath = aryFileInfo(0)                                       '�V���[�g�J�b�g��
        If UBound(aryFileInfo) > 1 Then shortCut.Arguments        = aryFileInfo(2) '�R�}���h���C�������ݒ�
        If UBound(aryFileInfo) > 2 Then shortCut.IconLocation     = aryFileInfo(3) '�A�C�R������ݒ�
        If UBound(aryFileInfo) > 3 Then shortCut.WorkingDirectory = aryFileInfo(4) '��ƃt�H���_��ݒ�

        '�V���[�g�J�b�g���쐬
        shortCut.Save

    Next

    '--------------------------------------
    ' �I�u�W�F�N�g�j������
    '--------------------------------------
    Set objShell   = Nothing
    Set objAppli   = Nothing
    Set objFso     = Nothing
    Set fileInfo   = Nothing
    Set runFile    = Nothing

End Sub

'***********************************************************************
'* ������   �F �e�L�X�g�t�@�C�����̕�����ϊ�                          *
'* ����     �F pTextFilePath �Ώۃe�L�X�g�t�@�C���̃t���p�X            *
'*             pBeforeText   �ϊ���������                              *
'*             pAfterText    �ϊ��㕶����                              *
'*             pStringCode   �����R�[�h                                *
'* �������e �F �w�肵�������R�[�h�̃t�@�C�����J���A��������̕ϊ����s  *
'*             ��                                                      *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub ReplaceTextDetail(ByVal pTextFilePath,ByVal pBeforeText,ByVal pAfterText,ByVal pStringCode)

    '--------------------------------------
    ' �ϐ��錾�E�C���X�^���X�쐬
    '--------------------------------------
    Dim objFso    : Set objFso    = WScript.CreateObject("Scripting.FileSystemObject") 'FileSystemObject
    Dim objStream : Set objStream = CreateObject("ADODB.Stream")                       'Stream�I�u�W�F�N�g�i�f�[�^�̃o�C�i���܂��̓e�L�X�g�X�g���[����\���܂��j

    '--------------------------------------
    ' �e�L�X�g�t�@�C�����J��
    '--------------------------------------
    '�I�[�v������t�@�C���̏����Z�b�g����
    objStream.type = 2              '�e�L�X�g�f�[�^
    objStream.Charset = pStringCode '�����R�[�h

    'Straam�I�u�W�F�N�g���J��
    objStream.Open

    '�w�肳�ꂽ�t�@�C�����J�� -1:�e�L�X�g���e�̂��ׂĂ�ǂݍ���
    objStream.LoadFromFile pTextFilePath
    Dim readFileDetail : readFileDetail = objStream.ReadText(-1)

    '--------------------------------------
    ' �t�@�C�����e�̒u������
    '--------------------------------------
    readFileDetail = replace(readFileDetail,pBeforeText,pAfterText)

    '--------------------------------------
    ' �u�����e�̏������ݏ���
    '--------------------------------------
    '�������݈ʒu���g�b�v�ɂ��������݂��s��
    objStream.Position = 0
    objStream.WriteText readFileDetail , 0

    '�t�@�C���̏㏑������
    objStream.SaveToFile pTextFilePath, 2

    'Stream�I�u�W�F�N�g�����
    objStream.Close

    '--------------------------------------
    ' �I�u�W�F�N�g�j������
    '--------------------------------------
    Set objFso    = Nothing
    Set objStream = Nothing

End Sub

'***********************************************************************
'* ������   �F ���s�Ώۃt�@�C���̒ǉ�����                              *
'* ����     �F pRunFile         ���s�Ώۃt�@�C���i�[Dictionary         *
'*             pRunDrive        ���s�h���C�u�p�X                       *
'*             pOrchisDirectory Orchis�̎��s�h���C�u�i�[�ϐ�           *
'* �������e �F ���s�Ώۂ̃t�@�C������Dictionary�ɒǉ�����            *
'*             �ꕔ�̃v���O�����̓��[�U�[�ɑΘb���Ēǉ����邩�₤      *
'* �߂�l   �F pRunFile                                                *
'*             pOrchisDirectory                                        *
'***********************************************************************
Function AddRunFile(ByRef pRunFile,ByVal pRunDrive,ByRef pOrchisDirectory)

    '--------------------------------------
    ' �t�@�C������ݒ肵�Ă���
    ' ���L�[�F�t�@�C�����A���ځF�t�@�C���p�X
    '--------------------------------------
    '�t�@�C���[�N���� �������������ꂽ����X-Finder���N�����Ȃ�(�N���t�@�C���i�[Dictionary�ɒǉ����Ȃ�)
    Dim msgRunFilerResult : msgRunFilerResult = MsgBox("�t�@�C���[���N�����܂����H", vbYesNo, "�t�@�C���[�N����")
    If msgRunFilerResult = vbYes Then

        pRunFile.Add "X-Finder"           , pRunDrive & "\Tools\X-Finder\xf64.exe"

    End If

    '�}�E�X���݉� �������������ꂽ����MouseGestureL���N�����Ȃ�(�N���t�@�C���i�[Dictionary�ɒǉ����Ȃ�)
    Dim msgMouseExistResult : msgMouseExistResult = MsgBox("���g���̃p�\�R���Ƀ}�E�X�͂���܂����H", vbYesNo, "�}�E�X���݉�")
    If msgMouseExistResult = vbYes Then

        pRunFile.Add "WheelAccele"        , pRunDrive & "\Tools\AutoHotKey\Tools\WheelAccele\WheelAccele.exe"
        pRunFile.Add "MouseGestureL"      , pRunDrive & "\Tools\MouseGestureL\MouseGestureL.exe"

    End If

    '�l�b�g���[�N���g���邩�ǂ���
    Dim msgIsUseNetworkResult : msgIsUseNetworkResult = MsgBox("�l�b�g���[�N���g������ł����H", vbYesNo, "�l�b�g���[�N���p�\��")
    If msgIsUseNetworkResult = vbYes Then

        '----------------------------
        ' �l�b�g���[�N���g�p�̎�
        '----------------------------
        '�u���E�U�[�N���� �������������ꂽ����Google Chrome���N�����Ȃ�(�N���t�@�C���i�[Dictionary�ɒǉ����Ȃ�)
        Dim msgRunBrowserResult : msgRunBrowserResult = MsgBox("�u���E�U�[���N�����܂����H", vbYesNo, "�u���E�U�[�N����")
        If msgRunBrowserResult = vbYes Then

            Select Case runKbn

                Case "Company", "House", "NotePC"

                    pRunFile.Add "GoogleChrome"       , """" & pRunDrive & "\Program Files (x86)\Google\Chrome\Application\chrome.exe"""

                Case "USB"

                    pRunFile.Add "GoogleChrome"       , pRunDrive & "\Tools\GoogleChromePortable\GoogleChromePortable.exe"

            End Select

        End If

        '���[���[�N���� �������������ꂽ����ThunderBird���N�����Ȃ�(�N���t�@�C���i�[Dictionary�ɒǉ����Ȃ�)
        Dim msgRunMailerResult : msgRunMailerResult = MsgBox("���[���[���N�����܂����H", vbYesNo, "���[���[�N����")
        If msgRunMailerResult = vbYes Then

            Select Case runKbn

                Case "Company"

                    pRunFile.Add "ThunderBird"        , """" & pRunDrive & "\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"""

                Case "House", "USB", "NotePC"

                    pRunFile.Add "ThunderBird"        , pRunDrive & "\Tools\ThunderbirdPortable\ThunderbirdPortable.exe"

            End Select

        End If

        Select Case runKbn

            Case "House"

                '�_�ǂ݂����N���� �������������ꂽ���͖_�ǂ݂������N�����Ȃ�(�N���t�@�C���i�[Dictionary�ɒǉ����Ȃ�)
                Dim msgRunBouyoumiChanResult : msgRunBouyoumiChanResult = MsgBox("�_�ǂ݂������N�����܂����H", vbYesNo, "�_�ǂ݂����N����")
                If msgRunBouyoumiChanResult = vbYes Then

                      pRunFile.Add "BouyomiChan"       , pRunDrive & "\Tools\BouyomiChan\BouyomiChan.exe"

                End If
                
                pRunFile.Add "befoo"              , pRunDrive & "\Tools\befoo\befooPtan.exe"
                pRunFile.Add "RssNews"            , pRunDrive & "\Tools\RssNews\RssNews.exe"
                
            Case "Company"

                pRunFile.Add "befoo"              , pRunDrive & "\Tools\befoo\befooPtan.exe"
                pRunFile.Add "RssNews"            , pRunDrive & "\Tools\RssNews\RssNews.exe"

        End Select

    End If

    pRunFile.Add "Clibor"             , pRunDrive & "\Tools\clibor\Clibor.exe"
    pRunFile.Add "AutoHotKeyTool"     , pRunDrive & "\Tools\AutoHotKey\AutoHotKeyTool.exe"
    pRunFile.Add "AkabeiMonitor"      , pRunDrive & "\Tools\AkabeiMonitor\akamoni.exe"
    pRunFile.Add "Freeraser"          , pRunDrive & "\Tools\Freeraser\Freeraser.exe"
    pRunFile.Add "7+ Taskbar Tweaker" , """" & pRunDrive & "\Tools\7+ Taskbar Tweaker\7+ Taskbar Tweaker.exe"""

    Select Case runKbn
    
        Case "Company"

            pRunFile.Add "BijinTokeiGadget"   , pRunDrive & "\Tools\BijinTokeiGadget\BijinTokeiGadget.exe"
            pRunFile.Add "BijoLinuxGadget"    , pRunDrive & "\Tools\BijoLinuxGadget\BijoLinuxGadget.exe"
            pRunFile.Add "Evernote"           , pRunDrive & "\Tools\EvernotePortable\EvernotePortable.exe"
            pRunFile.Add "Stickies"           , pRunDrive & "\Tools\StickiesPortable\StickiesPortable.exe"
            pRunFile.Add "TVClock"            , pRunDrive & "\Tools\tvclock\TVClock.exe"
            pRunFile.Add "RocketDock"         , pRunDrive & "\Tools\RocketDock\RocketDock.exe"
            pRunFile.Add "Chronus"            , pRunDrive & "\Tools\Chronus\"
            pRunFile.Add "Slack"              , """" & "%UserProfile%\AppData\Local\slack\slack.exe"""
            pRunFile.Add "SuperF4"            , pRunDrive & "\Tools\SuperF4\SuperF4.exe"
            pRunFile.Add "GoogleDrive"        , """" & pRunDrive & "\Program Files\Google\Drive\googledrivesync.exe"""
            pRunFile.Add "����\��"           , pRunDrive & "\Tools\Weather\Weather64.exe"

        Case "House"

            pRunFile.Add "BijinTokeiGadget"   , pRunDrive & "\Tools\BijinTokeiGadget\BijinTokeiGadget.exe"
            pRunFile.Add "BijoLinuxGadget"    , pRunDrive & "\Tools\BijoLinuxGadget\BijoLinuxGadget.exe"
            pRunFile.Add "Evernote"           , pRunDrive & "\Tools\EvernotePortable\EvernotePortable.exe"
            pRunFile.Add "Stickies"           , pRunDrive & "\Tools\StickiesPortable\StickiesPortable.exe"
            pRunFile.Add "TVClock"            , pRunDrive & "\Tools\tvclock\TVClock.exe"
            pRunFile.Add "RocketDock"         , pRunDrive & "\Tools\RocketDock\RocketDock.exe"
            pRunFile.Add "Chronus"            , pRunDrive & "\Tools\Chronus\"
            pRunFile.Add "Slack"              , """" & "%UserProfile%\AppData\Local\slack\slack.exe"""
            pRunFile.Add "SuperF4"            , pRunDrive & "\Tools\SuperF4\SuperF4.exe"
            pRunFile.Add "GoogleDrive"        , """" & pRunDrive & "\Program Files\Google\Drive\googledrivesync.exe"""
            pRunFile.Add "����\��"           , pRunDrive & "\Tools\Weather\Weather64.exe"

            
        Case "NotePC"

            pRunFile.Add "TVClock"            , pRunDrive & "\Tools\tvclock\TVClock.exe"

    End Select

    '���s�h���C�u��������擾
    Dim driveStr : driveStr = Left(pRunDrive, 1)

    '�h���C�u���ƋN������Orchis��ύX����
    Select Case driveStr

        Case "C"

            Select Case runKbn

                Case "Company", "House", "NotePC"

                    pOrchisDirectory = """" & pRunDrive & "\Program Files\Orchis\orchis.exe""" '�C���X�g�[����

                Case "USB"

                    orchisDirectory = pRunDrive & "\Tools\orchisC\orchis-p.exe"               '�|�[�^�u����

            End Select

        Case "D"

             pOrchisDirectory = pRunDrive & "\Tools\orchisD\orchis-p.exe"

        Case "E"

            pOrchisDirectory = pRunDrive & "\Tools\orchisE\orchis-p.exe"

        Case "F"

            pOrchisDirectory = pRunDrive & "\Tools\orchisF\orchis-p.exe"

        Case "G"

            pOrchisDirectory = pRunDrive & "\Tools\orchisG\orchis-p.exe"

        Case "H"

            pOrchisDirectory = pRunDrive & "\Tools\orchisH\orchis-p.exe"

        Case Else

    End Select
    pRunFile.Add "Orchis"             , pOrchisDirectory

End Function

'***********************************************************************
'* ������   �F �V���[�g�J�b�g�쐬�t�@�C���̒ǉ�����                    *
'* ����     �F pFileInfo        �V���[�g�J�b�g�쐬���i�[Dictionary   *
'*             pRunDrive        ���s�h���C�u�p�X                       *
'*             pOrchisDirectory Orchis�̎��s�h���C�u�i�[�ϐ�           *
'* �������e �F �V���[�g�J�b�g���쐬����t�@�C������Dictionary�Ɋi�[  *
'*             ����                                                    *
'* �߂�l   �F pFileInfo                                               *
'***********************************************************************
Function AddShortCutFile(ByRef pFileInfo,ByVal pRunDrive,ByVal pOrchisDirectory)

    '-----------------------------------------------------
    ' �V���[�g�J�b�g���쐬����t�@�C�������Z�b�g���Ă���
    ' ���L�[�F�t�@�C�����A�쐬���F�t�@�C���p�X|�o�͐�t�H���_|�R�}���h���C������|�A�C�R�����
    '   �����`���[�p�Ɏ��s���ꂽ�h���C�u�ŃV���[�g�J�b�g�̃p�X�����Ȃ���
    '-----------------------------------------------------
    '�t�@�C����                                                '�V���[�g�J�b�g��                                                                            '�t�@�C���̏o�͐�                                                  '�R�}���h���C������                                 '�A�C�R���t�@�C��                                                        '��ƃt�H���_                              

    '��StartUp��
    pFileInfo.Add "7+ Taskbar Tweaker.lnk"                    , """" & pRunDrive & "\Tools\7+ Taskbar Tweaker\7+ Taskbar Tweaker.exe"""               & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "AkabeiMonitor.lnk"                         , pRunDrive & "\Tools\AkabeiMonitor\akamoni.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "AutoHotKeyTool.lnk"                        , pRunDrive & "\Tools\AutoHotKey\AutoHotKeyTool.exe"                                    & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "befoo.lnk"                                 , pRunDrive & "\Tools\befoo\befooPtan.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "BijinTokeiGadget.lnk"                      , pRunDrive & "\Tools\BijinTokeiGadget\BijinTokeiGadget.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "BijoLinuxGadget.lnk"                       , pRunDrive & "\Tools\BijoLinuxGadget\BijoLinuxGadget.exe"                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "Clibor.lnk"                                , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "Evernote.lnk"                              , pRunDrive & "\Tools\EvernotePortable\EvernotePortable.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "Freeraser.lnk"                             , pRunDrive & "\Tools\Freeraser\Freeraser.exe"                                          & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "MouseGestureL.lnk"                         , pRunDrive & "\Tools\MouseGestureL\MouseGestureL.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "Orchis.lnk"                                , pOrchisDirectory                                                                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"                            & "|" & ""                                 & "|" & pRunDrive & "\Program Files\Orchis\orchis.exe"
    pFileInfo.Add "RSS����.lnk"                               , pRunDrive & "\Tools\RssNews\RssNews.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "Stickies.lnk"                              , pRunDrive & "\Tools\StickiesPortable\StickiesPortable.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "SuperF4.lnk"                               , pRunDrive & "\Tools\SuperF4\SuperF4.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "WheelAccele.lnk"                           , pRunDrive & "\Tools\AutoHotKey\Tools\WheelAccele\WheelAccele.exe"                     & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
    pFileInfo.Add "����\��.lnk"                              , pRunDrive & "\Tools\Weather\Weather64.exe"                                            & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"

    Select Case runKbn

        Case "Company"

            pFileInfo.Add "BijinTokeiGadget_Other.lnk"                , pRunDrive & "\Tools\BijinTokeiGadget_Other\BijinTokeiGadget.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "Chronus.lnk"                               , pRunDrive & "\Tools\Chronus\"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "GoogleDrive.lnk"                           , """" & pRunDrive & "\Program Files\Google\Drive\googledrivesync.exe"""                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "RocketDock.lnk"                            , pRunDrive & "\Tools\RocketDock\RocketDock.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "Slack.lnk"                                 , """" & "%UserProfile%\AppData\Local\slack\slack.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "TVClock.lnk"                               , pRunDrive & "\Tools\tvclock\TVClock.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"

        Case "House"

            pFileInfo.Add "BijinTokeiGadget_Other.lnk"                , pRunDrive & "\Tools\BijinTokeiGadget_Other\BijinTokeiGadget.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "Chronus.lnk"                               , pRunDrive & "\Tools\Chronus\"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "GoogleDrive.lnk"                           , """" & pRunDrive & "\Program Files\Google\Drive\googledrivesync.exe"""                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "RocketDock.lnk"                            , pRunDrive & "\Tools\RocketDock\RocketDock.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "Slack.lnk"                                 , """" & "%UserProfile%\AppData\Local\slack\slack.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "TVClock.lnk"                               , pRunDrive & "\Tools\tvclock\TVClock.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "�_�ǂ݂����.lnk"                          , pRunDrive & "\Tools\BouyomiChan\BouyomiChan.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"

        Case "NotePC"

            pFileInfo.Add "Chronus.lnk"                               , pRunDrive & "\Tools\Chronus\"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "GoogleDrive.lnk"                           , """" & pRunDrive & "\Program Files\Google\Drive\googledrivesync.exe"""                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "RocketDock.lnk"                            , pRunDrive & "\Tools\RocketDock\RocketDock.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "Slack.lnk"                                 , """" & "%UserProfile%\AppData\Local\slack\slack.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "TVClock.lnk"                               , pRunDrive & "\Tools\tvclock\TVClock.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"
            pFileInfo.Add "�_�ǂ݂����.lnk"                          , pRunDrive & "\Tools\BouyomiChan\BouyomiChan.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"

        Case "USB"

            pFileInfo.Add "�_�ǂ݂����.lnk"                          , pRunDrive & "\Tools\BouyomiChan\BouyomiChan.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\StartUp\"

    End Select

    '��OftenUse��
    pFileInfo.Add "Atom.lnk"                                  , pRunDrive & "\Tools\Atom\atom.exe"                                                    & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "EmEditorPortable.lnk"                      , pRunDrive & "\Tools\EmEditor\EmEditor.exe"                                            & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "FolderFileList.lnk"                        , pRunDrive & "\Tools\FolderFileList\FolderFileList.exe"                                & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "FolderFileListDebug.lnk"                   , pRunDrive & "\Tools\FolderFileList\FolderFileList_Debug.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "00_ImageForClipboard.lnk"                  , pRunDrive & "\Tools\ImageForClipboard\ImageForClipboard.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\ImageForClipboard\"
    pFileInfo.Add "01_�w���v.lnk"                             , pRunDrive & "\Tools\ImageForClipboard\ImageForClipboard.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\ImageForClipboard\"         & "|" & "/?"
    pFileInfo.Add "02_�N���b�v�{�[�h���̉摜��\��.lnk"       , pRunDrive & "\Tools\ImageForClipboard\ImageForClipboard.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\ImageForClipboard\"         & "|" & "/AutoClose 5 /ImageSize 40"
    pFileInfo.Add "03_�N���b�v�{�[�h���̉摜��ۑ�.lnk"       , pRunDrive & "\Tools\ImageForClipboard\ImageForClipboard.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\ImageForClipboard\"         & "|" & "/AutoClose 2 /ImageSize 40 /AutoSave %UserProfile%\Downloads\ /Extension png"
    pFileInfo.Add "ReduceMemory.lnk"                          , pRunDrive & "\Tools\ReduceMemory\ReduceMemory.exe"                                    & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "Skype.lnk"                                 , pRunDrive & "\Tools\SkypePortable\SkypePortable.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "Skype�I��.lnk"                             , pRunDrive & "\Tools\SkypePortable\SkypePortable.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"                           & "|" & "/shutdown"
    pFileInfo.Add "TeamViewer.lnk"                            , pRunDrive & "\Tools\TeamViewerPortable\TeamViewerPortable.exe"                        & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "Visual Studio Code.lnk"                    , pRunDrive & "\Tools\VSCode\Code.exe"                                                  & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
    pFileInfo.Add "X-Finder.lnk"                              , pRunDrive & "\Tools\X-Finder\xf64.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"

    Select Case runKbn

        Case "Company"

            pFileInfo.Add "GoogleChrome.lnk"                          , "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
            pFileInfo.Add "Thunderbird.lnk"                           , "%ProgramFiles(x86)%\Mozilla Thunderbird\thunderbird.exe"                             & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
            pFileInfo.Add "EmEditor.lnk"                              , """" & pRunDrive & "\Program Files\EmEditor\EmEditor.exe"""                           & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"                   & "|" & ""                                 & "|" & """" & pRunDrive & "\Program Files\EmEditor\EmEditor.exe"""

        Case "House", "NotePC"

            pFileInfo.Add "GoogleChrome.lnk"                          , "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
            pFileInfo.Add "LINE.lnk"                                  , "%UserProfile%\AppData\Local\LINE\bin\LineLauncher.exe"                               & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
            pFileInfo.Add "Thunderbird.lnk"                           , pRunDrive & "\Tools\ThunderbirdPortable\ThunderbirdPortable.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"

        Case "USB"

            pFileInfo.Add "GoogleChrome.lnk"                          , pRunDrive & "\Tools\GoogleChromePortable\GoogleChromePortable.exe"                    & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"
            pFileInfo.Add "Thunderbird.lnk"                           , pRunDrive & "\Tools\ThunderbirdPortable\ThunderbirdPortable.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\OftenUse\"

    End Select

    '��FileEdit��
    pFileInfo.Add "CaptureSTAFF.lnk"                          , pRunDrive & "\Tools\CaptureSTAFF\Capt_St.exe"                                         & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "GIMP.lnk"                                  , pRunDrive & "\Tools\GIMPPortable\GIMPPortable.exe"                                    & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "Greenshot.lnk"                             , pRunDrive & "\Tools\Greenshot\Greenshot.exe"                                          & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "ImgBurn.lnk"                               , pRunDrive & "\Tools\ImgBurnPortable\ImgBurn.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "PDFTKBuilder.lnk"                          , pRunDrive & "\Tools\PDFTKBuilderPortable\PDFTKBuilderPortable.exe"                    & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "PSSTPSST.lnk"                              , pRunDrive & "\Tools\PSSTPSST\PSSTPSST.exe"                                            & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "ResourceHacker.lnk"                        , pRunDrive & "\Tools\ResourceHacker\ResourceHacker.exe"                                & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
    pFileInfo.Add "Stirling.lnk"                              , pRunDrive & "\Tools\stir131\Stirling.exe"                                             & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"

    Select Case runKbn

        Case "House", "USB", "NotePC"

            pFileInfo.Add "CDEx.lnk"                                  , pRunDrive & "\Tools\CDExPortable\CDExPortable.exe"                                    & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
            pFileInfo.Add "Mp3tag.lnk"                                , pRunDrive & "\Tools\mp3tag\Mp3tag.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"
            pFileInfo.Add "Mp3Gain.lnk"                               , pRunDrive & "\Tools\wxMP3gainPortable\wxMP3gainPortable.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\FileEdit\"

    End Select

    '��Player�Viewer��
    pFileInfo.Add "Calibre.lnk"                               , pRunDrive & "\Tools\CalibrePortable\calibre-portable.exe"                             & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"              & "|" & ""                                         & "|" & pRunDrive & "\Tools\CalibrePortable\calibre-portable.exe"         & "|" & pRunDrive & "\Tools\CalibrePortable"
    pFileInfo.Add "FoxitReader.lnk"                           , pRunDrive & "\Tools\FoxitReaderPortable\FoxitReaderPortable.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
    pFileInfo.Add "PDF-XChangeViewer.lnk"                     , pRunDrive & "\Tools\PDF-XChangeViewerPortable\PDF-XChangeViewerPortable.exe"          & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
    pFileInfo.Add "XnView.lnk"                                , pRunDrive & "\Tools\XnViewPortable\XnViewPortable.exe"                                & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"


    Select Case runKbn

        Case "House"

            pFileInfo.Add "Kindle.lnk"                                , "%UserProfile%\AppData\Local\Amazon\Kindle\application\Kindle.exe"                    & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
            pFileInfo.Add "foobar2000.lnk"                            , pRunDrive & "\Tools\foobar2000\foobar2000.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
            pFileInfo.Add "MangaMeeya.lnk"                            , pRunDrive & "\Tools\MangaMeeya_73\MangaMeeya.exe"                                     & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
            pFileInfo.Add "VLC Media Player.lnk"                      , pRunDrive & "\Tools\VLCPortable\VLCPortable.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"

        Case "House", "USB", "NotePC"

            pFileInfo.Add "foobar2000.lnk"                            , pRunDrive & "\Tools\foobar2000\foobar2000.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
            pFileInfo.Add "MangaMeeya.lnk"                            , pRunDrive & "\Tools\MangaMeeya_73\MangaMeeya.exe"                                     & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"
            pFileInfo.Add "VLC Media Player.lnk"                      , pRunDrive & "\Tools\VLCPortable\VLCPortable.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Player�Viewer\"

    End Select

    '��Maintenance��
    pFileInfo.Add "Autoruns.lnk"                              , pRunDrive & "\Tools\AutorunsPortable\AutorunsPortable.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "CCleaner.lnk"                              , pRunDrive & "\Tools\CCleanerPortable\CCleaner64.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "ChangeKey.lnk"                             , pRunDrive & "\Tools\ChangeKey_v150\ChgKey.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "CPU-Z.lnk"                                 , pRunDrive & "\Tools\CPU-ZPortable\CPU-ZPortable.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "CrystalDiskInfo.lnk"                       , pRunDrive & "\Tools\CrystalDiskInfoPortable\CrystalDiskInfoPortable.exe"              & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "CrystalDiskMark.lnk"                       , pRunDrive & "\Tools\CrystalDiskMarkPortable\CrystalDiskMarkPortable.exe"              & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "Defraggler.lnk"                            , pRunDrive & "\Tools\DefragglerPortable\Defraggler64.exe"                              & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "FromHDDtoSSD.lnk"                          , pRunDrive & "\Tools\FromHDDtoSSD\FromHDDtoSSD_64.exe"                                 & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "GPU-Z.lnk"                                 , pRunDrive & "\Tools\GPU-ZPortable\GPU-ZPortable.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "HWMonitor.lnk"                             , pRunDrive & "\Tools\HWMonitor\HWMonitor_x64.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "IObitUninstaller.lnk"                      , pRunDrive & "\Tools\IObitUninstallerPortable\IObitUninstallerPortable.exe"            & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "PC�p�t�H�[�}���X�`�F�b�J�[.lnk"            , pRunDrive & "\Tools\PerformanceChecker\PerformanceChecker.exe"                        & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "ProcessExplorer.lnk"                       , pRunDrive & "\Tools\ProcessExplorerPortable\ProcessExplorerPortable.exe"              & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "ProcessMonitor.lnk"                        , pRunDrive & "\Tools\ProcessMonitorPortable\ProcessMonitorPortable.exe"                & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "TCPView.lnk"                               , pRunDrive & "\Tools\TCPViewPortable\TCPViewPortable.exe"                              & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "SpeedyFox.lnk"                             , pRunDrive & "\Tools\SpeedyFoxPortable\SpeedyFoxPortable.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "SystemExplorer.lnk"                        , pRunDrive & "\Tools\SystemExplorerPortable\SystemExplorerPortable.exe"                & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"
    pFileInfo.Add "Wireshark.lnk"                             , pRunDrive & "\Tools\WiresharkPortable\WiresharkPortable.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\Maintenance\"

    '��MicrosoftOffice��
    pFileInfo.Add "Access.lnk"                                , pRunDrive & "\Tools\MicrosoftOffice\RunAccess.exe"                                    & "|" & pRunDrive & "\Tools\Shortcuts\MicrosoftOffice\"
    pFileInfo.Add "Excel.lnk"                                 , pRunDrive & "\Tools\MicrosoftOffice\RunExcel.exe"                                     & "|" & pRunDrive & "\Tools\Shortcuts\MicrosoftOffice\"
    pFileInfo.Add "PowerPoint.lnk"                            , pRunDrive & "\Tools\MicrosoftOffice\RunPowerPoint.exe"                                & "|" & pRunDrive & "\Tools\Shortcuts\MicrosoftOffice\"
    pFileInfo.Add "Word.lnk"                                  , pRunDrive & "\Tools\MicrosoftOffice\RunWord.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\MicrosoftOffice\"

    '��LibreOffice��
    pFileInfo.Add "LibreOffice.lnk"                           , pRunDrive & "\Tools\LibreOfficePortable\LibreOfficePortable.exe"                      & "|" & pRunDrive & "\Tools\Shortcuts\LibreOffice\"
    pFileInfo.Add "Base(Access).lnk"                          , pRunDrive & "\Tools\LibreOfficePortable\LibreOfficeBasePortable.exe"                  & "|" & pRunDrive & "\Tools\Shortcuts\LibreOffice\"
    pFileInfo.Add "Calc(Excel).lnk"                           , pRunDrive & "\Tools\LibreOfficePortable\LibreOfficeCalcPortable.exe"                  & "|" & pRunDrive & "\Tools\Shortcuts\LibreOffice\"
    pFileInfo.Add "Impress(PowerPoint).lnk"                   , pRunDrive & "\Tools\LibreOfficePortable\LibreOfficeImpressPortable.exe"               & "|" & pRunDrive & "\Tools\Shortcuts\LibreOffice\"
    pFileInfo.Add "Writer(Word).lnk"                          , pRunDrive & "\Tools\LibreOfficePortable\LibreOfficeWriterPortable.exe"                & "|" & pRunDrive & "\Tools\Shortcuts\LibreOffice\"

    '��Development��
    pFileInfo.Add "A5SQL Mk-2.lnk"                            , pRunDrive & "\Tools\A5SQLMk-2\A5M2.exe"                                               & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
    pFileInfo.Add "BusyBox.lnk"                               , pRunDrive & "\Tools\BusyBox\RunBusyBox.bat"                                           & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
    pFileInfo.Add "cmd.lnk"                                   , "%windir%\system32\cmd.exe"                                                           & "|" & pRunDrive & "\Tools\Shortcuts\Development\"                & "|" & ""                                         & "|" & "%windir%\system32\cmd.exe"                                       & "|" & "%windir%\system32"
    pFileInfo.Add "HeidiSQL.lnk"                              , pRunDrive & "\Tools\HeidiSQL\heidisql.exe"                                            & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
    pFileInfo.Add "PowerShell.lnk"                            , "%windir%\System32\WindowsPowerShell\v1.0\powershell.exe"                             & "|" & pRunDrive & "\Tools\Shortcuts\Development\"                & "|" & ""                                         & "|" & "%windir%\System32\WindowsPowerShell\v1.0\powershell.exe"         & "|" & "%windir%\system32"
    pFileInfo.Add "RLogin.lnk"                                , pRunDrive & "\Tools\RLogin\RLogin.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
    pFileInfo.Add "WinMerge.lnk"                              , pRunDrive & "\Tools\WinMergePortable\WinMergePortable.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
    pFileInfo.Add "Zeal.lnk"                                  , pRunDrive & "\Tools\zeal-portable\zeal.exe"                                           & "|" & pRunDrive & "\Tools\Shortcuts\Development\"

    Select Case runKbn

        Case "Company", "House", "NotePC"

            pFileInfo.Add "Docker For Windows.lnk"                    , """" & pRunDrive & "\Program Files\Docker\Docker\Docker for Windows.exe"""            & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
            pFileInfo.Add "GitBash(Laravel).lnk"                      , """" & pRunDrive & "\Program Files\Git\git-bash.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\Development\"                & "|" & ""                                         & "|" & """" & pRunDrive & "\Program Files\Git\git-bash.exe"""            & "|" & "%UserProfile%\LaravelProjects\Homestead"
            pFileInfo.Add "GitBash(Project).lnk"                      , """" & pRunDrive & "\Program Files\Git\git-bash.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\Development\"                & "|" & ""                                         & "|" & """" & pRunDrive & "\Program Files\Git\git-bash.exe"""            & "|" & "%SystemRoot%\..\Project"
            pFileInfo.Add "GitBash(UserFolder).lnk"                   , """" & pRunDrive & "\Program Files\Git\git-bash.exe"""                                & "|" & pRunDrive & "\Tools\Shortcuts\Development\"                & "|" & ""                                         & "|" & """" & pRunDrive & "\Program Files\Git\git-bash.exe"""            & "|" & "%UserProfile%"
            pFileInfo.Add "Oracle VM VirtualBox.lnk"                  , """" & pRunDrive & "\Program Files\Oracle\VirtualBox\VirtualBox.exe"""                & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
            pFileInfo.Add "SourceTree.lnk"                            , "%UserProfile%\AppData\Local\SourceTree\SourceTree.exe"                               & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
            pFileInfo.Add "TeraTerm.lnk"                              , "%ProgramFiles(x86)%\teraterm\ttermpro.exe"                                           & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
            pFileInfo.Add "Visual Studio 2017.lnk"                    , "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"   & "|" & pRunDrive & "\Tools\Shortcuts\Development\"
            pFileInfo.Add "WinsSCP.lnk"                               , "%ProgramFiles(x86)%\WinSCP\WinSCP.exe"                                               & "|" & pRunDrive & "\Tools\Shortcuts\Development\"

    End Select

    '��Download�ERecording��
    pFileInfo.Add "CamStudio.lnk"                             , pRunDrive & "\Tools\CamStudioPortable\CamStudioPortable.exe"                          & "|" & pRunDrive & "\Tools\Shortcuts\Download�ERecording\"

    '��Emulator��
    Select Case runKbn

        Case "House", "NotePC"

            pFileInfo.Add "NoxAppPlayer.lnk"                          , "%ProgramFiles(x86)%\Nox\bin\Nox.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\Emulator\"
            pFileInfo.Add "NoxAppPlayerMulti-Drive.lnk"               , "%ProgramFiles(x86)%\Nox\bin\MultiPlayerManager.exe"                                 & "|" & pRunDrive & "\Tools\Shortcuts\Emulator\"

    End Select

    '��OtherTool��
    pFileInfo.Add "7-Zip.lnk"                                 , pRunDrive & "\Tools\7-ZipPortable\7-ZipPortable.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "CrenaHtml2jpg.lnk"                         , pRunDrive & "\Tools\CrenaHtml2jpg\CrenaHtml2jpg.exe"                                  & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "DeInput.lnk"                               , pRunDrive & "\Tools\DeInput\DeInput.exe"                                              & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "Everything.lnk"                            , pRunDrive & "\Tools\Everything\Everything64.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "FastCopy.lnk"                              , pRunDrive & "\Tools\FastCopyPortable\FastCopyPortable.exe"                            & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "Filistry.lnk"                              , pRunDrive & "\Tools\Filistry136\Filistry.exe"                                         & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "FireFileCopy.lnk"                          , pRunDrive & "\Tools\FireFileCopy\FFC.exe"                                             & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "FitWin.lnk"                                , pRunDrive & "\Tools\fitwin\fitwin.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "F�X�N���[���L�[�{�[�h.lnk"                 , pRunDrive & "\Tools\fkey\fkey.exe"                                                    & "|" & pRunDrive & "\Tools\Shortcuts\Other\"                      & "|" & ""                                         & "|" & pRunDrive & "\Tools\fkey\fkey.exe"                                & "|" & pRunDrive & "\Tools\fkey"
    pFileInfo.Add "IObitUnlocker.lnk"                         , pRunDrive & "\Tools\IObitUnlockerPortable\IObitUnlockerPortable.exe"                  & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "TanZIP.lnk"                                , pRunDrive & "\Tools\TanZIP\TanZIP.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "TransStickies.lnk"                         , pRunDrive & "\Tools\AutoHotKey\Tools\TransStickies\TransStickies.exe"                 & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "makeexe.lnk"                               , pRunDrive & "\Tools\makeexe\"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "Meiryo UI���匙��!!.lnk"                   , pRunDrive & "\Tools\noMeiryoUI\noMeiryoUI.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "pointClip.lnk"                             , pRunDrive & "\Tools\PointClip\pointClip.exe"                                          & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "RoboCopyGUI.lnk"                           , pRunDrive & "\Tools\RoboCopyGUI\RoboCopyGUI.exe"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "RunSpp.lnk"                                , pRunDrive & "\Tools\SPP\RunSpp.bat"                                                   & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "StopWatchD.lnk"                            , pRunDrive & "\Tools\StopWatchD\StopWatchD.exe"                                        & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "VeraCrypt.lnk"                             , pRunDrive & "\Tools\VeraCrypt\VeraCrypt.exe"                                          & "|" & pRunDrive & "\Tools\Shortcuts\Other\"
    pFileInfo.Add "XMind.lnk"                                 , pRunDrive & "\Tools\XMind\XMind.exe"                                                  & "|" & pRunDrive & "\Tools\Shortcuts\Other\"

    Select Case runKbn

        Case "House", "USB" ,"NotePC"

            pFileInfo.Add "JoyToKey.lnk"                              , pRunDrive & "\Tools\JoyToKey\JoyToKey.exe"                                            & "|" & pRunDrive & "\Tools\Shortcuts\Other\"

    End Select

    '���N���b�v�{�[�h���`�̃����N���쐬��
    pFileInfo.Add "00_FIFO���[�h�؂�ւ�.lnk"                 , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/ff"
    pFileInfo.Add "01_�e�s�擪�Ɂu �� �v��}���i���p���j.lnk" , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 1"
    pFileInfo.Add "02_�e�s�擪�Ɂu 001�F �v�̘A�Ԃ�}��.lnk"  , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 2"
    pFileInfo.Add "03_�e�s���u �h �v�ň͂�.lnk"                , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 3"
    pFileInfo.Add "04_�e�s���u ' �v�ň͂�.lnk"                , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 4"
    pFileInfo.Add "05_�u�啶���v�ɕϊ�.lnk"                   , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 5"
    pFileInfo.Add "06_�u�������v�ɕϊ�.lnk"                   , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 6"
    pFileInfo.Add "07_�u�S�p�v���u���p�v�ɕϊ�.lnk"           , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 7"
    pFileInfo.Add "08_�u���p�v���u�S�p�v�ɕϊ�.lnk"           , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 8"
    pFileInfo.Add "09_�u�J�^�J�i�v���u�Ђ炪�ȁv�ɕϊ�.lnk"   , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 9"
    pFileInfo.Add "10_�u�Ђ炪�ȁv���u�J�^�J�i�v�ɕϊ�.lnk"   , pRunDrive & "\Tools\clibor\Clibor.exe"                                                & "|" & pRunDrive & "\Tools\Shortcuts\ClipConversion\"             & "|" & "/sd 10"

    '�����C�ɓ���f�B���N�g���̃����N���쐬��
    pFileInfo.Add "�R���s���[�^.lnk"                          , objAppli.Namespace(17).Self.Path                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"
    pFileInfo.Add "�f�X�N�g�b�v.lnk"                          , objShell.SpecialFolders("Desktop")                                                    & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"
    pFileInfo.Add "Tools.lnk"                                 , pRunDrive & "\Tools\"                                                                 & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"
    pFileInfo.Add "Bookmark.lnk"                              , pRunDrive & "\Tools\Shortcuts\Bookmark\"                                              & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"
    pFileInfo.Add "�_�E�����[�h.lnk"                          , objAppli.Namespace(40).Self.Path & "\Downloads\"                                      & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"
    pFileInfo.Add "CreateScript.lnk"                          , pRunDrive & "\Tools\CreateScript"                                                     & "|" & pRunDrive & "\Tools\Shortcuts\Favorite\"

    '��Windows�i�A�N�Z�T���j��
    pFileInfo.Add "Windows Media Player.lnk"                  , "%ProgramFiles(x86)%\Windows Media Player\wmplayer.exe"                               & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "�R�}���h�v�����v�g.lnk"                    , "%windir%\system32\cmd.exe"                                                           & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"         & "|" & ""                                         & "|" & "%windir%\system32\cmd.exe"                                       & "|" & "%windir%\system32"
    pFileInfo.Add "�^�X�N�}�l�[�W���[.lnk"                    , "%windir%\system32\taskmgr.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "�y�C���g.lnk"                              , "%windir%\system32\mspaint.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "������.lnk"                                , "%windir%\system32\notepad.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "�����[�g�f�X�N�g�b�v.lnk"                  , "%windir%\system32\mstsc.exe"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "���[�h�p�b�h.lnk"                          , "%ProgramFiles%\Windows NT\Accessories\wordpad.exe"                                   & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"
    pFileInfo.Add "�d��.lnk"                                  , "%windir%\system32\calc.exe"                                                          & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�A�N�Z�T��\"

    '��Windows�i�R���g���[���p�l���j��
    pFileInfo.Add "Windows Update.lnk"                        , "%windir%\system32\wuapp.exe"                                                         & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & ""                                         & "|" & "%WinDir%\System32\shell32.dll, 46"
    pFileInfo.Add "�R���g���[���p�l��.lnk"                    , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\"
    pFileInfo.Add "�V�X�e��.lnk"                              , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & "/name Microsoft.System"                   & "|" & "%WinDir%\System32\shell32.dll, 272"
    pFileInfo.Add "�f�o�C�X�}�l�[�W���[.lnk"                  , "%windir%\system32\devmgmt.msc"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\"
    pFileInfo.Add "�l�b�g���[�N�Ƌ��L�Z���^�[.lnk"            , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & "/name Microsoft.NetworkAndSharingCenter"  & "|" & "%WinDir%\System32\shell32.dll, 276"
    pFileInfo.Add "�t�H���_�[�I�v�V����.lnk"                  , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & "folders"                                  & "|" & "%WinDir%\System32\shell32.dll, 110"
    pFileInfo.Add "�v���O�����̒ǉ��ƍ폜.lnk"                , "%windir%\system32\appwiz.cpl"                                                        & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & ""                                         & "|" & "%WinDir%\System32\shell32.dll, 162"
    pFileInfo.Add "�l�ݒ�.lnk"                              , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & "/name Microsoft.Personalization"          & "|" & "%WinDir%\System32\shell32.dll, 141"
    pFileInfo.Add "�d���I�v�V����.lnk"                        , "%windir%\system32\powercfg.cpl"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�R���g���[���p�l��\" & "|" & ""                                         & "|" & "%windir%\system32\powercfg.cpl, 0"

    '��Windows�i���̑��j��
    pFileInfo.Add "DirectX�f�f�c�[��.lnk"                     , "%windir%\system32\dxdiag.exe"                                                        & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "Internet Explorer.lnk"                     , "%ProgramFiles%\Internet Explorer\iexplore.exe"                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "Windows���r���e�B�Z���^�[.lnk"             , "%windir%\system32\mblctr.exe"                                                        & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "�V�X�e���\��.lnk"                          , "%windir%\system32\msconfig.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "�f�B�X�N�̊Ǘ�.lnk"                        , "%windir%\system32\diskmgmt.msc"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "���W�X�g���G�f�B�^.lnk"                    , "%windir%\SysWOW64\regedit.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"
    pFileInfo.Add "��ʂ̃v���p�e�B.lnk"                      , "%windir%\system32\desk.cpl"                                                          & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"             & "|" & ""                                         & "|" & "%WinDir%\System32\shell32.dll, 174"
    pFileInfo.Add "�n�[�h�E�F�A�̈��S�Ȏ��O��.lnk"          , "%windir%\system32\RunDll32.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"             & "|" & "shell32.dll,Control_RunDLL HotPlug.dll"   & "|" & "%SystemRoot%\system32\hotplug.dll, 0"
    pFileInfo.Add "�R���s���[�^�̃��b�N.lnk"                  , "%windir%\System32\rundll32.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"             & "|" & "user32.dll,LockWorkStation"               & "|" & "%WinDir%\System32\shell32.dll, 44"
    pFileInfo.Add "ShutDownDialog.lnk"                        , pRunDrive & "\Tools\CreateScript\ShowShutdownWindowsDialog\exe\ShutDownDialog.exe"    & "|" & pRunDrive & "\Tools\Shortcuts\Windows\���̑�\"

    '��Windows�i�Ǘ��c�[���j��
    pFileInfo.Add "�C�x���g�r���[�A�[.lnk"                    , "%windir%\system32\eventvwr.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"
    pFileInfo.Add "�R���s���[�^�̊Ǘ�.lnk"                    , "%windir%\system32\compmgmt.msc"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"
    pFileInfo.Add "�T�[�r�X.lnk"                              , "%windir%\system32\services.msc"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"
    pFileInfo.Add "�f�[�^�\�[�X(ODBC)_32bit.lnk"              , "%windir%\SysWOW64\odbcad32.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"         & "|" & ""                                         & "|" & "%windir%\system32\odbcad32.exe"
    pFileInfo.Add "�f�[�^�\�[�X(ODBC)_64bit.lnk"              , "%windir%\system32\odbcad32.exe"                                                      & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"
    pFileInfo.Add "�p�t�H�[�}���X���j�^�[.lnk"                , "%windir%\system32\perfmon.msc"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"
    pFileInfo.Add "�Ǘ��c�[��.lnk"                            , "%windir%\system32\control.exe"                                                       & "|" & pRunDrive & "\Tools\Shortcuts\Windows\�Ǘ��c�[��\"         & "|" & "admintools"                               & "|" & "%windir%\system32\imageres.dll, 109"

    '��Explorers�̃V���[�g�J�b�g���쐬��
    pFileInfo.Add "01.Explorer.lnk"                           , "%windir%\explorer.exe"                                                               & "|" & pRunDrive & "\Tools\Shortcuts\Explorers\"                  & "|" & "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
    pFileInfo.Add "02.DoubleExplorer.lnk"                     , pRunDrive & "\Tools\AutoHotKey\Tools\Explorers\Explorers.exe"                         & "|" & pRunDrive & "\Tools\Shortcuts\Explorers\"                  & "|" & ""                                         & "|" & pRunDrive & "\Tools\AutoHotKey\Tools\Explorers\ico\Explorers.ico"
    pFileInfo.Add "03.FourthExplorer.lnk"                     , pRunDrive & "\Tools\AutoHotKey\Tools\Explorers\Explorers.exe"                         & "|" & pRunDrive & "\Tools\Shortcuts\Explorers\"                  & "|" & "4"                                        & "|" & pRunDrive & "\Tools\AutoHotKey\Tools\Explorers\ico\Explorers.ico"

End Function

'***********************************************************************
'* ������   �F �t�H���_�쐬����                                        *
'* ����     �F pPath  �쐬����t�H���_�p�X�i�t���p�X�j                 *
'* �������e �F �ċA�I�Ƀt�H���_���쐬���Ă����܂�                      *
'*             �h���C�u �� �h���C�u\�K�w�P���h���C�u\�K�w�P\�K�w�Q\    *
'*             �� �h���C�u\�K�w�P\�K�w�Q\�Ώۃt�H���_                  *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Function CreateNotExistFolder(ByVal pPath)

    '�ϐ��錾�E�C���X�^���X�쐬
    Dim objFso       : set objFso   = WScript.CreateObject("Scripting.FileSystemObject")  'FileSystemObject�I�u�W�F�N�g
    Dim driveName    : driveName    = Left(objFso.GetDriveName(pPath),2)                  '�h���C�u�����擾
    Dim parentFolder : parentFolder = objFso.GetParentFolderName(pPath)                   '�e�t�H���_�[�����擾

    '�Ώۂ̃h���C�u�����݂��鎞
    If objFso.DriveExists(driveName) Then

        set objDrive = objFso.GetDrive(driveName) 'Drive�I�u�W�F�N�g���쐬

    Else

        Exit Function                             '�������I��

    End If

    '�h���C�u�̏������ł��Ă��鎞
    If objDrive.IsReady Then

        '�g���q�����񂪎擾�o�����ꍇ(�t�@�C���̎�)
        If Len(objFso.GetExtensionName(pPath)) > 0 Then

            '�e�t�H���_�[�����݂��Ȃ����A�Ώۃp�X����e�t�H���_�[�쐬����i�ċA�I�j
            If Not(objFso.FolderExists(parentFolder)) Then CreateNotExistFolder(parentFolder)

        Else

            '�Ώۃt�H���_�[�����݂��Ȃ���
            If Not(objFso.FolderExists(pPath)) Then

                '�e�t�H���_�[���쐬��A�Ώۃt�H���_�[���쐬�i�ċA�I�j
                CreateNotExistFolder(parentFolder)
                objFso.CreateFolder(pPath)

            End If

        End If

    End If

    '�I�u�W�F�N�g�̔j��
    Set objFso   = Nothing
    Set objDrive = Nothing

End Function
