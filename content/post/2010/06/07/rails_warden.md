---
title: warden+railsでパスワード認証
date: 2010-06-07
---
今作っているサービスが後々、OAuth、OpenIDあたりにも対応することになるかもしれないので、そのあたり柔軟に対応できそうなwardenを試してみました。

必要なgemは<a href="http://github.com/hassox/warden">warden</a>と<a href="http://github.com/hassox/rails_warden">rails_warden</a>の2つ。

Userモデルは以下のような感じで。
<script src="http://gist.github.com/428559.js?file=20100602075944_create_users.rb"></script>

次に<a href="http://github.com/hassox/rails_warden">githubのページ</a>を参考にconfig/initializers/warden.rbを追加します。今回はパスワードで認証をしたいのでpasswordのstrategyを自分で追加します。(と言ってもほとんどサンプルと同じ)

<script src="http://gist.github.com/428563.js?file=warden.rb"></script>

この後はUser.authenticateの中身をfind_by_login_and_passwordとかで実装してもいいのですが、それだとパスワードが平文になってしまうのでrestful_authenticationのコードを少し拝借することにします。

<script src="http://gist.github.com/428567.js?file=user.rb"></script>
includeいているものがrestful_authenticationのコードです。適当にコピーしてlibにでも置いておくといいと思います。

これでpasswordとpassword_confirmationによるパスワードの確認、User#save時にパスワードをハッシュ化して保存してくれます。

後、一応ログイン処理するコントローラも載せておきます。
<script src="http://gist.github.com/428569.js?file=sessions_controller.rb"></script>
unauthenticatedが認証に失敗したときに遷移するアクションです。

正直、パスワード認証のことだけ考えるとちょっと面倒な気もします。パスワードの暗号化も自分で書かなければいけないし。ただ、上記のようにmoduleを別途用意しておけば作業の手間自体は結構軽減されので、そこまでは問題にならないかもしれません。

Strategyまわりについてはほとんど検証していませんが、色々と融通は効きそうな気もします。この辺は追々。

後は<a href="http://github.com/plataformatec/devise">devise</a>というwardenベースのライブラリもあるのでこれを試すのもありかなという気はします。ただ、deviseは色々とやり過ぎというか、多機能すぎてよくわからない感じもしますが・・・