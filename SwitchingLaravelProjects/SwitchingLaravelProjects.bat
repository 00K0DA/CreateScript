Echo off

Rem For�����̒l��ω������邽�߂̐錾�i�x�����ϐ��j
Setlocal enabledelayedexpansion

Rem ************************************************************************
Rem * �o�b�`���FLaravel�̃v���W�F�N�g�̐؂�ւ�
Rem * �������e�FLaravel�̊J������؂�ւ���o�b�`�ł��BHomestead�t�H���_��
Rem *           ��yaml�t�@�C��(Homestead.yaml�ȊO)��I�������uHomestead.yaml�v
Rem *           �ɑI������yaml�t�@�C����u�������邱�ƂŊJ������؂�ւ��܂�
Rem ************************************************************************

Rem --------------------------- �ݒ� --------------------------- 
Rem Homestead�p�X
Set HomesteadPath=%UserProfile%\LaravelProjects\Homestead

Rem ---------------------- ���C���������� ---------------------- 
Rem �^�C�g���\������
Call :DisplayTitle

Rem �؂�ւ��t�@�C����I�����܂�
Call :ChooseTargetFile

Rem �؂�ւ��t�@�C����Homestead.yaml�t�@�C���ɕύX
Call :SwitchChangeFileToHomesteadFile

Rem �I������
Call :EndProcess

Rem ---------------------- ���x���������� ---------------------- 

Rem ************************************************************************
Rem * �o�b�`���FLaravel�̃v���W�F�N�g�̐؂�ւ�
Rem * �������e�FLaravel�̊J������؂�ւ���o�b�`�ł��BHomestead�t�H���_��
Rem *           ��yaml�t�@�C��(Homestead.yaml�ȊO)��I�������uHomestead.yaml�v
Rem *           �ɑI������yaml�t�@�C����u�������邱�ƂŊJ������؂�ւ��܂�
Rem ************************************************************************
:DisplayTitle

    Call :DisplayNewLine
    Call :DisplayMessage " *************************************************************************** " 0 0
    Call :DisplayMessage " * �o�b�`���FLaravel�̃v���W�F�N�g�̐؂�ւ�                                 " 0 0
    Call :DisplayMessage " * �������e�FLaravel�̊J������؂�ւ���o�b�`�ł��BHomestead�t�H���_��    " 0 0
    Call :DisplayMessage " *           ��yaml�t�@�C��(Homestead.yaml�ȊO)��I�������uHomestead.yaml�v  " 0 0
    Call :DisplayMessage " *           �ɑI������yaml�t�@�C����u�������邱�ƂŊJ������؂�ւ��܂�  " 0 0
    Call :DisplayMessage " **************************************************************************  " 0 0
    Call :DisplayNewLine
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�؂�ւ��Ώۃt�@�C���̑I��
Rem * ��    ���F�Ȃ�
Rem * �������e�FHomestead�t�H���_���Ɋi�[����Ă���
Rem *           yaml�t�@�C��(Homestead.yaml�ȊO)��\�����؂�ւ��t�@
Rem *           �C�������[�U�[�ɑΘb���đI�����Ă��炤
Rem ***************************************************************
:ChooseTargetFile

    Call :DisplayMessage "���؂�ւ��t�@�C����I�����܂��D�D�D" 1 1

    Rem Homestead�t�H���_����yaml�t�@�C��(Homestead.yaml�ȊO)�̈ꗗ��\��
    Set FileListCounter=0
    For /f %%i In ('Dir %HomesteadPath%\*.yaml /b') Do (

        Rem Homestead.yaml�t�@�C���ȊO�̎��̂ݕ\��
        if not %%i==Homestead.yaml (
            Set /a FileListCounter=FileListCounter+1
            Echo !FileListCounter!�F�u%%i�v
        ) 

    )

    Rem �؂�ւ��t�@�C����I��
    Call :DisplayMessage "�؂�ւ��t�@�C���̔ԍ�����͂��ĉ������i1�`!FileListCounter!�j" 1 0
    Set /p TargetFileNo="�؂�ւ��t�@�C���ԍ��̓��́@���@"

    Rem �؂�ւ��t�@�C���̕\��
    Set ChooseFileNoCounter=0
    For /f %%i In ('Dir %HomesteadPath%\*.yaml /b') Do (

        Rem Homestead.yaml�t�@�C���ȊO�̎�
        if not %%i==Homestead.yaml (
    
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
Rem * �� �� ���F�؂�ւ��t�@�C����Homestead.yaml�t�@�C���֐؂�ւ�
Rem * ��    ���F�Ȃ�
Rem * �������e�F�I�����ꂽ�؂�ւ��t�@�C����Homestead.yaml�t�@�C��
Rem *           �ɐ؂�ւ��܂�
Rem ***************************************************************
:SwitchChangeFileToHomesteadFile

    Rem �؂�ւ��t�@�C���̃p�X���擾
    Set ChangeFilePath=%HomesteadPath%\%TargetFileName%
    
    Rem Homestead.yaml�t�@�C���̃p�X���擾
    Set HomesteadFilePath=%HomesteadPath%\Homestead.yaml
    
    
    Call :DisplayMessage "�t�@�C���̐؂�ւ����s���܂�" 1 1
    
    Rem Homestead.yaml�t�@�C���̐؂�ւ����������s
    Rem ���R�s�[�R�}���h�����s���Đ؂�ւ���
    copy %ChangeFilePath% %HomesteadFilePath%

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

    Call :DisplayMessage "���t�@�C���̐؂�ւ��������I�����܂����D�D�D                                            " 1 1
    Call :DisplayMessage "���uvagrant provision�v�R�}���h�����s��vagrant�t�@�C���̍ēǍ����s���ĉ�����            " 0 1
    Call :DisplayMessage "  vagrant�̍ċN���ł��ݒ�t�@�C���̓��e�͐؂�ւ��Ȃ��̂ŕK���R�}���h�����s���ĉ����� " 0 1
    Pause

    Rem �����̏I��
    Exit
    