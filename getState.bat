@echo off
rem ���̃o�b�`�t�@�C�����J�����g�f�B���N�g���ɂ���
cd /d %~dp0

echo ------------------------------
echo ���L2�_���쐬����o�b�`
echo �EWindows�̏��t�@�C��
echo �EMSOffice�̏��t�@�C��
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
dxdiag -t %windowsinfofile%
certutil -hashfile %windowsinfofile% SHA256 >> %hashfile%
echo. >> %hashfile%

echo.
echo ------------------------------
echo MSOffice�̏��t�@�C�����쐬��
echo ------------------------------

set msofficeinfofile=%folderName%\msoffice-%folderName%.txt
wmic product where "Name like '%%Office%%'" get name,version > %msofficeinfofile%
certutil -hashfile %msofficeinfofile% SHA256 >> %hashfile%

rem ReadOnly�ɏ���������
attrib +r %hashfile%
