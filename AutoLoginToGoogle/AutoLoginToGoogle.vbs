'**************************************************************************************
'* �v���O������ �F Google�A�J�E���g�������O�C���X�N���v�g                             *
'* �����T�v     �F InternetExplorer���g���AGoogle�A�J�E���g�Ɏ������O�C�����s���܂�   *
'*                   �@IE���N��                                                       *
'*                   �AGoogle�A�J�E���g�����O�A�E�g                                   *
'*                       ��Google�Ƀ��O�C�����Ă����ꍇ�̓��O�A�E�g���܂�             *
'*                   �BGoogle�A�J�E���g�Ƀ��O�C��                                     *
'*                   �C���O�C�����s����                                               *
'*                       �����O�C���Ɏ��s�������̓��b�Z�[�W��\�������������I�����܂� *
'*                   �D�Ώۂ�URL�ɑJ��                                                *
'* ����         �F ��2017/08/25���݂̎d�l�ō쐬                                       *
'*                 �N������IE���������ꍇ�A�A�N�e�B�u�^�u�ŏ������s���A���݊J����   *
'*                 ����y�[�W��񂪎����Ă��܂��B�Ή���Ƃ��ăA�N�e�B�u�^�u��V��   *
'*                 ���^�u�ŊJ�������A���X�̃A�N�e�B�u�^�u��Google�̎������O�C������   *
'*                 ���s��                                                             *
'* �ݒ�         �F Google�A�J�E���g�̃��[���A�h���X�ƃp�X���[�h�̏���ݒ肷�邱��   *
'*                 ���ݒ�����Ȃ��Ɛ����������܂���I�I                               *
'**************************************************************************************
Option Explicit

'*****************************************
'* �萔                                  *
'*****************************************
'URL
Dim GoogleTopURL     : GoogleTopURL     = "https://www.google.co.jp/"
Dim LoginURL         : LoginURL         = "https://www.google.com/accounts/Login?hl=ja&continue=http://www.google.co.jp/"
Dim TransferURL      : TransferURL      = "https://drive.google.com/drive/my-drive"                                       '���O�C����̕\���y�[�W��Google�h���C�u

'Google�A�J�E���g���
'��Google�̃A�J�E���g����ݒ肷�邱�ƁB�ݒ肵�Ȃ��Ɠ����܂���B
Dim LoginMailAddress          : LoginMailAddress          = "Google�A�J�E���g���[���A�h���X ��Fsample@sanmple.co.jp "
Dim LoginPassword             : LoginPassword             = "Google�A�J�E���g�̃p�X���[�h   ��FPassW0rd             "

'�p�X���[�h�̓��̓o�[�W����
'��������ύX����ꍇ��LoginPassword�ϐ��̏�������L�Ɠ���ւ��邱��
'Dim InputLoginPasswordTitle   : InputLoginPasswordTitle   = "Google�A�J�E���g���O�C���p�X���[�h����"
'Dim InputLoginPasswordMessage : InputLoginPasswordMessage = "Google�A�J�E���g�̃��O�C���p�X���[�h����͂��Ă�������"
'Dim LoginPassword             : LoginPassword             = InputBox(InputLoginPasswordMessage, InputLoginPasswordTitle)

'���b�Z�[�W�{�b�N�X
Dim MsgBoxTitle               : MsgBoxTitle               = "Google�������O�C��"
Dim MsgBoxTransferContent     : MsgBoxTransferContent     = "Google�h���C�u�Ɉړ����܂�" & vbCrLf & "��낵���ł����H"
Dim MsgBoxLoginFailureContent : MsgBoxLoginFailureContent = "�p�X���[�h���Ⴂ�܂��I�I" & VbCrLf & "�������I�����܂�..."

