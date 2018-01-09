'**************************************************************************************
'* �v���O������ �F url�t�@�C���쐬�X�N���v�g                                          *
'* �����T�v     �F �t�@�C�����ƑΏ�URL����͂��āu�t�@�C����.url�v�t�@�C���쐬����    *
'* ����         �F                                                                    *
'* �ݒ�         �F                                                                    *
'**************************************************************************************

Option Explicit

'*****************************************
'* �萔                                  *
'*****************************************
'InputBox�ɕ\�����镶����ݒ�
Dim mTitle           : mTitle           = "URL�t�@�C���̍쐬"
Dim mFileNameMessage : mFileNameMessage = "�t�@�C��������͂��Ă��������B" & VbCrLf & VbCrLf & "���t�@�C�����́u������.url�v�������̕������w�肵�Ă��������B�t�@�C���̓f�X�N�g�b�v�ɍ쐬����܂��B"
Dim mURLMessage      : mURLMessage      = "URL����͂��Ă��������B"

'���͓��e���������Ȃ����ɕ\�����郁�b�Z�[�W
Dim mIncorrectFileNameError : mIncorrectFileNameError = "�t�@�C�����������͂܂��̓t�@�C�����Ƃ��Đ���������܂���" & VbCrLf & VbCrLf & "�������I�����܂�..."
Dim mIncorrectURLError : mIncorrectURLError = "URL�������͂܂���URL�Ƃ��Đ���������܂���" & VbCrLf & VbCrLf & "�������I�����܂�..."

'*****************************************
'* �ϐ�                                  *
'*****************************************
Dim mObjShell    : Set mObjShell  = WScript.CreateObject("WScript.Shell")        
Dim mFileInfo    : Set mFileInfo  = WScript.CreateObject("Scripting.Dictionary")

