---
title: パスワード変更の機能をどこにもたせるべきか
date: 2010-09-10
aliases:
- /2010/09/10/password_edit
---
ちょっと色々わからなくなったので、誰かのアドバイスを期待してここに書く。

簡単に前提を書くと、UserモデルのCRUDとは別にUserのパスワードを変更する画面が必要になった。Usersコントローラにpassword_editみたいなactionを書くのもあまりきれいじゃないなと思ってコントローラを分けることにした。

<pre><code>resources :users do
  resource :password
end
</code></pre>

確実にUserのレコードは必要になるので上記の用にネストさせることにした。ここで気になるのがpasswordのコントローラ名。通常PasswordsControllerになる。ただ、PasswordsController内の処理は確実にUserに依存する処理が入るため、これはこれであまりしっくりこない。別にPasswordsControllerを他で使う予定があるわけじゃないけど、User::PasswordsControllerの方がいい気がする。

<pre><code>resources :users do
  resource :password, :only => :edit, :module => 'user'
end
</code></pre>

<pre><code># app/controllers/user/passwords_controller.rb
module User
  PasswordController < ApplicationController::Base
</code></pre>

ただ、たかがあるモデルのカラムの為にここまでする必要があるのか?そもそもリソースじゃないよなと思ったりもするわけで。やっぱりUsersコントローラにactionを用意する程度に留めるべきなのだろうか。

<h3>追記:10/09/11</h3>
やっぱりコントローラを作る(というよりresourcesを追加するのが)がおかしいと思いはじめ、結局気にしてるのはURLなので以下のようにしてみようかなと思う。
<pre><code>resources :user do
  match 'password/edit' => 'users#password_edit'
end
</code></pre>