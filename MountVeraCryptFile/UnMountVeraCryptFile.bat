Echo off
Rem ********************************************************************
Rem * �o�b�`���FVeraCrypt�Ń}�E���g�����h���C�u���A���}�E���g����o�b�`
Rem * �������e�FVeraCrypt�Ń}�E���g���ꂽ�h���C�u���A���}�E���g���܂�
Rem ********************************************************************

Rem --------------------------- �ݒ� --------------------------- 
Rem VeraCrypt�p�X ���u���s�h���C�u������:/Tools\VeraCrypt�v�ɂȂ�܂�
Set VeraCryptPath=%~d0/Tools\VeraCrypt\

Rem ---------------------- ���C���������� ---------------------- 
Rem �^�C�g���\������
Call :DisplayTitle

Rem ���݂̃f�B���N�g����VeraCrypt�f�B���N�g���ɕύX
Call :ChangeVeraCryptDirectory

Rem �A���}�E���g�h���C�u�����擾
Call :InputUnMountDriveNmae

Rem VeraCrypt�Ń}�E���g�����h���C�u�̃A���}�E���g����
Call :UnMountVeraCryptDrive

Rem �I������
Call :EndProcess

Rem ---------------------- ���x���������� ---------------------- 

Rem ********************************************************************
Rem * �� �� ���F�^�C�g���̕\��
Rem * ��    ���F�Ȃ�
Rem * �������e�FVeraCrypt�Ń}�E���g���ꂽ�h���C�u���A���}�E���g����o�b
Rem *           �`�̃^�C�g����\�����܂�
Rem ********************************************************************
:DisplayTitle

    Call :DisplayNewLine
    Call :DisplayMessage "******************************************************************** " 0 0
    Call :DisplayMessage "  �o�b�`���FVeraCrypt�Ń}�E���g�����h���C�u���A���}�E���g����o�b�`  " 0 0
    Call :DisplayMessage "  �����T�v�FVeraCrypt�Ń}�E���g���ꂽ�h���C�u���A���}�E���g���܂�    " 0 0
    Call :DisplayMessage "******************************************************************** " 0 0
    Call :DisplayNewLine
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F���݂̃f�B���N�g����VeraCrypt�f�B���N�g���ɕύX
Rem * ��    ���F�Ȃ�
Rem * �������e�F���݂̃f�B���N�g���ibat�����s�����ꏊ�j����VeraCrypt
Rem *           �̃f�B���N�g���ɕύX����
Rem ***************************************************************
:ChangeVeraCryptDirectory

    Call :DisplayMessage "�����݂̃f�B���N�g����VeraCrypt�̃f�B���N�g���ɕύX���܂��D�D�D  " 0 0
    
    Rem �f�B���N�g�����uVeraCrypt�v�f�B���N�g���ɕύX
    Cd %VeraCryptPath%
    
    Call :DisplayMessage "���݂̃f�B���N�g����VeraCrypt�̃f�B���N�g���ɕύX���܂����D�D�D" 1 0
    Call :DisplayMessage "�� %VeraCryptPath%                                             " 0 0
    
    Exit /b

Rem ***************************************************************
Rem * �� �� ���F�A���}�E���g�Ώۃh���C�u�����擾
Rem * ��    ���F�Ȃ�
Rem * �������e�F�A���}�E���g�h���C�u�������[�U�[�ɑΘb���擾����B�uY�v
Rem             ���́uy�v���w�肳�ꂽ�ꍇ�͍ēx���[�U�[�ɑΘb
Rem ***************************************************************
:InputUnMountDriveNmae

    Call :DisplayMessage "���A���}�E���g�Ώۃh���C�u�w�菈�����s���܂��D�D�D                    " 1 1

    Rem �A���}�E���g����h���C�u�w��i���[�U�[�ɑΘb�j
    Set /p UnMountDrive="�A���}�E���g����h���C�u���w�肵�ĉ������@���@"
    
    Rem �h���C�u�w�肪�󕶎��̎�
    If "%UnMountDrive%" Equ "" (
    
        Rem �G���[��\�����A�A���}�E���g�Ώۃh���C�u���擾������������x���s
        Call :DisplayMessage "�G���[�F�h���C�u�̎w�肪����������܂���" 1 0
        Call :InputUnMountDriveNmae
        Exit /b
        
    )
    
    Rem �Ώۃh���C�u�\������
    Call :DisplayMessage "�A���}�E���g�Ώۃh���C�u�F%UnMountDrive%                              " 1 1

    Rem �����𑱍s���邩���[�U�[�ɑΘb 
    Rem ����Enter����Ɨ����邽�߁A�\�ߓK���Ȓl���Z�b�g���Ă���
    Call :DisplayMessage "���L���b�Z�[�W��(�uY�v���́uy�v)�ȊO�̓h���C�u�w����ēx�s���܂��D�D�D" 0 0
    Set RunContinueResult=KaraMojiTaiou
    Set /p RunContinueResult="��L�����g�p���ď��������s���܂����H(y/n)�@���@"
    
    Rem �啶��/�������ϊ�(Y�ȊO�͑S�ăL�����Z������) 
    Set RunContinueResult=%RunContinueResult:y=Y%%

    Rem Y�ȊO�̓��͂̎��́u�A���}�E���g�Ώۃh���C�u�����擾�v��
    If /i Not %RunContinueResult%==Y Call :InputUnMountDriveNmae

    Exit /b

Rem ***************************************************************
Rem * �� �� ���FVeraCrypt�Ń}�E���g�����h���C�u�̃A���}�E���g����
Rem * ��    ���F�Ȃ�
Rem * �������e�FVeraCrypt�Ń}�E���g�����h���C�u�����[�U�[�ɑΘb��
Rem *           �Ώۂ̃h���C�u���A���}�E���g����
Rem ***************************************************************
:UnMountVeraCryptDrive

    Call :DisplayMessage "��VeraCrypt�Ń}�E���g���ꂽ�h���C�u�̃A���}�E���g�������s���܂��D�D�D" 1 1
    
    Call :DisplayMessage "�����s�����R�}���h�͈ȉ��ɂȂ�܂�          " 0 0
    Call :DisplayMessage " �� VeraCrypt /q /d %UnMountDrive%            " 0 1

    Rem �����𑱍s���邩���[�U�[�ɑΘb
    Rem ����Enter����Ɨ����邽�߁A�\�ߓK���Ȓl���Z�b�g���Ă���
    Call :DisplayMessage "���L���b�Z�[�W��(�uY�v���́uy�v)�ȊO�͏������I�����܂��D�D�D         " 0 0
    Set RunContinueResult=KaraMojiTaiou
    Set /p RunContinueResult="��L�����g�p���ď��������s���܂����H(y/n)�@���@"

    Rem �啶��/�������ϊ�(Y�ȊO�͑S�ăL�����Z������) 
    Set RunContinueResult=%RunContinueResult:y=Y%%

    Rem Y�ȊO�̓��͂̎��͏������I��
    If /i Not %RunContinueResult%==Y Call :EndProcess

    Rem �Í����R���e�i�̃A���}�E���g����
    Rem /q�F�o�b�N�O���E���h��VeraCrypt�����s������ ���p�X���[�h���̓{�b�N�X�̂ݕ\��������
    Rem /d�F�A���}�E���g����h���C�u��
    VeraCrypt /q /d %UnMountDrive%

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

    Call :DisplayMessage "���A���}�E���g�������I�����܂����D�D�D" 1 1
    Pause

    Rem �����̏I��
    Exit
    