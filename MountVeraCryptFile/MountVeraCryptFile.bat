Echo off

Rem For�����̒l��ω������邽�߂̐錾�i�x�����ϐ��j
Setlocal enabledelayedexpansion

Rem ***************************************************************
Rem * �o�b�`���FVeraCrypt�ō쐬�����Í����R���e�i�̃}�E���g�o�b�`
Rem * �������e�FVeraCrypt�ō쐬�����Í����R���e�i���}�E���g���܂�
Rem ***************************************************************

Rem --------------------------- �ݒ� --------------------------- 
Rem VeraCrypt�p�X ���u���s�h���C�u������:/Tools\VeraCrypt�v�ɂȂ�܂�
Set VeraCryptPath=%~d0/Tools\VeraCrypt\
Rem �Í����R���e�i�t�@�C���i�[�t�H���_ ���u���s�h���C�u������:/Tools\VeraCrypt\�Í����R���e�i�t�@�C���i�[�t�H���_�v
Set EncryptionContainerStorageFolder=EncryptionContainerFile\

Rem ---------------------- ���C���������� ---------------------- 
Rem �^�C�g���\������
Call :DisplayTitle

Rem ���݂̃f�B���N�g����VeraCrypt�f�B���N�g���ɕύX
Call :ChangeVeraCryptDirectory

Rem �}�E���g�Ώۃt�@�C����I�����܂�
Call :ChooseTargeFile

Rem �Í����R���e�i�̃}�E���g����
Call :MountEncryptionContainer

Rem �I������
Call :EndProcess

Rem ---------------------- ���x���������� ---------------------- 

Rem ***************************************************************
Rem * �� �� ���F�^�C�g���̕\��
Rem * ��    ���F�Ȃ�
Rem * �������e�FVeraCrypt�ō쐬�����Í����R���e�i�̃}�E���g�o�b�`��
Rem *           �^�C�g����\������
Rem ***************************************************************
:DisplayTitle

    Call :DisplayNewLine
    Call :DisplayMessage "************************************************************** " 0 0
    Call :DisplayMessage "  �o�b�`���FVeraCrypt�ō쐬�����Í����R���e�i�̃}�E���g�o�b�`  " 0 0
    Call :DisplayMessage "  �����T�v�FVeraCrypt�ō쐬�����Í����R���e�i���󂢂Ă���h��  " 0 0
    Call :DisplayMessage "            �C�u���^�[�Ƀ}�E���g�������s��                     " 0 0
    Call :DisplayMessage "************************************************************** " 0 0
    Call :DisplayNewLine
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���݂̃f�B���N�g����VeraCrypt�f�B���N�g���ɕύX
Rem * ��    ���F�Ȃ�
Rem * �������e�F���݂̃f�B���N�g���ibat�����s�����ꏊ�j����VeraCrypt
Rem *           �̃f�B���N�g���ɕύX����
Rem ***************************************************************
:ChangeVeraCryptDirectory

    Call :DisplayMessage "�����݂̃f�B���N�g����VeraCrypt�̃f�B���N�g���ɕύX���܂��D�D�D" 0 0
    
    Rem �f�B���N�g�����uVeraCrypt�v�f�B���N�g���ɕύX
    Cd %VeraCryptPath%
    
    Call :DisplayMessage "���݂̃f�B���N�g����VeraCrypt�̃f�B���N�g���ɕύX���܂����D�D�D" 1 0
    Call :DisplayMessage "�� %VeraCryptPath%                                             " 0 0
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�}�E���g�Ώۃt�@�C���̑I��
Rem * ��    ���F�Ȃ�
Rem * �������e�F�Í����R���e�i�t�@�C�����i�[����Ă���t�H���_����
Rem *           �t�@�C����\�����Ώۃt�@�C�������[�U�[�ɑΘb���đI
Rem *           �����Ă��炤
Rem ***************************************************************
:ChooseTargeFile

    Call :DisplayMessage "���}�E���g�Ώۃt�@�C����I�����܂��D�D�D" 1 1

    Rem �Í����R���e�i�t�@�C�����i�[����Ă���t�H���_���̃t�@�C���̈ꗗ��\��
    Set FileListCounter=0
    For /f %%i In ('Dir %EncryptionContainerStorageFolder% /b') Do (

        Set /a FileListCounter=FileListCounter+1
        Echo !FileListCounter!�F�u%%i�v

    )

    Rem �ΏۃR���e�i�t�@�C����I��
    Call :DisplayMessage "�}�E���g����R���e�i�t�@�C���̔ԍ�����͂��ĉ������i1�`!FileListCounter!�j" 1 0
    Set /p TargetFileNo="�R���e�i�t�@�C���ԍ��̓��́@���@"

    Rem �ΏۃR���e�i�t�@�C���̕\��
    Set ChooseFileNoCounter=0
    For /f %%i In ('Dir EncryptionContainerFile\ /b') Do (
    
        Set /a ChooseFileNoCounter=ChooseFileNoCounter+1
        
        Rem �ΏۃR���e�i�t�@�C���̔ԍ��ƈ�v������
        If !ChooseFileNoCounter! Equ %TargetFileNo% (
        
            Rem �t�@�C�������Z�b�g����
            Set TargetFileName=%%i
            
        )
    )
    
    Rem �ΏۃR���e�i�t�@�C���̕\��
    Call :DisplayMessage "�Ώۃt�@�C�����F%TargetFileName%" 1 0

    Rem �ΏۃR���e�i�t�@�C���������͂̎��i�s���Ȓl����͂������j
    Rem ��������x�A�u�}�E���g�Ώۃt�@�C���̑I���v���������s����
    If "%TargetFileName%" Equ "" (

        Call :DisplayMessage "�G���[�F�Ώۃt�@�C�������擾�ł��܂���ł����B�u1�`!FileListCounter!�v�œ��͂��ĉ������B" 1 0
        Call :ChooseTargeFile

    ) 

    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�Í����R���e�i�̃}�E���g����
