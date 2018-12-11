# README

## About
このアプリケーションはrails技術課題達成のために作られたタスク管理アプリです。  
また、本アプリ、加えて本文は現状課題評価者のために用意されたものであり、不特定の人物に利用を推奨するものではありません。  
未完であり現在誠意製作中です。(2018/12/11)  
***個人での制作のため動作の保証はいたしません***  
***このアプリケーションの利用によって起きた問題に対して一切の責任を負いません***  

### version
* Ruby 2.5.3
* Rails 5.2.2
* Database PostgreSQL

## Install
ご自身の環境にリポジトリをクローンしていただき、ローカルで起動するかHeroku等にデプロイしていただくことで動作します。

#### ローカル環境で起動
まずはRubyとRailsのバージョンをご確認ください。
>* Ruby 2.5.3
* Rails 5.2.2
* Database PostgreSQL


ご自身のローカル環境にクローンしていただきます。
>$ git clone git://github.com/miball0202/Task_manager.git

データベースのマイグレートを行います。
>$ rail db:create  
>$ rails db:migrate  

サーバーを立ち上げてご自身のローカル環境で動作を確認してください。
>$ rails s

http://localhost:3000


#### Herokuにデプロイ

まずはご自身の環境にリポジトリをクローンしてください。  
ローカル環境同様バージョンの確認もお願いします。


>$ git clone git://github.com/miball0202/Task_manager.git

git commitコマンドでコミットします。
>$ git add -A  
>$ git commit -m "init"


Herokuにログインし、新しいアプリケーションを作成します。
>$ heroku login  
>$ heroku create

Herokuにデプロイします。
>$ git push heroku master

デプロイに成功したらマイグレーションを行います。
>$ heroku run rails db:migrate

正常に終了したら  

>https://アプリ名.herokuapp.com/

で起動してください。

## Database・schema  
*実装予定のスキーマになります*  
*現在製作中のため実装は一部となっております*


| User           |        |
|:---------------|:-------|
| id             | integer|
| name           | string |
| email          | string |
| password       | string |                    
| password_digest| string |                    




| Task        |          |
|:------------|:---------|
| id          | integer  |
| user_id(FK) | reference|
| title       | string   |
| content     | text     |
| status      | string   |
| deadline    | datetime |
| priority    | integer  |


| Task_label_relation |          |
|:--------------------|:---------|
| id                  | integer  |
| task_id(FK)         | reference|
| label_id(FK)        | reference|


|Label      |        |
|:----------|:-------|
| id        | integer|
| title     | string |
