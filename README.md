# Search-for-sugar
## 概要
<p>Bootcampの自分サービスを作るもの。</p>
<p>食材名を入力すると、食材に糖質の量を返す。</p>
<p>このサービスはダイエット中の人に向け、食材に含まれている糖質量が探し辛いという課題を解決する。</p>

## 開発環境
- Ruby 2.7.0
- Ruby on Rails 6.1.4.6
- VueJS 3.1

## 機能概要
- ユーザーは食材によって、糖質を検索できる。
- 管理者は食材の情報を編集できる。

## 実行
`$ bundle install`
`$ rails db:migrate`
`$ rails webpacker:install`
`$ rails s`

## データのセットアップ
`$ rails db:seed`
