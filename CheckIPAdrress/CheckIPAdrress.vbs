'************************************************************************************************
'* �v���O������ �F IP�A�h���X�`�F�b�N�X�N���v�g                                                 *
'* �����T�v     �F ���g��IP�A�h���X�����b�Z�[�W�{�b�N�X�ŕ\�������܂�                           *
'* ����         �F �ȉ��̃R�}���h���g�p����IP�A�h���X���擾���܂�                               *
'*                   @for /F "delims=: tokens=2" %a in ('ipconfig ^| findstr "IP"') do @echo %a *
'* �ݒ�         �F                                                                              *
'************************************************************************************************

'*****************************************
'* �ϐ�                                  *
'*****************************************
Dim mObjShell : Set mObjShell = WScript.CreateObject("WScript.Shell") 
Dim mObjExec  : Set mObjExec  = mObjShell.Exec("cmd.exe /c @for /F " & """delims=: tokens=2""" & " %a in ('ipconfig ^| findstr " & """IPv4""" & "') do @echo %a")

Main()

'***********************************************************************
'* ������   �F ���C������                                              *
'* ����     �F �Ȃ�                                                    *
'* �������e �F ���C������                                              *
'* �߂�l   �F �Ȃ�                                                    *
'***********************************************************************
Sub Main()

    '�R�}���h�v�����v�g�̌��ʍs���J��Ԃ�
    Do Until mObjExec.StdOut.AtEndOfStream

        'IP�A�h���X��ϐ��ɃZ�b�g(���p�X�y�[�X���폜����)
        Dim mIpAdress : mIpAdress = Trim(mObjExec.StdOut.ReadLine)
    
        'IP�A�h���X�����b�Z�[�W�{�b�N�X�ɕ\��
        Dim mMsgBoxResult : mMsgBoxResult = MsgBox(mIpAdress & vbCrLf & vbCrLf & "�N���b�v�{�[�h�ɃR�s�[����ꍇ�́u�͂��v�������Ă�������", vbYesNo, "IP�A�h���X�`�F�b�N")
    
        '�u�͂��v�{�^���������ꂽ��
        If mMsgBoxResult = vbYes Then
    
            '�N���b�v�{�[�h�R�s�[����
            Dim mClipBoardCopyText : mClipBoardCopyText = "cmd.exe /c ""echo " & mIpAdress & "| clip"""
            mObjShell.Run mClipBoardCopyText, 0
        
        End If
    
    Loop

End Sub