Rem * ��    ���F�Ȃ�
Rem * �������e�F�Í����R���e�i���}�E���g���邩�ǂ������[�U�[�ɑΘb
Rem ***************************************************************
:MountEncryptionContainer

    Rem �}�E���g�ΏۃR���e�i�t�@�C�����擾
    Set TargetContainerFile=%EncryptionContainerStorageFolder%%TargetFileName%

    Call :DisplayMessage "���Í����R���e�i�̃}�E���g�������s���܂��D�D�D              " 1 1
    Call :DisplayMessage "�����s�����R�}���h�͈ȉ��ɂȂ�܂�                        " 0 0
    Call :DisplayMessage " �� VeraCrypt /q /e /v %TargetContainerFile%                " 0 0

    Rem �����𑱍s���邩���[�U�[�ɑΘb
    Rem ����Enter����Ɨ����邽�߁A�\�ߓK���Ȓl���Z�b�g���Ă���
    Call :DisplayMessage "���L���b�Z�[�W��(�uY�v���́uy�v)�ȊO�͏������I�����܂��D�D�D" 1 0
    Set RunContinueResult=KaraMojiTaiou
    Set /p RunContinueResult="��L�����g�p���ď��������s���܂����H(y/n)�@���@"

    Rem �啶��/�������ϊ�(Y�ȊO�͑S�ăL�����Z������) 
    Set RunContinueResult=%RunContinueResult:y=Y%%

    Rem Y�ȊO�̓��͂̎��͏������I��
    If /i Not %RunContinueResult%==Y Call :EndProcess

    Rem �Í����R���e�i�̃}�E���g����
    Rem /q�F�o�b�N�O���E���h��VeraCrypt�����s������ ���p�X���[�h���̓{�b�N�X�̂ݕ\��������
    Rem /e�F�}�E���g��G�N�X�v���[���[�ŊJ��
    Rem /v�F�}�E���g����t�@�C����
    VeraCrypt /q /e /v %TargetContainerFile%

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

    Call :DisplayMessage "���}�E���g�������I�����܂����D�D�D" 1 1
    Pause

    Rem �����̏I��
    Exit
    