'���O�C�������\���敪 True:������\���AFalse:������\�����Ȃ�
'���f�t�H���g�͏�����\������
Dim RunningVisible   : RunningVisible   = True

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '*****************************************
    '* IE�N������                            *
    '*****************************************
    '�N������IE���擾
    Dim mObjIE : Set mObjIE = GetRunningIEObject()
    
    'IE�����ɋN�������̃t���O
    Dim mIsRunningIE : mIsRunningIE = True
    
    '�N������IE�����݂��Ȃ�������
    If mObjIE Is Nothing Then 
    
        Set mObjIE = WScript.CreateObject("InternetExplorer.Application") 'IE�I�u�W�F�N�g���쐬����
        mIsRunningIE = False                                              '�N�����t���O��OFF
        mObjIE.Visible = RunningVisible
        
    End If
    
    'IE���N�����������猻�݂̃^�u��V�����^�u�ŊJ��
    If mIsRunningIE = True Then TransferPage mObjIE, mObjIE.LocationURL, "1"
    
    '*****************************************
    '* Google�A�J�E���g���O�A�E�g����        *
    '*****************************************
    'Google��Top�y�[�W�֑J��
    TransferPage mObjIE, GoogleTopURL, "0"
    
    '�y�[�W���Ɂu���O�A�E�g�v�Ƃ�����������܂񂾁ua�v�^�O�����鎞
    '�����O�A�E�g�{�^�������݂�����
    If IsExistTag(mObjIE, "tag", "a", "���O�A�E�g") = True Then
    
        '���O�A�E�g�{�^���̃N���b�N���������s
        Dim mLogOutButton : Set mLogOutButton = mObjIE.Document.getElementById("gb_71")
        mLogOutButton.click()  
        WaitIe mObjIE, 1000   '�y�[�W���ǂݍ��ݏI���܂ő҂�
        
    End If
    
    '*****************************************
    '* Google�A�J�E���g���O�C������          *
    '*****************************************
    'Google�̃��O�C���y�[�W�֑J��
    TransferPage mObjIE, LoginURL, "0"
    
    '�y�[�W���Ɂu�ʂ̃A�J�E���g���g�p�v�Ƃ�����������܂񂾁up�v�^�O�����鎞
    '���A�J�E���g�������̎��ŃA�J�E���g�I����ʂ̎��̏���
    If IsExistTag(mObjIE, "tag", "p", "�ʂ̃A�J�E���g���g�p") = True Then
    
        '�ʂ̃A�J�E���g���g�p�̃N���b�N����
        Dim mOtherAccount : Set mOtherAccount = mObjIE.Document.getElementById("identifierLink")
        mOtherAccount.click()
        WaitIe mObjIE, 1000 '�y�[�W���ǂݍ��ݏI���܂ő҂�
        
    End If
    
    '���O�C�����[�U�[��ݒ�i���[���A�h���X�̐ݒ�j
    Dim mLoginUser : Set mLoginUser = mObjIE.Document.getElementsByName("identifier")(0)
    mLoginUser.Value = LoginMailAddress
    
    '�y�[�W���Ɂu���ցv�Ƃ�����������܂񂾁uRveJvd snByac�vClass�����^�O�����鎞
    '��Google�A�J�E���g�������Ă��Ȃ����̏���
    If IsExistTag(mObjIE, "class", "RveJvd snByac", "����") = True Then
    
        '���փ{�^���̃N���b�N����
        Dim mNextButton : Set mNextButton = mObjIE.Document.getElementsByClassName("ZFr60d CeoRYc")(0)
        mNextButton.click()
    
        '�y�[�W���؂�ւ��܂ŌJ��Ԃ�
        Dim mIsPageChange : mIsPageChange = False '�y�[�W�؂�ւ��t���O
        While mIsPageChange = False
        
            '�y�[�W���Ɂu�p�X���[�h����́v�Ƃ�����������܂񂾁uAxOyFc snByac�vClass�����^�O�����鎞
            '���p�X���[�h�^�O�����݂�����y�[�W���؂�ւ�������ƂƂ���
            If IsExistTag(mObjIE, "class", "AxOyFc snByac", "�p�X���[�h�����") = True Then
            
                mIsPageChange = True
                
            End If
            
            WScript.Sleep(1000)  '�P�b�҂�
            
        Wend
        
    End If
    
    '���O�C���p�X���[�h��ݒ�
    Dim mLoginPassword : Set mLoginPassword = mObjIE.Document.getElementsByName("password")(0)
    mLoginPassword.Value = LoginPassword
    
    '���O�C���{�^���̃N���b�N����
    Dim mSignInButton : Set mSignInButton = mObjIE.Document.getElementsByClassName("ZFr60d CeoRYc")(0)
    mSignInButton.click() 
    WaitIe mObjIE, 1000  '�y�[�W���ǂݍ��ݏI���܂ő҂�
    
    'IE���N�����ł͂Ȃ������O�C�������\���敪��False�̎��AIE������
    If mIsRunningIE = False And RunningVisible = False Then mObjIE.Visible = True

    '*****************************************
    '* ���O�C�����s������                    *
    '*****************************************
    '�y�[�W���Ɂu�p�X���[�h������������܂���B������x���������������B�v�Ƃ�����������܂񂾁udEOOab RxsGPe�vClass�����^�O�����鎞
    If IsExistTag(mObjIE, "class", "dEOOab RxsGPe", "�p�X���[�h������������܂���B������x���������������B") = True Then
    
        '���b�Z�[�W��\�����ď������I��
        MsgBox MsgBoxLoginFailureContent , vbOKOnly, MsgBoxTitle
        Wscript.Quit()
        
    End If

    '*****************************************
    '* �Ώ�URL�ւ̑J�ڏ���                   *
    '*****************************************
    '�Ώ�URL�֑J�ڂ��邩���[�U�[�ɑΘb
    Dim mMsgResult : mMsgResult = MsgBox(MsgBoxTransferContent, vbOKCancel, MsgBoxTitle)
    
    '�L�����Z���������ꂽ���͏������I��
    If mMsgResult = vbCancel Then Wscript.Quit()
    
    '�Ώ�URL�֑J��
    TransferPage mObjIE, TransferURL, "0"

