'**************************************************************************************
'* �v���O������ �F �X�^�[�g�A�b�v�v���O�����ꊇ�I���X�N���v�g                         *
'* �����T�v     �F �X�^�[�g�A�b�v�ŋN��������v���O�������P���I�����邩�ǂ������[ *
'*                 �U�[�ɑΘb�Ŋm�F�i���b�Z�[�W�{�b�N�X�̂͂��A�������j�B�u�͂��v��   *
'*                 �I�����ꂽ�v���O���������ׂďI�����܂��B                           *
'*                 ���N������Ă��Ȃ��v���O�������u�͂��v�ƑI�����Ă������N���܂���   *
'*                   Clibor�̓N���b�v�{�[�h�̗������ۑ�����Ȃ��̂Œ��ӁI�I           *
'* ����         �F                                                                    *
'* �ݒ�         �F                                                                    *
'**************************************************************************************

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '*****************************************
    '* �������s�����[�U�[�ɑΘb              *
    '*****************************************
    '���b�Z�[�W�̕\��
    Dim mContinueProcessingResult : mContinueProcessingResult = MsgBox("�X�^�[�g�A�b�v�v���O�����ꊇ�I�����������s���܂��B" & vbCrLf & "��낵���ł����H", vbOKCancel, "�X�^�[�g�A�b�v�v���O�����ꊇ�I������")

    '�L�����Z���������ꂽ���͏������I��
    If mContinueProcessingResult = vbCancel Then Wscript.Quit()

    '*****************************************
    '* �I���v���O�����̑I�菈��              *
    '*****************************************
    '�I������v���O�����i�[Dictionary
    Dim mExitExes : Set mExitExes = WScript.CreateObject("Scripting.Dictionary")

    '�I������v���O�����̒ǉ�����
    Set mExitExes = AddExitExe(mExitExes)

    '*****************************************
    '* �v���O�����̈ꊇ�I������              *
    '*****************************************
    'Dictionary�Ɋi�[����Ă���v���O���������J��Ԃ�
    For Each mExeName In mExitExes.Keys

		    '�v���O�����̏I������
        For Each Process in GetObject("winmgmts:{impersonationLevel=impersonate}").ExecQuery("select * from Win32_Process where Name='" & mExitExes(mExeName) & "'")

            Process.terminate

        Next

    Next

End Sub

