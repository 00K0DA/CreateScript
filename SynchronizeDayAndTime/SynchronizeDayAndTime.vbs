'**************************************************************************************
'* �v���O������ �F ���������X�N���v�g                                                 *
'* �����T�v     �F TimeServer���猻�ݓ��t�E���������擾���p�\�R���̓��t�Ǝ����̐ݒ� *
'*                 ���s���܂�                                                         *
'*                   �@�Ǘ��҂Ƃ��Ď��s                                               *
'*                   �ATimeServer�ɃA�N�Z�X�����ݓ��t�E���������擾                 *
'*                   �BTimeServer����擾�������ݓ��t�E������񂩂�o�ߓ����A������� *
'*                     ���擾�i1900/1/1����̌o�ߎ��ԗp�̏����쐬����j             *
'*                   �C���t�E�����ݒ���R�}���h�ōs��                                 *
'* ����         �F �Q�lURL�Fhttp://35huyu.seesaa.net/article/382978581.html           *
'* �ݒ�         �F                                                                    *
'**************************************************************************************
Option Explicit

'*****************************************
'* �萔                                  *
'*****************************************
'�^�C���T�[�o�[�A�h���X
Dim cTimeSverAddress : cTimeSverAddress = "https://ntp-a1.nict.go.jp/cgi-bin/ntp"

'HTTP�X�e�[�^�X�R�[�h�Q�O�O�i���N�G�X�g�̐����j
Dim cHttpStatusCode200 : cHttpStatusCode200 = 200

'���Ԋ֘A�̒萔
Dim cMinuteSecond         : cMinuteSecond         = 60                            '�P���Ԃ̕b��
Dim cHourSecond           : cHourSecond           = cMinuteSecond * cMinuteSecond '�P���ԕ��̕b�� ���U�O�b * �U�O��
Dim cDaySecond            : cDaySecond            = cHourSecond * 24              '�P�����̕b��   ���P���ԕ��̕b�� * �Q�S����
Dim cTimeDifferenceForGMT : cTimeDifferenceForGMT = 9                             '���{�^�����ƃO���j�b�W�W�����ԂƂ̎���
Dim cCalculationMinDay    : cCalculationMinDay    = "1900/1/1"                    '�v�Z�ŏ����t

'���b�Z�[�W�{�b�N�X�֘A
Dim cMsgBoxTitle                     : cMsgBoxTitle                     = "���������X�N���v�g"
Dim cMsgBoxTimeServerConnectionError : cMsgBoxTimeServerConnectionError = "�^�C���T�[�o�[�ɐڑ��ł��܂���ł����B" & vbCrLf & "�������I�����܂��B"
Dim cMsgBoxProcessSucess             : cMsgBoxProcessSucess             = "�����̓����ɐ������܂����B"

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '----------------------------------------
    ' �Ǘ��҂Ƃ��Ď��s
    '----------------------------------------
    RunAdministrator()

    '----------------------------------------
    ' TimeServer���猻�ݓ��t�E���������擾
    '----------------------------------------
    '�uWinHttpRequest�vCOM�I�u�W�F�N�g���쐬
    Dim mWinHttpRequest : Set mWinHttpRequest = CreateObject("WinHttp.WinHttpRequest.5.1")

    'HTTP���N�G�X�g�̑��M
    mWinHttpRequest.Open "GET", cTimeSverAddress, false
    mWinHttpRequest.Send

    'HTTP�X�e�[�^�X�R�[�h���Q�O�O�ȊO�̎�
    If mWinHttpRequest.Status <> 200 Then
    
        '�^�C���T�[�o�[�ɐڑ��ł��܂���G���[��\��
        MsgBox cMsgBoxTimeServerConnectionError, vbOKOnly, cMsgBoxTitle
        Exit Sub
        
    End If
    
    '���X�|���X�{�f�B�̓��e���擾���� ��html���Ŏ擾�����
    Dim mResponseText : mResponseText = mWinHttpRequest.ResponseText

    '���X�|���X�{�f�B�̓��e����1900/1/1���猻�݂܂ł̕b�����擾�i�O���j�b�W�W�����ԂŎ擾�����j
    Dim mSecondToNowDate : mSecondToNowDate = GetTextForRegExpMatch("[0-9]*\.[0-9]*", mResponseText)
    
    '1900/1/1�ɃO���j�b�W�W�����ԂƓ����^���{�̎�������ǉ�����
    mSecondToNowDate = Int(mSecondToNowDate + (cTimeDifferenceForGMT * cHourSecond))
    
    '----------------------------------------
    ' �o�ߓ����A���������擾
    '----------------------------------------
    '���݂܂ł̌o�ߓ����A���������擾���� 
    '���umDays�v���F�umHour�v���ԁF�umMinute�v���F�umSecond�v�b 1900/1/1����o�߂��Ă��܂�
    
    '�umDays�v�����擾
    Dim mDays                  : mDays                  = Int(mSecondToNowDate / cDaySecond)
    Dim mDaySecondToNowDate    : mDaySecondToNowDate    = mDays * cDaySecond
    
    '�umHour�v���Ԃ��擾����
    Dim mHour                  : mHour                  = Int((mSecondToNowDate - mDaySecondToNowDate) / cHourSecond)
    Dim mHourSecondToNowDate   : mHourSecondToNowDate   = mHour * cHourSecond
    
    '�umMinute�v�����擾����
    Dim mMinute                : mMinute                = Int((mSecondToNowDate - ( mDaySecondToNowDate + mHourSecondToNowDate ) ) / cMinuteSecond)
    Dim mMinuteSecondToNowDate : mMinuteSecondToNowDate = mMinute * cMinuteSecond
    
    '�umSecond�v�b���擾����
    Dim mSecond                : mSecond = Int(mSecondToNowDate - ( mDaySecondToNowDate + mHourSecondToNowDate + mMinuteSecondToNowDate ))
    
    '���ݓ��t�A���ݎ������擾
    Dim mDate : mDate = DateAdd("d", CCur(mDays), cCalculationMinDay)
    Dim mTime : mTime = mHour & ":" & mMinute & ":" & mSecond

    '----------------------------------------
    ' ���t�E�����ݒ�
    '----------------------------------------
    Dim mObjShell : Set mObjShell = WScript.CreateObject("WScript.Shell") 
    
    '���t�ݒ�R�}���h�����s
    Dim mDateSetCommand : mDateSetCommand = "cmd /c date " & mDate
    mObjShell.Exec(mDateSetCommand)
    
    '�����ݒ�R�}���h�����s
    Dim mTimeSetCommand : mTimeSetCommand = "cmd /c time " & mTime
    mObjShell.Exec(mTimeSetCommand)

    '�uWScript.Shell�v�I�u�W�F�N�g�̔j������
    Set mObjShell = Nothing

    '----------------------------------------
    ' �I������
    '----------------------------------------
    '�����̊������b�Z�[�W��\��
    MsgBox "�u" & mDate & " " & mTime & "�v��" & VbCrLf & cMsgBoxProcessSucess, vbOKOnly, cMsgBoxTitle

