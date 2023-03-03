chcp 932
@echo off
rem ���̃o�b�`�t�@�C�����J�����g�f�B���N�g���ɂ���
cd /d %~dp0

echo ------------------------------
echo ���L2�_���쐬����o�b�`
echo �EWindows�̏��t�@�C��
echo �Einstall�̏��t�@�C��
echo ------------------------------

set folderName=%computername%

echo.
echo ------------------------------
echo %computername%�t�H���_�[���쐬��
echo ------------------------------

mkdir %folderName%

echo.
echo ------------------------------
echo �n�b�V���t�@�C�����쐬��
echo ------------------------------

rem new hashfile
set hashfile=%folderName%\SHA256.txt
rem �n�b�V���t�@�C��ReadOnly���O���ď�����
attrib -r %hashfile% > nul
copy nul %hashfile% > nul

echo %date% %time% >> %hashfile%
echo ���L�̃n�b�V���l�Ǝ��̃R�}���h�Ő��������n�b�V���l���r���邱�ƂŁA�t�@�C���ɉ������j���������������m�F�ł��܂��B >> %hashfile%
echo �R�}���h�v�����v�g��`certutil -hashfile "�����������t�@�C���p�X" SHA256`����́B >> %hashfile%
echo. >> %hashfile%

echo.
echo ------------------------------
echo Windows�̏��t�@�C�����쐬��
echo ------------------------------

set windowsinfofile=%folderName%\windows-%folderName%.txt
@REM ReadOnly���O��
attrib -r %windowsinfofile% > nul
dxdiag -t %windowsinfofile%
certutil -hashfile %windowsinfofile% SHA256 >> %hashfile%
echo. >> %hashfile%

echo.
echo ------------------------------
echo �C���X�g�[�����t�@�C�����쐬��
echo ------------------------------

set installinfofile=%folderName%\install-%folderName%.txt
@REM ReadOnly���O��
attrib -r %installinfofile% > nul
@REM install�̃o�[�W�����̂ݎ擾
@REM wmic product where "Name like '%%Microsoft 365 Apps%%'" get name,version > %installinfofile%
@REM wmic product where "Name like '%%Office%%'" get name,version > %installinfofile%
@REM �C���X�g�[�����ꗗ
call powershell -command "Get-ChildItem -Path('HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall','HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall') | %%%% { Get-ItemProperty $_.PsPath | Select-Object DisplayName, DisplayVersion, Publisher }" > %installinfofile%
certutil -hashfile %installinfofile% SHA256 >> %hashfile%

echo.
echo ------------------------------
echo ���������t�@�C���ǎ��p�ɏ���������
echo ------------------------------

attrib +r %windowsinfofile%
attrib +r %installinfofile%
attrib +r %hashfile%