'***********************************************************************
'* ������   �F �I���Ώۃv���O�����̒ǉ�����                            *
'* ����     �F pExitExes �I������v���O�����i�[Dictionary              *
'* �������e �F �I���Ώۃv���O������Dictionary�ɒǉ�����                *
'*             ���b�Z�[�W�{�b�N�X�łP���m�F���Ă���                *
'* �߂�l   �F pExitExes                                               *
'***********************************************************************
Function AddExitExe(ByVal pExitExes)

    '7+ Taskbar Tweaker�̏I����
    Dim mIsRun7TaskbarTweaker : mIsRun7TaskbarTweaker = IsRunProgram("7+ Taskbar Tweaker.ex2")
    If mIsRun7TaskbarTweaker = True Then

        Dim mIsRun7TaskbarTweakerExitResult : mIsRun7TaskbarTweakerExitResult = GetSelectedUserResultForExitProgram("7+ Taskbar Tweaker���I�����܂����H", "7+ Taskbar Tweaker�I����")
        If mIsRun7TaskbarTweakerExitResult = vbYes Then

            pExitExes.Add "7+ Taskbar Tweaker" , "7+ Taskbar Tweaker.ex2"

        End If

    End If

    'AkabeiMonitor�̏I����
    Dim mIsRunAkabeiMonitor : mIsRunAkabeiMonitor = IsRunProgram("akamoni.exe")
    If mIsRunAkabeiMonitor = True Then

        Dim mAkabeiMonitorExitResult : mAkabeiMonitorExitResult = GetSelectedUserResultForExitProgram("AkabeiMonitor���I�����܂����H", "AkabeiMonitor�I����")
        If mAkabeiMonitorExitResult = vbYes Then

            pExitExes.Add "AkabeiMonitor", "akamoni.exe"

        End If

    End If

    'AutoHotKeyTool�̏I����
    Dim mIsRunAutoHotKeyTool : mIsRunAutoHotKeyTool = IsRunProgram("AutoHotKeyTool.exe")
    If mIsRunAutoHotKeyTool = True Then

        Dim mAutoHotKeyToolExitResult : mAutoHotKeyToolExitResult  = GetSelectedUserResultForExitProgram("AutoHotKeyTool���I�����܂����H", "AutoHotKeyTool�I����")
        If mAutoHotKeyToolExitResult = vbYes Then

            pExitExes.Add "AutoHotKeyTool", "AutoHotKeyTool.exe"

        End If

    End If

    'befoo�̏I����
    Dim mIsRunbefoo : mIsRunbefoo = IsRunProgram("befooPtan.exe")
    If mIsRunbefoo = True Then

        Dim mbefooExitResult : mbefooExitResult  = GetSelectedUserResultForExitProgram("befoo���I�����܂����H", "befoo�I����")
        If mbefooExitResult = vbYes Then

            pExitExes.Add "befoo", "befooPtan.exe"

        End If

    End If
    
    'BijinTokeiGadget�̏I����
    Dim mIsRunBijinTokeiGadget : mIsRunBijinTokeiGadget = IsRunProgram("BijinTokeiGadget.exe")
    If mIsRunBijinTokeiGadget = True Then

        Dim mBijinTokeiGadgetExitResult : mBijinTokeiGadgetExitResult  = GetSelectedUserResultForExitProgram("BijinTokeiGadget���I�����܂����H", "BijinTokeiGadget�I����")
        If mBijinTokeiGadgetExitResult = vbYes Then

            pExitExes.Add "BijinTokeiGadget", "BijinTokeiGadget.exe"

        End If

    End If


    'BijoLinuxGadget�̏I����
    Dim mIsRunBijoLinuxGadget : mIsRunBijoLinuxGadget = IsRunProgram("BijoLinuxGadget.exe")
    If mIsRunBijoLinuxGadget = True Then

        Dim mBijoLinuxGadgetExitResult : mBijoLinuxGadgetExitResult = GetSelectedUserResultForExitProgram("BijoLinuxGadget���I�����܂����H", "BijoLinuxGadget�I����")
        If mBijoLinuxGadgetExitResult = vbYes Then

            pExitExes.Add "BijoLinuxGadget", "BijoLinuxGadget.exe"

        End If

    End If



    'Chronus�̏I����
    Dim mIsRunChronus : mIsRunChronus = IsRunProgram("Chronus.exe")
    If mIsRunChronus = True Then

        Dim mChronusExitResult : mChronusExitResult  = GetSelectedUserResultForExitProgram("Chronus���I�����܂����H", "Chronus�I����")
        If mChronusExitResult = vbYes Then

            pExitExes.Add "Chronus", "Chronus.exe"

        End If

    End If

    'Clibor�̏I����
    Dim mIsRunClibor : mIsRunClibor = IsRunProgram("Clibor.exe")
    If mIsRunClibor = True Then

        Dim mCliborExitResult : mCliborExitResult  = GetSelectedUserResultForExitProgram("Clibor���I�����܂����H", "Clibor�I����")
        If mCliborExitResult = vbYes Then

            pExitExes.Add "Clibor", "Clibor.exe"

        End If

    End If

    'Evernote�̏I����
    Dim mIsRunEvernote : mIsRunEvernote = IsRunProgram("Evernote.exe")
    If mIsRunEvernote = True Then

        Dim mEvernoteExitResult : mEvernoteExitResult = GetSelectedUserResultForExitProgram("Evernote���I�����܂����H", "Evernote�I����")
        If mEvernoteExitResult = vbYes Then

            pExitExes.Add "Evernote"        , "Evernote.exe"
            pExitExes.Add "EvernoteClipper" , "EvernoteClipper.exe"
            pExitExes.Add "EvernotePortable", "EvernotePortable.exe"
            pExitExes.Add "EvernoteTray"    , "EvernoteTray.exe"

        End If

    End If

    'GoogleDrive�̏I����
    Dim mIsRunGoogleDrive : mIsRunGoogleDrive = IsRunProgram("googledrivesync.exe")
    If mIsRunGoogleDrive = True Then

        Dim mGoogleDriveExitResult : mGoogleDriveExitResult = GetSelectedUserResultForExitProgram("GoogleDrive���I�����܂����H", "GoogleDrive�I����")
        If mGoogleDriveExitResult = vbYes Then

            pExitExes.Add "GoogleDrive", "googledrivesync.exe"

        End If

    End If

    'Freeraser�̏I����
    Dim mIsRunFreeraser : mIsRunFreeraser = IsRunProgram("Freeraser.exe")
    If mIsRunFreeraser = True Then

        Dim mFreeraserExitResult : mFreeraserExitResult = GetSelectedUserResultForExitProgram("Freeraser���I�����܂����H", "Freeraser�I����")
        If mFreeraserExitResult = vbYes Then

            pExitExes.Add "Freeraser", "Freeraser.exe"

        End If

    End If

    'MouseGestureL�̏I����
    Dim mIsRunMouseGestureL : mIsRunMouseGestureL = IsRunProgram("MouseGestureL.exe")
    If mIsRunMouseGestureL = True Then

        Dim mMouseGestureLExitResult : mMouseGestureLExitResult  = GetSelectedUserResultForExitProgram("MouseGestureL���I�����܂����H", "MouseGestureL�I����")
        If mMouseGestureLExitResult = vbYes Then

            pExitExes.Add "MouseGestureL", "MouseGestureL.exe"

        End If

    End If

    'Orchis�̏I����
    Dim mIsRunOrchis : mIsRunOrchis = IsRunProgram("orchis.exe")
    If mIsRunOrchis = True Then

        Dim mOrchisExitResult : mOrchisExitResult  = GetSelectedUserResultForExitProgram("Orchis���I�����܂����H", "Orchis�I����")
        If mOrchisExitResult = vbYes Then

            pExitExes.Add "OrchisService", "ocobsv.exe"
            pExitExes.Add "Orchis"       , "orchis.exe"

        End If

    End If

    'RocketDock�̏I����
    Dim mIsRunRocketDock : mIsRunRocketDock = IsRunProgram("RocketDock.exe")
    If mIsRunRocketDock = True Then

        Dim mRocketDockExitResult : mRocketDockExitResult  = GetSelectedUserResultForExitProgram("RocketDock���I�����܂����H", "RocketDock�I����")
        If mRocketDockExitResult = vbYes Then

            pExitExes.Add "RocketDock", "RocketDock.exe"

        End If

    End If

    'Rss����̏I����
    Dim mIsRunRssNews : mIsRunRssNews = IsRunProgram("RssNews.exe")
    If mIsRunRssNews = True Then

        Dim mRssNewsExitResult : mRssNewsExitResult  = GetSelectedUserResultForExitProgram("Rss������I�����܂����H", "Rss����I����")
        If mRssNewsExitResult = vbYes Then

            pExitExes.Add "RssNews", "RssNews.exe"

        End If

    End If

    'Slack�̏I����
    Dim mIsRunSlack : mIsRunSlack = IsRunProgram("slack.exe")
    If mIsRunSlack = True Then

        Dim mSlackExitResult : mSlackExitResult = GetSelectedUserResultForExitProgram("Slack���I�����܂����H", "Slack�I����")
        If mSlackExitResult = vbYes Then

            pExitExes.Add "Slack", "slack.exe"

        End If

    End If

    'Stickies�̏I����
    Dim mIsRunStickies : mIsRunStickies = IsRunProgram("Stickies.exe")
    If mIsRunStickies = True Then

        Dim mStickiesExitResult : mStickiesExitResult  = GetSelectedUserResultForExitProgram("Stickies���I�����܂����H", "Stickies�I����")
        If mStickiesExitResult = vbYes Then

            pExitExes.Add "Stickies", "Stickies.exe"

        End If

    End If

    'SuperF4�̏I����
    Dim mIsRunSuperF4 : mIsRunSuperF4 = IsRunProgram("SuperF4.exe")
    If mIsRunSuperF4 = True Then

        Dim mSuperF4ExitResult : mSuperF4ExitResult = GetSelectedUserResultForExitProgram("SuperF4���I�����܂����H", "SuperF4�I����")
        If mSuperF4ExitResult = vbYes Then

            pExitExes.Add "SuperF4", "SuperF4.exe"

        End If

    End If

    'TVClock�̏I����
    Dim mIsRunTVClock : mIsRunTVClock = IsRunProgram("TVClock.exe")
    If mIsRunTVClock = True Then

        Dim mTVClockExitResult : mTVClockExitResult  = GetSelectedUserResultForExitProgram("TVClock���I�����܂����H", "TVClock�I����")
        If mTVClockExitResult = vbYes Then

            pExitExes.Add "TVClock", "TVClock.exe"

        End If

    End If

    'WheelAccele�̏I����
    Dim mIsRunWheelAccele : mIsRunWheelAccele = IsRunProgram("WheelAccele.exe")
    If mIsRunWheelAccele = True Then

        Dim mWheelAcceleExitResult : mWheelAcceleExitResult  = GetSelectedUserResultForExitProgram("WheelAccele���I�����܂����H", "WheelAccele�I����")
        If mWheelAcceleExitResult  = vbYes Then

            pExitExes.Add "WheelAccele" , "WheelAccele.exe"

        End If

    End If

    'X-Finder�̏I����
    Dim mIsRunXFinder : mIsRunXFinder = IsRunProgram("XF.exe")
    If mIsRunXFinder = True Then

        Dim mXFinderExitResult : mXFinderExitResult = GetSelectedUserResultForExitProgram("X-Finder���I�����܂����H", "X-Finder�I����")
        If mXFinderExitResult = vbYes Then

            pExitExes.Add "X-Finder32" , "XF.exe"
            pExitExes.Add "X-Finder64" , "xf64.exe"

        End If

    End If

    '����\��̏I����
    Dim mIsRunWeather : mIsRunWeather = IsRunProgram("Weather64.exe")
    If mIsRunWeather = True Then

        Dim mRunWeatherExitResult : mRunWeatherExitResult  = GetSelectedUserResultForExitProgram("����\����I�����܂����H", "����\��I����")
        If mRunWeatherExitResult = vbYes Then

            pExitExes.Add "Weather", "Weather64.exe"

        End If

    End If

    '�_�ǂ݂����̏I����
    Dim mIsRunBouyomiChan : mIsRunBouyomiChan = IsRunProgram("BouyomiChan.exe")
    If mIsRunBouyomiChan = True Then

        Dim mBouyomiChanExitResult : mBouyomiChanExitResult  = GetSelectedUserResultForExitProgram("�_�ǂ݂������I�����܂����H", "�_�ǂ݂����I����")
        If mBouyomiChanExitResult = vbYes Then

            pExitExes.Add "BouyomiChan", "BouyomiChan.exe"

        End If

    End If

    Set AddExitExe = pExitExes