End Sub


'***********************************************************************
'* ������   �F �Ǘ��Ҍ����ŃX�N���v�g�����s                            *
'* ����     �F �Ȃ�                                                    *
'* �������e �F WSH�o�[�W������5.7�ȏ�̂Ƃ�WMI��񂩂�OS�����擾���A *
'*             OS�̃o�[�W������VISTA�ȍ~�̎��͊Ǘ��Ҍ����ɏ��i����     *
'*             ��Windows Vista �ȏ�̊��ł́A���[�U�[�A�J�E���g����  *
'*               (UAC)�̂��߁AVBScript���u�Ǘ��҂Ƃ��Ď��s�v�ł��܂��� *
'* �Q�lURL  �Fhttps://www.server-world.info/query?os=Other&p=vbs&f=1   *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub RunAdministrator()

    '�R�}���h���C���������O�� ���� WSH�̃o�[�W�������u5.7�v�ȏ�̎�
    Do While WScript.Arguments.Count = 0 And WScript.Version >= 5.7

        'WMI����OS�����擾
        Dim WMI : Set WMI = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
        Dim OS  : Set OS = WMI.ExecQuery("SELECT *FROM Win32_OperatingSystem")
        
        'OS��񕪌J��Ԃ�
        Dim mValue
        For Each mValue in OS
        
            'OS�̃o�[�W�������u6.0�v��菬�������͏������I��
            If Left(mValue.Version, 3) < 6.0 Then Exit Sub
            
        Next

        '���̃X�N���v�g���Ǘ��҂Ŏ��s
        Dim mObjApp : Set mObjApp = CreateObject("Shell.Application")
        mObjApp.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"

        WScript.Quit
        
    Loop

End Sub

'***********************************************************************
'* ������   �F ���K�\���Ɉ�v���镶������擾                          *
'* ����     �F pPattern ���K�\���p�^�[��                               *
'*             pString  �Ώە�����                                     *
'* �������e �F �p�^�[���Ɉ�v�i���K�\���Ń`�F�b�N�j������������擾    *
'* �߂�l   �F �p�^�[���Ɉ�v����������                                *
'***********************************************************************
Function GetTextForRegExpMatch(pPattern, pString)

    '----------------------------------
    ' ���K�\���I�u�W�F�N�g���쐬       
    '----------------------------------
    Dim mRegExp : Set mRegExp = New RegExp
    mRegExp.Pattern    = pPattern '���K�\���̃p�^�[����ݒ�
    mRegExp.IgnoreCase = True     '�啶���E����������ʂ��Ȃ��悤�ɐݒ�
    mRegExp.Global     = True     '�������S�̂���������悤�ɐݒ�
    
    '----------------------------------
    ' ���K�\�������v���镶������擾 
    '----------------------------------
    '������̌��������s
    Dim mMtchesText : Set mMtchesText = mRegExp.Execute(pString)
    
    Dim mReturnString, mMatchText
    
    'mMtchesText�iMatches�R���N�V�����j���J��Ԃ�
    For Each mMatchText in mMtchesText
    
        mReturnString = mReturnString & mMatchText.Value
    
    Next
    
    '----------------------------------
    ' �쐬�����I�u�W�F�N�g��j��
    '----------------------------------
    Set mRegExp     = Nothing
    Set mMtchesText = Nothing
    
    '�Ԃ�l��ݒ�
    GetTextForRegExpMatch = mReturnString
    
End Function