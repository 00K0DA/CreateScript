@Echo off
Rem ***************************************************************
Rem * �o�b�`���F�V���{���b�N�@�����N�쐬�o�b�`
Rem * �������e�F�V���{���b�N�@�����N�쐬���������[�U�[�ɓ��͂����V
Rem *           ���{���b�N�@�����N���쐬���܂�
Rem ***************************************************************

Rem --------------------------- �ݒ� --------------------------- 
Rem ���O�t�@�C���̕ۑ��ꏊ
Set LogFileFullPath=%~dp0\CreateSymbolicLink.log

Rem ---------------------- ���C���������� ---------------------- 
Rem �^�C�g���\������
Call :DisplayTitle

Rem �ݒ�̓���
Call :InputSettings

Rem �쐬�����N�̎�ނ��R�}���h�ϊ�����
Call :ConvertCreateLinkTypeToCommand

Rem �o�b�`�t�@�C�����s�������쐬����
Call :CreateRunDateAndTime

Rem �����𑱍s���邩���[�U�[�ɑΘb
Call :IsRun

Rem �V���{���b�N�����N�쐬�����̎��s
Call :CreateSymbolicLink

Rem �I������
Call :EndProcess 1

Rem ---------------------- ���x���������� ---------------------- 

Rem ***************************************************************
Rem * �� �� ���F�^�C�g���̕\��
Rem * ��    ���F�Ȃ�
Rem * �������e�F�V���{���b�N�@�����N�쐬�o�b�`�̃^�C�g����\������
Rem *           �p�����[�^�����ꏏ�ɕ\��������
Rem ***************************************************************
:DisplayTitle

    Call :DisplayNewLine
    Call :DisplayMessage "*********************************************************               " 0 0
    Call :DisplayMessage "  �o�b�`���F�V���{���b�N�@�����N�쐬�o�b�`                              " 0 0
    Call :DisplayMessage "  �����T�v�F�@�쐬�����N�̎�ނ̎w��                                    " 0 0
    Call :DisplayMessage "            �A�����N�̎w��                                              " 0 0
    Call :DisplayMessage "            �B�^�[�Q�b�g�̎w��                                          " 0 0
    Call :DisplayMessage "            �C�V���{���b�N�@�����N�쐬����                              " 0 0
    Call :DisplayMessage "*********************************************************               " 0 0
    Call :DisplayNewLine
    Call :DisplayMessage "  MKLINK [ [/D] [/H] [/J] ] �����N �^�[�Q�b�g                           " 0 0
    Call :DisplayNewLine
    Call :DisplayMessage "          /D�F�f�B���N�g���̃V���{���b�N�@�����N���쐬���܂��B          " 0 0
    Call :DisplayMessage "              ����ł́A�t�@�C���̃V���{���b�N�@�����N���쐬����܂��B  " 0 0
    Call :DisplayMessage "          /H�F�V���{���b�N�@�����N�ł͂Ȃ��A�n�[�h�@�����N���쐬���܂��B" 0 0
    Call :DisplayMessage "          /J�F�f�B���N�g���@�W�����N�V�������쐬���܂��B                " 0 0
    Call :DisplayMessage "      �����N�F�V�����V���{���b�N�@�����N�����w�肵�܂��B                " 0 0
    Call :DisplayMessage "  �^�[�Q�b�g�F�V���������N���Q�Ƃ���p�X�i���΂܂��͐�΁j���w�肵�܂��B" 0 0
    
    Exit /b
    
Rem ***************************************************************
Rem * �� �� ���F�ݒ�̓���
Rem * ��    ���F�Ȃ�
Rem * �������e�F�쐬�����N�̎�ށA�����N�A�^�[�Q�b�g�̎w������[�U�[
Rem *           �ɑΘb�����͂�����B���͓��e���s���̏ꍇ�͍ēx�A����
Rem *           ������
Rem ***************************************************************
:InputSettings

    Call :DisplayMessage "���ݒ�̓��͂��s���܂��D�D�D" 1 0

    Rem �쐬�����N�̎�ނ��w��
    Call :InputCreateLinkType
    
    Rem �����N���w��
    Call :InputLink
    
    Rem �^�[�Q�b�g���w��
    Call :InputTarget
    
    Exit /b
    
    Rem �쐬�����N�̎�ނ̎w��
    :InputCreateLinkType
    
        Rem ���[�U�[�ɍ쐬�����N�̓��͂�Θb
        Call :DisplayMessage "�@�쐬�����N�̎�ނ̎w����s���܂��B�i1�F/D�A2�F/H�A3�F/J�j" 1 0
        Set /p CreateLinkType="�쐬�����N�̎�ނ̓��́@���@"
       
        Rem ���͂��ꂽ�����N�̎�ނ��󕶎��̎�
        If "%CreateLinkType%" Equ "" (
            Call :DisplayMessage "�G���[�F�쐬�����N�̎�ނ̎w�肪����������܂���u1�v�A�u2�v�A�u3�v�œ��͂��ĉ������B" 1 0
            Call :InputCreateLinkType
        ) 
       
        Rem ���͂��ꂽ�쐬�����N�̎�ނ��u1,2,3�v�ȊO�̎��͂����P�x���͂�����
        If %CreateLinkType% Equ 1 (
            Exit /b
        ) Else If %CreateLinkType% Equ 2 (
            Exit /b
        ) Else If %CreateLinkType% Equ 3 (
            Exit /b
        ) Else (
            Call :DisplayMessage "�G���[�F�쐬�����N�̎�ނ̎w�肪����������܂���u1�v�A�u2�v�A�u3�v�œ��͂��ĉ������B" 1 0
            Call :InputCreateLinkType
        )
        
        Exit /b
        
    Rem �����N���w��
    :InputLink
    
        Rem ���[�U�[�Ƀ����N�̓��͂�Θb
        Call :DisplayMessage "�A�����N�̎w����s���܂��B" 1 0
        Set /p Link="�����N�̓��́@���@"

        If "%Link%" Equ "" (
            Call :DisplayMessage "�G���[�F�����N�̎w�肪����܂���B" 1 0
            Call :InputLink
        )
                
        Exit /b

    Rem �^�[�Q�b�g���w��
    :InputTarget

        Rem ���[�U�[�Ƀ^�[�Q�b�g�̓��͂�Θb
        Call :DisplayMessage "�B�^�[�Q�b�g�̎w����s���܂��B" 1 0
        Set /p Target="�^�[�Q�b�g�̓��́@���@"
    
        if "%Target%" Equ "" (
            Call :DisplayMessage "�G���[�F�^�[�Q�b�g�̎w�肪����܂���B" 1 0
            Call :InputTarget
        ) 
    
        Exit /b

Rem ***************************************************************
Rem * �� �� ���F�쐬�����N�̎�ނ��R�}���h�ɕϊ�
Rem * ��    ���F�Ȃ�
Rem * �������e�F���͂��ꂽ�쐬�����N�̎�ށi1,2,3�j�����ۂɃR�}���h
Rem *           �ɕϊ�����
Rem ***************************************************************
:ConvertCreateLinkTypeToCommand

    If %CreateLinkType% Equ 1 (
        Set CreateLinkType=/D
    ) Else If %CreateLinkType% Equ 2 (
        Set CreateLinkType=/H
    ) Else If %CreateLinkType% Equ 3 (
        Set CreateLinkType=/J
    )

    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���������s���邩���[�U�[�ɑΘb
Rem * ��    ���F�Ȃ�
Rem * �������e�F���[�U�[�̓��͓��e��\�����A���������s���邩���[
Rem *           �U�[�ɑΘb�����s���Ȃ��ꍇ�͐ݒ�̓��͂��ēx�s��
Rem ***************************************************************
:IsRun

    Rem ���[�U�[�̓��͓��e��\��
    Call :DisplayNewLine
    Call :DisplayMessage "********************************************************" 0 0
    Call :DisplayMessage "�쐬�����N�̎�ށF%CreateLinkType%                      " 0 0
    Call :DisplayMessage "          �����N�F%Link%                                " 0 0
    Call :DisplayMessage "      �^�[�Q�b�g�F%Target%                              " 0 0
    Call :DisplayMessage "        ���s�����F%RunDateAndTime%                      " 0 0
    Call :DisplayMessage "********************************************************" 0 0
    Call :DisplayNewLine
    
    Rem �����𑱍s���邩���[�U�[�ɑΘb
    Rem ����Enter����Ɨ����邽�߁A�\�ߓK���Ȓl���Z�b�g���Ă���
    Call :DisplayMessage "�����L���b�Z�[�W��(�uY�v���́uy�v)�ȊO�͏������I�����܂��D�D�D" 0 0
    Set RunContinueResult=KaraMojiTaiou
    Set /p RunContinueResult="��L�����g�p���ď��������s���܂����H(y/n)�@���@"

    Rem �啶��/�������ϊ�(Y�ȊO�͑S�ăL�����Z������) 
    Set RunContinueResult=%RunContinueResult:y=Y%%
    
    Rem Y�ȊO�̓��͂̎��͏������I��
    If /i Not %RunContinueResult%==Y Call :EndProcess 0

    Exit /b


Rem ***************************************************************
Rem * �� �� ���F�V���{���b�N�@�����N�̍쐬����
Rem * ��    ���F�Ȃ�
Rem * �������e�F���͂��ꂽ�ݒ���g�p���uMKLINK�v�R�}���h�����s����
Rem ***************************************************************
:CreateSymbolicLink

    Rem ���s�R�}���h��\��������
    Call :DisplayMessage "�����ۂɎ��s�����R�}���h�͈ȉ��ɂȂ�܂� " 1 0
    Call :DisplayMessage " �� mklink %CreateLinkType% %Link% %Target%" 0 1
    Pause

    Rem ���O�t�@�C���֌��ʂ���������
    Call :WriteLog "�����s����"
    Call :WriteLog "%RunDateAndTime%"
    Call :WriteLog "�����s�R�}���h��"
    Call :WriteLog "mklink %CreateLinkType% %Link% %Target%"
    Call :WriteLog "�����s���ʁ�"

    Rem �umklink�v�R�}���h�����s �����O�t�@�C���֎��s�̌��ʂ���������
    Call :DisplayNewLine
    mklink %CreateLinkType% %Link% %Target% >> %LogFileFullPath%
    
    Rem ���s�����O�t�@�C���֏�������
    Call :WriteLog ";"
    Call :WriteLog ";"
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�o�b�`�t�@�C���̎��s�������쐬
Rem * ��    ���F�Ȃ�
Rem * �������e�F���s�̓������쐬����
Rem *           ���s�����̌`���́u9999/99/99 HH:mm:ss�v�ɂȂ�܂�
Rem ***************************************************************
:CreateRunDateAndTime

    Rem ���ݓ��t�̍쐬
    Set Date=%date:~-10,4%/%date:~-5,2%/%date:~-2,2%

    Rem ���ݎ��Ԃ̍쐬
    Set Time=%time: =0%
    Set Time=%time:~0,2%:%time:~3,2%:%time:~6,2%

    Rem ���ݓ��t�ƌ��ݎ��Ԃ��Ȃ���
    Set RunDateAndTime=%Date% %Time%
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���b�Z�[�W�̕\��
Rem * ��    ���F1 �\�������郁�b�Z�[�W
Rem *           2 �\�������郁�b�Z�[�W�O�ɉ��s���܂߂邩�ǂ����i1�͊܂߂�A����ȊO�͊܂߂Ȃ��j
Rem *           3 �\�������郁�b�Z�[�W��ɉ��s���܂߂邩�ǂ����i1�͊܂߂�A����ȊO�͊܂߂Ȃ��j
Rem * �������e�F�\�������郁�b�Z�[�W�̑O��ɉ��s���܂߂ĕ\�����邩
Rem *           �ǂ����������ɉ����čs��
Rem *           �g�p���@
Rem *             Call :DisplayMessage "�������� aaaaa bbbbb" 1 1
Rem *             �������͕K��3�n������
Rem *               �\�����郁�b�Z�[�W�͕K���_�u���N�H�[�e�[�V�����ň͂ނ���
Rem ***************************************************************
:DisplayMessage

    Rem ���b�Z�[�W�O�ɉ��s���܂߂�
    If %~2 Equ 1 (
        Call :DisplayNewLine
    ) 

    Rem �_�E�u���N�H�[�e�[�V�������폜���ĕ\��
    Echo %~1

    Rem ���b�Z�[�W��ɉ��s���܂߂�
    If %~3 Equ 1 (
        Call :DisplayNewLine
    )
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���s���b�Z�[�W�̕\��
Rem * ��    ���F�Ȃ�
Rem * �������e�F�R�}���h�v�����v�g�ɉ��s��\��������
Rem ***************************************************************
:DisplayNewLine

    Rem ���s��\��
    Echo;
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���O�t�@�C���֏�������
Rem * ��    ���F1 ���O�t�@�C���֏������ޓ��e
Rem * �������e�F���O�t�@�C���փ��O����������
Rem             ���O�t�@�C���֏������ޓ��e���u;�v�̎��͉��s����������
Rem *           �g�p���@
Rem *             Call :WriteLog "�������� aaaaa bbbbb"
Rem *             Call :WriteLog ";" ���s����������
Rem *             �������͕K���n������
Rem *               ���O�t�@�C���֏������ޓ��e�͕K���_�u���N�H�[�e�[�V�����ň͂ނ���
Rem ***************************************************************
:WriteLog

    Rem �������u;�v�̎�
    If "%~1"==";" (
    
        Rem ���s�����O�t�@�C���֏�������
        Echo; >> %LogFileFullPath%
        
    ) Else (
    
        Rem �_�E�u���N�H�[�e�[�V�������폜���ă��O�t�@�C���֏�������
        Echo %~1 >> %LogFileFullPath%
    
    )

    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�I������
Rem * ��    ���F1 ���O�t�@�C����\�����邩�i1�͕\���A����ȊO�͔�\���j
Rem * �������e�F�o�b�`�������I��������
Rem *           ������1�̎��̓��O�t�@�C�������s���ă��[�U�[�Ƀ��O
Rem *           �t�@�C���̓��e��\������
Rem ***************************************************************
:EndProcess

    Rem 1�ڂ̈������u1�v�̎�
    If %~1 Equ 1 (
    
        Rem �����̏I���m�F
        Call :DisplayMessage "�����O�t�@�C�������s���ď������I�����܂��D�D�D" 0 1
        Pause

        Rem ���O�t�@�C���̎��s����
        Start %LogFileFullPath%
        
    ) 

    Rem �����̏I��
    Exit
    