End Sub

'***********************************************************************
'* ������   �F �y�[�W�J�ڏ���                                          *
'* ����     �F pObjIE       IE�I�u�W�F�N�g                             *
'*             pTransferURL �J�ڐ�URL                                  *
'*             pNewTabKbn   �V�����^�u�ŊJ�����̋敪                   *
'*               0  ���݂̃^�u�ŊJ��                                   *
'*               1  �V�����^�u�ŊJ��                                   *
'* �������e �F �y�[�W�J�ڏ������s���A�I������܂őҋ@                  *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub TransferPage(pObjIE, pTransferURL, pNewTabKbn)
    
    '�y�[�W�̑J�ڏ����i�V�����^�u�ŊJ�����̋敪�ɂ�菈���𕪊�j
      Select Case pNewTabKbn
      
        Case "0"   '���݂̃^�u�ŊJ��
        
              pObjIE.Navigate(pTransferURL)
              
        Case "1"   '�V�����^�u�ŊJ��
        
              pObjIE.Navigate2 pTransferURL, 2048
              
          Case Else   '�ǂ�ɂ����Ă͂܂�Ȃ��i���݂̃^�u�ŊJ���Ɠ����Ƃ���j
              
              pObjIE.Navigate(pTransferURL)
              
      End Select
    
    '�y�[�W���ǂݍ��ݏI���܂ő҂�
    WaitIe pObjIE, 1000  
    
End Sub

