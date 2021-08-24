# Suave
[サイトはこちら](http://18.178.63.221/)
（現在停止中）


## 概要

ゲームプレイヤーとゲームクリエイターのためのWEBアプリです。<br>
ユーザー登録後、製作したゲームのアップロードやユーザー同士でのチャットを行えます。アップロードしたゲームは誰でもダウンロードして遊ぶことができます。<br>
アップロードされたゲームはS3へ保存される為、耐久性がかなり高くいつでもダウンロードが可能です。

![概要](/app/assets/images/suave-about.png)

## バージョン

ruby 2.5.7<br>
Rails 5.2.4.1

## 機能

- ユーザー登録
- ゲームのダウンロード
- ゲームの投稿
- コメント、難易度、評価機能
- フォロー機能
- 通知機能
- お問い合わせ機能
- チャット機能

## デモ
いくつかの機能をピックアップして紹介します。

### ゲーム投稿
    製作したゲームを投稿することができます。投稿されたゲームはS3へアップロードされる為いつでもダウンロードが可能です。
    投稿方法は下記画像を参照してください。
![ゲーム投稿１](/app/assets/images/new-game1.png)
![ゲーム投稿２](/app/assets/images/new-game2.png)
![ゲーム投稿３](/app/assets/images/new-game3.png)

### コメント機能
    ゲームの感想や評価、難易度をコメントできます。
    コメントの評価、難易度によってそのゲームの評価と難易度が決まります。詳細は下記画像を参照してください。
![コメント１](/app/assets/images/comment1.png)
![コメント２](/app/assets/images/comment2.png)

### お問い合わせ機能
    何かトラブルがあった際はお問い合わせ機能をご利用ください。
    お問い合わせフォームにて送信頂いた後に管理者が対応し、ユーザー登録の際に設定したメールアドレス宛に返信いたします。
    詳細は下記画像参照してください。
![お問い合わせ１](/app/assets/images/contact1.png)
![お問い合わせ２](/app/assets/images/contact2.png)
![お問い合わせ３](/app/assets/images/contact3.png)

### チャット機能
    ユーザー同士でチャットをすることができます。チャットをしたいユーザーのページに行き、「チャットを始める」をクリックしてください。
    また、トークルームを作成していろんなユーザーとチャットすることもできます。詳細は下記画像を参照してください。
![チャット１](/app/assets/images/talkroom1.png)
![チャット２](/app/assets/images/talkroom2.png)
![チャット３](/app/assets/images/talkroom3.png)

## さいごに
ここまでご覧いただき、ありがとうございます。<br>
初めてのアプリケーション開発の為いたらないところばかりだと思いますが、<br>
このようなサイトがあればいいな。と思い描いていたサイトを形にすることができました。<br>
少しでもゲーム好きの皆さんにとって心地よい場所になれば幸いです。<br>
<br>
作成者：[Tatsumi](https://github.com/YoshidaTatsumi)



