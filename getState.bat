@echo off
rem このバッチファイルをカレントディレクトリにする
cd /d %~dp0

echo ------------------------------
echo 下記2点を作成するバッチ
echo ・Windowsの情報ファイル
echo ・MSOfficeの情報ファイル
echo ------------------------------

set folderName=%computername%

echo.
echo ------------------------------
echo %computername%フォルダーを作成中
echo ------------------------------

mkdir %folderName%

echo.
echo ------------------------------
echo ハッシュファイルを作成中
echo ------------------------------

rem new hashfile
set hashfile=%folderName%\SHA256.txt
rem ハッシュファイルReadOnlyを外して初期化
attrib -r %hashfile% > nul
copy nul %hashfile% > nul

echo %date% %time% >> %hashfile%
echo 下記のハッシュ値と次のコマンドで生成されるハッシュ値を比較することで、ファイルに改ざんや破損等が無いかを確認できます。 >> %hashfile%
echo コマンドプロンプトに`certutil -hashfile "検査したいファイルパス" SHA256`を入力。 >> %hashfile%
echo. >> %hashfile%

echo.
echo ------------------------------
echo Windowsの情報ファイルを作成中
echo ------------------------------

set windowsinfofile=%folderName%\windows-%folderName%.txt
dxdiag -t %windowsinfofile%
certutil -hashfile %windowsinfofile% SHA256 >> %hashfile%
echo. >> %hashfile%

echo.
echo ------------------------------
echo MSOfficeの情報ファイルを作成中
echo ------------------------------

set msofficeinfofile=%folderName%\msoffice-%folderName%.txt
wmic product where "Name like '%%Office%%'" get name,version > %msofficeinfofile%
certutil -hashfile %msofficeinfofile% SHA256 >> %hashfile%

rem ReadOnlyに書き換える
attrib +r %hashfile%