'***********************************************************************
'* ������   �F IE�ҋ@                                                  *
'* ����     �F pObjIE     IE�I�u�W�F�N�g                               *
'*             pWaitTime  �ҋ@����                                     *
'*               �ڈ��A1000��1�b�ł�                                   *
'* �������e �F IE�I�u�W�F�N�g���N�����܂��̓y�[�W���Ǎ����̏ꍇ�͑ҋ@  *
'*             ���ԕ��҂������J��Ԃ��BIE�I�u�W�F�N�g���N�����y�[�W  *
'*             �̓ǂݍ��ݒ��Ŗ����Ȃ����珈�����I��                    *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub WaitIe(pObjIE, pWaitTime)

    '1�b�ҋ@
    WScript.Sleep(1000)

    '�uIE���N�����I���v���u�y�[�W���ǂݍ��ݏI���v�܂ŌJ��Ԃ�
    While pObjIE.ReadyState <> 4 Or pObjIE.Busy = True
    
        WScript.Sleep(pWaitTime) '�ҋ@���ԕ��҂�
        
    Wend
    
End Sub

'***********************************************************************
'* ������   �F �N����IE�I�u�W�F�N�g�擾                                *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���݋N�����̃E�C���h�E���擾���AIE���N�����Ȃ炻�̃I�u  *
'*             �W�F�N�g��Ԃ��A�N�����łȂ�������Nothing��Ԃ�         *
'* �߂�l   �F IE�I�u�W�F�N�g / Nothing                                *
'***********************************************************************
Function GetRunningIEObject()

    Dim mObjShell : Set mObjShell = CreateObject("Shell.Application")
    Dim mObjFso   : Set mObjFso   = CreateObject("Scripting.FileSystemObject")
    Dim mObjWindow

    '�߂�l�ɏ����l��ݒ�
    Set GetRunningIEObject = Nothing

    '�N�����̃E�C���h�E�����J��Ԃ�
    For Each mObjWindow In mObjShell.Windows

        '�E�C���h�E��FullName���������ɕϊ����������񂪁uiexplore.exe�v�̎�
        '���E�C���h�E��IE�̎�
        If LCase(mObjFso.GetFileName(mObjWindow.FullName)) = "iexplore.exe" Then

            'IE�I�u�W�F�N�g��߂�l�ɃZ�b�g
            Set GetRunningIEObject = mObjWindow
            Exit For

        End If

    Next

    Set mObjShell = Nothing
    Set mObjFso   = Nothing
    
End Function

'***********************************************************************
'* ������   �F �^�O�̑��݃`�F�b�N                                      *
'* ����     �F pObjIE       IE�I�u�W�F�N�g                             *
'*             pMethodType  �^�O�̌�������^�C�v                       *
'*               ��name,class,tag�̂����ꂩ                            *
'*             pElementName �^�O���������镶����                       *
'*             pKeywords    �^�O�����猟�����镶����                   *
'* �������e �F �\�����̃y�[�W����u��������^�C�v�v�A�u�������镶����v*
'*             ���g���Ď擾�o�����^�O�̂����u�^�O�����猟�����镶����v*
'*             ���܂ރ^�O�����邩�`�F�b�N����                          *
'*             ���������e���Ӗ��s���ɂȂ��Ă��܂����i���j              *
'* �߂�l   �F True:���݂��� / False:���݂��Ȃ�                        *
'***********************************************************************
Function IsExistTag(pObjIE, pMethodType, pElementName, pKeywords)

    Dim mObjDoc, mMyDoc
  
    '�߂�l�ɏ����l���Z�b�g
    IsExistTag = False

    '�^�O�̌�������^�C�v�ɂ��I�u�W�F�N�g�̍쐬���@��ς���
      Select Case pMethodType
      
        Case "name"
        
              Set mObjDoc = pObjIE.document.getElementsByName(pElementName)
              
        Case "class"
        
              Set mObjDoc = pObjIE.document.getElementsByClassName(pElementName)
              
        Case "tag"
        
              Set mObjDoc = pObjIE.document.getElementsByTagName(pElementName)
              
      End Select

    '���������I�u�W�F�N�g�����J��Ԃ�
    For Each mMyDoc In mObjDoc
    
        '�I�u�W�F�N�g���Ɂu�^�O�����猟�����镶����v����������
        If InStr(mMyDoc.outerHTML, pKeywords) > 0 Then
        
            IsExistTag = True
            Exit For
            
        End If
        
    Next
    
End Function