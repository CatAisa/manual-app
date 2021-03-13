## マニュアル作成アプリ

### リンク

URL(http://35.72.86.251/)

ログインページから「ゲストでログイン」をクリックすることでご利用いただけます。

### アプリケーション概要
作業手順や料理レシピを画像付きで保存し、ユーザー間で共有できるアプリケーションです。

職場での経験から、メモを取ることの重要性を感じた反面、メモを取らなくても良い環境づくりのために、マニュアルを作成することの重要性も感じました。

そこで、メモを取るような手軽さで、マニュアルを作成することができるアプリケーションを作りたいと思ったことがきっかけです。

![app_pv2](https://user-images.githubusercontent.com/73692212/111026365-28edcd00-842d-11eb-9f75-c7c02f0c9432.gif)

### 使用技術
- HTML, CSS
- Ruby 2.6.5
- Ruby on Rails 6.0.0
- ActiveStorage（画像保存）
- MySQL
- JavaScript
- RuboCop（コード解析）
- RSpec（テストフレームワーク）
- AWS [EC2, RDS, S3, IAM, EIP]（本番環境）
- Unicorn, Nginx（サーバー構築）
- Capistrano（自動デプロイ）
- VSCode, Vim

### 機能一覧


- ユーザー管理機能
  - 新規登録、ログイン、ログアウト
  - かんたんログイン
  - 登録情報編集
  - マイページ

<img width="300" alt="ログイン２" src="https://user-images.githubusercontent.com/73692212/111017262-a564b980-83f5-11eb-9c49-986e96605eae.png">

- 投稿機能（マニュアル、マニュアル手順）
  - 新規作成、編集、削除
  - 画像投稿
  - 一覧表示
  - 詳細表示

<img width="300" alt="マニュアル詳細２" src="https://user-images.githubusercontent.com/73692212/111017288-db09a280-83f5-11eb-8436-984796584a1a.png">

- 画像加工機能（投稿時）
  - プレビュー表示
  - トリミング<br />
<img width="300" alt="トリミング" src="https://user-images.githubusercontent.com/73692212/110199612-879ad000-7e9c-11eb-9389-292d06679405.png"><br />
  - お絵かき機能

<img width="300" alt="お絵かき" src="https://user-images.githubusercontent.com/73692212/110199618-908ba180-7e9c-11eb-90a1-6f9bda14dac1.png">

- 一般公開機能
  - 作成したマニュアルの一般公開、非公開
- お気に入り登録機能
  - 公開されたマニュアルのお気に入り登録
  - お気に入りページ
- コメント機能
  - マニュアルに対してコメント投稿、削除

<img width="400" alt="コメント画面" src="https://user-images.githubusercontent.com/73692212/111017438-f628e200-83f6-11eb-8305-f2abb79322aa.png">


### データベース設計

<img width="500" alt="データベース設計" src="https://user-images.githubusercontent.com/73692212/110192629-8c4a8e80-7e72-11eb-821f-1e54ae413460.png">

### 今後実装したい機能
- 画像加工において、テキストボックスを挿入できる機能
