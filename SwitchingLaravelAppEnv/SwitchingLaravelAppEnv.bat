Echo off

Rem For�����̒l��ω������邽�߂̐錾�i�x�����ϐ��j
Setlocal enabledelayedexpansion

Rem ************************************************************************
Rem * �o�b�`���FLaravel�̃A�v���P�[�V�����̊��؂�ւ�
Rem * �������e�FLaravel�̃A�v���P�[�V�����̊���؂�ւ���o�b�`�ł��B�A�v��
Rem *           �P�[�V�����t�H���_����env�t�@�C��(.env�ȊO)��I�������u.env�v
Rem *           �ɑI������env�t�@�C����u�������邱�ƂŃA�v���P�[�V�����̊�
Rem *           ��؂�ւ��܂�
Rem ************************************************************************

Rem --------------------------- �ݒ� --------------------------- 
Rem �A�v���P�[�V�����p�X
Set ApplicationPath=%UserProfile%\LaravelProjects\Fukully
Rem ���O�t�@�C����
Set ExclusionFile=.env
Rem �؂�ւ���t�@�C���p�X�i.env�̃t���p�X�j
Set SwitchDestFilePath=%ApplicationPath%\%ExclusionFile%
Rem �I�����Ɏ��s����G�f�B�^�̃p�X�iVSCode�j
Set TextEditorPath=%SystemRoot%\..\Tools\VSCode\Code.exe

Rem ---------------------- ���C���������� ---------------------- 
Rem �^�C�g���\������
Call :DisplayTitle

Rem �؂�ւ��t�@�C����I�����܂�
Call :ChooseTargetFile

Rem �؂�ւ��t�@�C����.env�t�@�C���ɕύX
Call :SwitchChangeFileToEnvFile

Rem �I������
Call :EndProcess

Rem ---------------------- ���x���������� ---------------------- 

Rem ************************************************************************
Rem * �o�b�`���FLaravel�̃A�v���P�[�V�����̊��؂�ւ�
Rem * �������e�FLaravel�̃A�v���P�[�V�����̊���؂�ւ���o�b�`�ł��B�A�v��
Rem *           �P�[�V�����t�H���_����env�t�@�C��(.env�ȊO)��I�������u.env�v
Rem *           �ɑI������env�t�@�C����u�������邱�ƂŃA�v���P�[�V�����̊�
Rem *           ��؂�ւ��܂�
Rem ************************************************************************
:DisplayTitle

    Call :DisplayNewLine
    Call :DisplayMessage " ************************************************************************  " 0 0
    Call :DisplayMessage " * �o�b�`���FLaravel�̃A�v���P�[�V�����̊��؂�ւ�                       " 0 0
    Call :DisplayMessage " * �������e�FLaravel�̃A�v���P�[�V�����̊���؂�ւ���o�b�`�ł��B�A�v�� " 0 0
    Call :DisplayMessage " *           �P�[�V�����t�H���_����env�t�@�C��(.env�ȊO)��I�������u.env�v " 0 0
    Call :DisplayMessage " *           �ɑI������env�t�@�C����u�������邱�ƂŃA�v���P�[�V�����̊� " 0 0
    Call :DisplayMessage " *           ��؂�ւ��܂�                                                " 0 0
    Call :DisplayMessage " ************************************************************************  " 0 0
    Call :DisplayNewLine
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�؂�ւ��Ώۃt�@�C���̑I��
Rem * ��    ���F�Ȃ�
Rem * �������e�FLaravel�̃A�v���P�[�V�����t�H���_���Ɋi�[����Ă���
Rem *           env�t�@�C��(.env�ȊO)��\�����؂�ւ��t�@�C�������[
Rem *           �U�[�ɑΘb���đI�����Ă��炤
Rem ***************************************************************
:ChooseTargetFile

    Call :DisplayMessage "���؂�ւ��t�@�C����I�����܂��D�D�D" 1 1

    Rem �A�v���P�[�V�����t�H���_����env�t�@�C��(.env�ȊO)�̈ꗗ��\��
    Set FileListCounter=0
    For /f %%i In ('Dir %ApplicationPath%\*.env /b') Do (

        Rem .env�t�@�C���ȊO�̎��̂ݕ\��
        if not %%i==%ExclusionFile% (
            Set /a FileListCounter=FileListCounter+1
            Echo !FileListCounter!�F�u%%i�v
        ) 

    )

    Rem �؂�ւ��t�@�C����I��
    Call :DisplayMessage "�؂�ւ��t�@�C���̔ԍ�����͂��ĉ������i1�`!FileListCounter!�j" 1 0
    Set /p TargetFileNo="�؂�ւ��t�@�C���ԍ��̓��́@���@"

    Rem �؂�ւ��t�@�C���̕\��
    Set ChooseFileNoCounter=0
    For /f %%i In ('Dir %ApplicationPath%\*.env /b') Do (

        Rem .env�t�@�C���ȊO�̎�
        if not %%i==%ExclusionFile% (
    
            Set /a ChooseFileNoCounter=ChooseFileNoCounter+1
        
            Rem �؂�ւ��t�@�C���̔ԍ��ƈ�v������
            If !ChooseFileNoCounter! Equ %TargetFileNo% (
        
                Rem �t�@�C�������Z�b�g����
                Set TargetFileName=%%i
            
            )
        )
    )
    
    Rem �؂�ւ��t�@�C���̕\��
    Call :DisplayMessage "�؂�ւ��t�@�C�����F%TargetFileName%" 1 0

    Rem �؂�ւ��t�@�C���������͂̎��i�s���Ȓl����͂������j
    Rem ��������x�A�u�؂�ւ��t�@�C���̑I���v���������s����
    If "%TargetFileName%" Equ "" (

        Call :DisplayMessage "�G���[�F�؂�ւ��t�@�C�������擾�ł��܂���ł����B�u1�`!FileListCounter!�v�œ��͂��ĉ������B" 1 0
        Call :ChooseTargetFile

    ) 

    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�؂�ւ��t�@�C����.env�t�@�C���֐؂�ւ�
Rem * ��    ���F�Ȃ�
Rem * �������e�F�I�����ꂽ�؂�ւ��t�@�C����.env�t�@�C���ɐ؂�ւ��܂�
Rem ***************************************************************
:SwitchChangeFileToEnvFile

    Rem �؂�ւ��t�@�C���̃t���p�X���擾
    Set ChangeFilePath=%ApplicationPath%\%TargetFileName%
    
    Call :DisplayMessage "�t�@�C���̐؂�ւ����s���܂�" 1 1
    
    Rem .env�t�@�C���̐؂�ւ����������s
    Rem ���R�s�[�R�}���h�����s���Đ؂�ւ���
    copy %ChangeFilePath% %SwitchDestFilePath%

    Call :DisplayMessage "�t�@�C���̐؂�ւ����������܂���" 1 1

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
Rem * �� �� ���F�I������
Rem * ��    ���F�Ȃ�
Rem * �������e�F�o�b�`�������I��������
Rem ***************************************************************
:EndProcess

    Call :DisplayMessage "���t�@�C���̐؂�ւ��������I�����܂����D�D�D           " 1 1
    Call :DisplayMessage "  �e�L�X�g�G�f�B�^�Łu%ExclusionFile%�v���J���܂�      " 0 1
    Call :DisplayMessage "���O�̂��߃L���b�V���n�̃R�}���h�����s���Ă����ĉ����� " 1 1
    Pause

    start %TextEditorPath% %SwitchDestFilePath%

    Rem �����̏I��
    Exit
    