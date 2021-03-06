---
aliases:
- /2008/06/05/rails_vim_rspec
date: "2008-06-05"
title: rails.vimのファイル切り替えをRSpecに対応させる(仮)
---
rails.vimをインストールすると、RcontrollerとかRmodelコマンドでRSpecファイルからControllerやModelファイルに切り替えることができるんだけど、その逆ができないので対応させた。仮なのはVimスクリプトをちゃんと書けなくてコピペのごまかしだから。

書きかえるファイルは~/.vim/autoload/rails.vim。一応行数も書いたけどもしかしたらズレてるかもしれないので参考程度に。あと、バージョンは2.0使ってる。

まずは、:Rspec、:Rspeccontroller、:Rspecmodelを呼び出せるようにする。
<pre lang="vim">
1777   call s:addfilecmds("integrationtest")
1778   call s:addfilecmds("spec")
1779   call s:addfilecmds("speccontroller")
1780   call s:addfilecmds("specmodel")
1781   call s:addfilecmds("stylesheet")
</pre>
なんでわざわざ3つあるのかと言うと、「:Rspec hoge」ってやった時にControllerのスペックなのか、Modelのスペックなのか判断する方法がわからなかったから。だからとりあえず「:Rspec」とやったときは、今開いているファイルに対応するスペックファイルを開き、個別に指定して開きたいときは「:Rspeccontroller hoge」もしくは「:Rspecmodel hoge」で明示的にControllerかModelかを指定するようにした。

次に「:Rspeccontroller [tab]」や「:Rspecmodel [tab]」としたときに、スペック名を補完できるようにfunctionを追加する。
<pre lang="vim">
1941 function! s:speccontrollerList(A,L,P)
1942   return s:autocamelize(s:relglob("spec/controllers/",s:recurse,"_controller_spec.rb"),a:A)
1943 endfunction
1944
1945 function! s:specmodelList(A,L,P)
1946   return s:autocamelize(s:relglob("spec/models/",s:recurse,"_spec.rb"),a:A)
1947 endfunction
</pre>

最後に実際にファイルを開く部分。2331、2334、2340、2345の"spec"、"speccontroller"、"specmodel"が最初に設定したaddfilecmdsの引数と対応するっぽい。なのでfunction名はなんでもいいと思うけど、とりあえず他のに合わせた。

specEditは「:Rspec」に対応していて、開いたファイルがControllerかModelかで開くスペックファイルもかわる。speccontrollerEditとspecmodelEditはControllerかModelどちらか決まったものしか開かない。

<pre lang="vim">
2328 function! s:specEdit(bang,cmd,...)
2329   if s:model() != ''
2330     let f = s:model()
2331     return s:EditSimpleRb(a:bang,a:cmd,"spec",f,"spec/models/","_spec.rb")
2332   else
2333     let f = s:controller()
2334     return s:EditSimpleRb(a:bang,a:cmd,"spec",f,"spec/controllers/","_controller_spec.rb")
2335   endif
2336 endfunction
2337
2338 function! s:speccontrollerEdit(bang,cmd,...)
2339   let f = s:controller()
2340   return s:EditSimpleRb(a:bang,a:cmd,"speccontroller",f,"spec/controllers/","_controller_spec.rb")
2341 endfunction
2342
2343 function! s:specmodelEdit(bang,cmd,...)
2344   let f = s:model()
2345   return s:EditSimpleRb(a:bang,a:cmd,"specmodel",f,"spec/models/","_spec.rb")
2346 endfunction
</pre>

とりあえず、現状の設定で簡易的にRSpecに対応させることができる。「:Rspec」の存在が気持ち悪いのであれば、それは消して開いているファイルがControllerかModelか自分で判断して「:Rspeccontroller」か「:Rspecmodel」を使いわければいいと思う。「:Rspec [tab]」でエラーが出るし個人的には気持ちわるいんだけど、対応させたスペックを開くことの方がおおいし、その時は短いコマンドの方が都合がいいのでここらへんは妥協。今回Viewには対応させていないけれど、同じ要領でできるはず。

rails.vimを少しよんだだけだし、実際の動作もまともに検証してないので変な動作したらごめんなさい。まぁ致命的な問題は起きないだろうけど。正式にrails.vimがRSpecに対応してくれるといいんだけどね。