'**************************************************************************************
'* �v���O������ �F EXE�����I���X�N���v�g                                              *
'* �����T�v     �F �I��������EXE�������[�U�[�ɓ��͂����A���͂���EXE���Ɉ�v����EXE��  *
'*                 �����I�����܂�                                                     *
'* ����         �F                                                                    *
'* �ݒ�         �F                                                                    *
'**************************************************************************************

'���b�Z�[�W�{�b�N�X�E�C���v�b�g�{�b�N�X�Ŏg�p���镶��
Dim MsgInputBoxTitle   : MsgInputBoxTitle   = "EXE�����I���X�N���v�g"
Dim MsgInputExeName    : MsgInputExeName    = "�I��������EXE������͂��Ă��������B" & VbCrLf & VbCrLf & "���^�X�N�}�l�[�W���[�ɕ\������Ă���EXE������͂��ĉ�����"
Dim MsgNotExistsExe    : MsgNotExistsExe    = "���͂��ꂽEXE���̃v���O�������N�����Ă��܂���B" & VbCrLf & "�X�N���v�g���I�����܂��B"
Dim MsgIsRunEndProcess : MsgIsRunEndProcess = "���I�����܂��B" & VbCrLf & "��낵���ł����H"
Dim MsgRanEndProcess   : MsgRanEndProcess   = "�������I�����܂����B"

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '*********************************
    '* �I������Exe�����擾           *
    '*********************************
    '���[�U�[�ɑΘb���I������Exe�����擾
    Dim mExeName : mExeName = InputBox(MsgInputExeName, MsgInputBoxTitle)
    
    '�擾����Exe���Ɂu.exe�v���܂܂�ĂȂ�������A�����Ɂu.exe�v��ǉ�
    If InStr(mExeName, ".exe") <= 0 then mExeName = mExeName & ".exe"

    '*********************************
    '* ���͂��ꂽEXE���̑��݃`�F�b�N *
    '*********************************
    '���͂��ꂽEXE�����݂��邩�ǂ����擾
    Dim mIsRunExe : mIsRunExe = IsRunProgram(mExeName)
    
    '���͂��ꂽEXE�����݂��Ȃ���
    If mIsRunExe = False Then
    
        '�uEXE�����݂��܂���v���b�Z�[�W��\�����X�N���v�g���I��
        MsgBox MsgNotExistsExe, vbOkOnly, MsgInputBoxTitle
        Wscript.Quit()
    
    End If

    '*********************************
    '* EXE�̏I���������s�����m�F     *
    '*********************************
    'EXE�̏I���������s�������[�U�[�ɑΘb
    Dim mIsRunEndProcess : mIsRunEndProcess = MsgBox("�u" & mExeName & "�v" & MsgIsRunEndProcess, vbOKCancel, MsgInputBoxTitle)
    
    '�L�����Z���������ꂽ���͏������I��
    If mIsRunEndProcess = vbCancel Then Wscript.Quit()

    '*********************************
    '* Exe�̏I������                 *
    '*********************************
    For Each Process in GetObject("winmgmts:{impersonationLevel=impersonate}").ExecQuery("select * from Win32_Process where Name='" & mExeName & "'")

        '�v���O�����̋����I������
        Process.terminate
        
        '�u�v���O�������v�������I�����܂������b�Z�[�W��\��
        MsgBox "�u" & mExeName & "�v" & MsgRanEndProcess, vbOkOnly, MsgInputBoxTitle

    Next

End Sub

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