'�t�@�C���̏o�͐�p�X���擾
Dim mDesktopPath : mDesktopPath = mObjShell.SpecialFolders("Desktop") & "\"    

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '*****************************************
    '* �t�@�C�����擾                        *
    '*****************************************
    '���[�U�[�ɑΘb���t�@�C�������擾
    Dim mFileName : mFileName = InputBox(mFileNameMessage, mTitle)
    
    '*****************************************
    '* �t�@�C�������̓`�F�b�N                *
    '* �������́��t�@�C�����Ó����`�F�b�N    *
    '*****************************************
    '�t�@�C�����Ó����`�F�b�N�pRegExp�ݒ�
    '���t�@�C�����Ɏg���Ȃ������̈ꗗ:\ / : * ? " < > |
    '  �G�X�P�[�v�����́u\�v�A��؂蕶���́u|�v�ł�
    Dim mObjFileNameRegExp : Set mObjFileNameRegExp = New RegExp
    mObjFileNameRegExp.pattern = "(\\|\/|\:|\*|\?|\""|\<|\>|\|)"
    mObjFileNameRegExp.Global  = True

    '�t�@�C�����A�Ó����`�F�b�N���ʂ��擾
    Dim mIsFileName : mIsFileName = mObjFileNameRegExp.Test(mFileName)

    '�����͂܂��̓t�@�C�������������Ȃ��ꍇ�͏������I��
    If mIsFileName = True Or mFileName = "" Then
    
        MsgBox mIncorrectFileNameError
        Wscript.Quit()
        
    End If
    
    '�t�@�C�����̖����Ɂu.url�v��ǉ�
    mFileName = mFileName & ".url"

    '*****************************************
    '* URL�擾                        *
    '*****************************************
    '���[�U�[�ɑΘb�iURL�j
    Dim mURL : mURL = InputBox(mURLMessage, mTitle)

    '*****************************************
    '* URL���̓`�F�b�N                       *
    '* �������́�URL�Ó����`�F�b�N           *
    '*****************************************
    'URL�Ó����`�F�b�N�pRegExp�ݒ�
    Dim mObjURLRegExp : Set mObjURLRegExp = New RegExp
    mObjURLRegExp.pattern = "^(https*|ftp)://[-_!~';:@&=,%#/a-zA-Z0-9\$\*\+\?\.\(\)]+$"
    mObjFileNameRegExp.Global  = True

    'URL�Ó����`�F�b�N���ʂ��擾
    Dim mIsUrl : mIsUrl = mObjURLRegExp.Test(mURL)

    '�����͂܂���URL���������Ȃ��ꍇ�͏������I��
    If mIsUrl = False Or mURL = "" Then
    
        MsgBox mIncorrectURLError
        Wscript.Quit()
        
    End If

    '*****************************************
    '* �V���[�g�J�b�g�쐬����                *
    '*****************************************
    '�t�@�C������ݒ�('�L�[�F�t�@�C�����A�쐬���F�t�@�C���p�X|�o�͐�t�H���_)
                  '�t�@�C����  '�V���[�g�J�b�g��        '�t�@�C���̏o�͐�
    mFileInfo.Add mFileName ,  mURL              & "|" & mDesktopPath 
    
    '�V���[�g�J�b�g�쐬����
    Dim key
    For Each key In mFileInfo.Keys

        '�쐬����؂蕪����i�@�V���[�g�J�b�g�p�X�A�A�o�̓t�H���_�j
        Dim mAryFileInfo : mAryFileInfo = Split(mFileInfo(key),"|")
    
        'url�t�@�C���̃t�@�C��������V���[�g�J�b�g���쐬����f�B���N�g�����擾
        Dim FileName : FileName = key
        Dim Path     : Path     = mAryFileInfo(1) & FileName
    
        '�쐬��f�B���N�g���̃t�H���_�����������ꍇ�̓t�H���_���쐬����
        CreateNotExistFolder(Path)
    
        '�V���[�g�J�b�g�I�u�W�F�N�g���쐬���o�͐�p�X�A�R�}���h���C������
        Dim mShortCut : Set mShortCut = mObjShell.CreateShortcut(Path) '�V���[�g�J�b�g�I�u�W�F�N�g���쐬
        mShortCut.TargetPath = mAryFileInfo(0)                         '�V���[�g�J�b�g��
    
        '�V���[�g�J�b�g���쐬
        mShortCut.Save
    
    Next

    '�I�u�W�F�N�g�̔j��
    Set mObjShell  = Nothing
    Set mFileInfo  = Nothing

End Sub

'***********************************************************************
'* ������   �F �t�H���_�쐬����                                        *
'* ����     �F pPath �Ώۃp�X                                          *
'* �������e �F �Ώۃp�X�ɑ��݂��Ȃ��p�X��������쐬����                *
'*             ���t�H���_�̍쐬�͍ċA�I�ɍs���܂�                      *
'*               �h���C�u �� �h���C�u\�K�w�P���h���C�u\�K�w�P\�K�w�Q\  *
'*               �� �h���C�u\�K�w�P\�K�w�Q\�Ώۃt�H���_                *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Function CreateNotExistFolder(pPath)
    
    Dim mObjFso       : Set mObjFso   = WScript.CreateObject("Scripting.FileSystemObject")
    Dim mDriveName    : mDriveName    = Left(mObjFso.GetDriveName(pPath),2)                '�h���C�u�����擾
    Dim mParentFolder : mParentFolder = mObjFso.GetParentFolderName(pPath)                 '�e�t�H���_�[�����擾
    
    '�Ώۂ̃h���C�u�����݂��鎞
    If mObjFso.DriveExists(mDriveName) Then
    
        'Drive�I�u�W�F�N�g���쐬
        Dim mObjDrive : Set mObjDrive = mObjFso.GetDrive(mDriveName) 
        
    Else
    
        Exit Function
        
    End If
    
    '�h���C�u�̏������ł��Ă��鎞
    If mObjDrive.IsReady Then
    
        '�g���q�����񂪎擾�o�����ꍇ(�t�@�C���̎�)
        If Len(mObjFso.GetExtensionName(pPath)) > 0 Then 
        
            '�e�t�H���_�[�����݂��Ȃ����A�Ώۃp�X����e�t�H���_�[�쐬����i�ċA�I�j
            If Not(mObjFso.FolderExists(mParentFolder)) Then CreateNotExistFolder(mParentFolder)
            
        Else
        
            '�Ώۃt�H���_�[�����݂��Ȃ���
            If Not(mObjFso.FolderExists(pPath)) Then
            
                '�e�t�H���_�[���쐬��A�Ώۃt�H���_�[���쐬�i�ċA�I�j
                CreateNotExistFolder(mParentFolder)
                mObjFso.CreateFolder(pPath)
                
            End If
            
        End If
        
    End If
    
    '�I�u�W�F�N�g�̔j��
    Set mObjFso   = Nothing
    Set mObjDrive = Nothing

End Function