End Function

'***********************************************************************
'* ������   �F �v���O�����I����                                      *
'* ����     �F pMsgBoxTitle  ���b�Z�[�W�{�b�N�X�̃^�C�g��              *
'*             pMsgBoxDetail ���b�Z�[�W�{�b�N�X�̓��e                  *
'* �������e �F ���b�Z�[�W�{�b�N�X��\�����[�U�[�Ƀv���O�������I������  *
'*             ���ǂ����Θb�����ʂ�Ԃ�                                *
'* �߂�l   �F ���b�Z�[�W�{�b�N�X�̌��� / vbYes�AvbNo                  *
'***********************************************************************
Function GetSelectedUserResultForExitProgram(ByVal pMsgBoxTitle,ByVal pMsgBoxDetail)

    '���[�U�[�Ƀv���O�����̏I����
    Dim mMsgBoxResult : mMsgBoxResult = MsgBox(pMsgBoxTitle, vbYesNo, pMsgBoxDetail)

    '���[�U�[���I���������ʂ��Z�b�g
    GetSelectedUserResultForExitProgram = mMsgBoxResult

End Function

'***********************************************************************
'* ������   �F �v���O�����N����Ԃ��擾                                *
'* ����     �F pProgramExe  �Ώۃv���O�����i������.exe�`���j           *
'* �������e �F �Ώۃv���O�������N�������ǂ������擾����                *
'* �߂�l   �F �Ώۃv���O�������N�����L�� / True�AFalse                *
'***********************************************************************
Function IsRunProgram(ByVal pProgramExe)

    '�N�����L���A�f�t�H���g�l�ݒ�
    IsRunProgram = False

    '�Ώۃv���O�������擾
    Set mPrograms = GetObject("winmgmts:").ExecQuery("Select * from Win32_Process where Name='" & pProgramExe & "'")

    '�Ώۃv���O�������擾�o������N�����Ƃ���i�P���ł���������j
    For Each Program in mPrograms

        IsRunProgram = True
        Exit For

    Next

End Function
