# getState

WindowsPCのハードウェア構成とMSOfficeのバージョンをテキストファイルで取得するバッチファイル。

## 目的

管理者がユーザーのWindowsPCのハードウェア構成を知りたい時に役に立ちます。
PCにやや不慣れな人が操作してもしっかりとしたデータが作成できるようになっています。

## 想定している利用方法

###  管理者

1. [zip](https://github.com/Ogurana17/getState/archive/refs/heads/main.zip)の状態でPCを操作する人に送る
2. ユーザーからデータが送られてくるのを待つ

### ユーザー

1. 管理者から送られてきたzipファイルを解凍
2. 中にある`getState.bat`をダブルクリック
3. 生成された[computerName]フォルダーをデータがほしい管理者に送る
