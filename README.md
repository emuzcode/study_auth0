# 「ハンズオンで学ぶログイン機能の実装 |「Auth0」を使った簡単ログイン認証」

日時：6/10(土) 13:00~ (1.5h〜2hの予定)

レベル：初級〜中級


<img src="https://github.com/emuzcode/study_auth0/assets/84742299/83304269-7b64-4d9d-b850-8f2fa1a30354" width="800px">  

---

### 概要

1. Auth0とは？
2. 環境構築
3. 簡単ログイン実装（確認のみ）
4. Auth0アカウントを作成する
5. 2種類のAuth0ログイン実装
6. omniauth-auth0 gem について
7. auth0 gem について
8. 参考URL


## [Auth0とは？](https://auth0.com/) 

Auth0は、Auth0　Inc.が提供するクラウドサービスやアプリを利用する際の認証プラットフォームサービスを提供する**IDaaS**の1つです。IDaaSは、自社で運用・管理を行っていた**オンプレミス**での社員のID/パスワード管理を**クラウド**上で実現するサービスです。

>オンプレミス・・・サーバーやネットワーク機器などを自社で保有し運用する利用形態のこと
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/e1036516-69ce-40f4-a226-5b06079dbe53" width="800px">  



>クラウドサービス・・・従来は利用者が手元のコンピュータで利用していたデータやソフトウェアを、ネットワーク経由で、サービスとして利用者に提供するもの。オンプレミスとは異なり、インターネット上にネットワーク接続ができる環境にいれば、どの場所にいてもサービスを利用することが可能です。つまり、場所を問わずに働くことができます。
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/f61f3bfd-d3cf-4d33-b277-74293ea16305" width="800px">  



>IDaaS・・・在宅勤務やテレワークなど自宅やサテライトオフィス、カフェなど、オフィス以外で働く人が増えてきた近年。営業の方やデザイナー、プログラマーといった職種に就く方々は、外出先から社内ネットワークにログインする機会も当たり前になってきました。
>結果、従来よりも社外からアクセスする機会が増加。　  
>>社員またはECサイトのなどの会員のID/パスワード管理をクラウド＋セキュリティ対策でサービスにしたものが認証プラットフォームサービスいわゆるIDaaSです。
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/653c7964-0713-4247-a177-4c33c6189c92" width="800px">  



### Auth0 Inc. のざっくりな歴史

*2013 - 創業　（in USA)*  
元Microsoft社勤務の社員が中心となって、Webアプリ等の認証・認可のクラウドサービスを、アプリ開発者向けに提供する（アイデンティティプラットフォーム）　　

*2017*  
Auth0は世界中で高い評価を受ける認証サービスになり、世界175か国で75,000以上の企業が導入。日本の企業ではNTTドコモ、スバル、マツダ、シャープなど様々業界の企業が導入実績があります。  

*2021*  
競合会社Okta, Inc.　（アイデンティティ管理のサービスプロバイダー）に買収・統合される。　　　

### Auth0の基本的な4つの機能

1. シングルサインオン（SSO）
2. ユニバーサルログイン
3. 多要素認証(MFA)
4. 異常検出（Anomaly Detection）機能

> 1. シングルサインオン（SSO）

シングルサインオンとはクラウドサービスやアプリにワンクリックでログインを可能にする機能です。
業務上利用頻度の高いOffice365などのサービスをスムーズに利用可能です。
複数のパスワード管理をしなくて済むので、楽ですね。  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/4e2714f2-ef7d-44b6-85fd-1e5c3b1a0a75" width="800px">  



> 2. ユニバーサルログイン

中央認証サーバーを活用してのユーザー認証を実行します。ログインフローの変更、ページの高速読み込み、ログイン時でのデザイン一新などの機能があります。様々なアプリケーション間を自由に高速で移動できるだけでなく、次にご説明する多要素認証を組み合わせることで、第3者の不正アクセスのリスク軽減を実現できます  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/33f63542-6f2e-4154-a9f1-0cc085b65b82" width="800px">  



> 3. 多要素認証(MFA)

Google AuthenticatorやOkta Verifyなどが有名な例です。他にもID/パスワード入力だけでなく、スマートフォンのSMSを使用したワンタイムパスワードの活用やユーザーの生体機能を組み合わせることもできます。  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/f000e338-0165-410a-8787-e0da6992ef6d" width="800px">  



> 4. 異常検出（Anomaly Detection）機能

管理画面上でクリック操作を行うだけで、信頼性の低いIPアドレスからのアクセスや流出・盗難されたパスワードからのアクセスをブロック可能です。  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/bcf4db79-70ff-4ae6-8091-e1686d91dfa5" width="800px">  


### 他のIDaaSと比べて何が違うの？  

1. 開発者ファーストなポリシー

「開発者の認証管理をシンプルに」を掲げて、2013年にAuth0を創業したユーへニオ・ペースさん。　　

<img src="https://github.com/emuzcode/study_auth0/assets/84742299/e8d5811d-b878-4c87-90bb-4ceaefe6ac78" width="800px">  　　

>常に意識していたことは...
>..1つ目は「シンプルであること」です。..
>..2つ目のゴールは「拡張性の高さ」。..

という思いがあったそう。　　
具体的に、SDK（ソフトウェア開発キット）の種類は６０以上！　　

連携するプラットフォームを選択すると、管理画面からサンプルプログラムのダウンロードや実際にサンプルプログラムを使って認証を行うまでに必要な手順や定義が表示されます。開発者は画面に表示された手順に従うだけで簡単にAuth0での認証サービスを利用することができます。　　


2. 段階的にセキュリティレベルを調整できる（海外の銀行システムでも導入されている。）
3. 実績が豊富（大企業で導入実績）
4. 金額が抑えられる（他社と比べてtoC向き）
5. 複雑な認証への対応（写真を撮る際に免許証の情報も銀行に送るなど「eKYC」と呼ばれる認証の仕組みなどもカバー）


参考動画：　[公式HP](https://auth0.com/jp/why-auth0)

### ざっくりな構成図/アーキテクチャ

こちらの図をベースに解説していきます。  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/b88b2995-ab0e-46fa-b0a4-85fcb383d8ec" width="800px">  

> テナント （Tenant）

Auth0を使い始める際、まずはじめに作るのがアカウントとテナントです。テナントは、アカウント作成時に同時に作成できます。  
テナントにはこれからAuth0を使う上でのもっともベースとなる要素です。このテナント内に要素を追加したり、設定を行ったりすることで使いたいようにカスタマイズしていきます。  

> アカウント （Account）  

Auth0に作成したテナントを管理するためのアカウントです。通常、使い始める際にテナントと同時に作成します。
アカウントは以下のいずれかの方法で作成できます。  

- Email/Passwordで登録
- GitHubアカウント
- Googleアカウント
- Microsoftアカウント  

テナントとアカウントはN:Nの関係になっており、例えば1つのアカウントで複数のテナントを管理することができます。また、テナント内に新たにアカウントを招待することも可能です。  
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/dd92aded-7be6-4f34-bb48-712b2aad44b6" width="800px">  


> アプリケーション （Application）

アプリケーションはテナントに対してログインを実行する元となるクライアントのことです。ドキュメントによってはクライアント（Client）と記載されることもあります。

アプリケーションは以下のいずれかの種類を作成できます。

- Native/Mobile Application
- Single Page Web Application
- Regular Web Application
- Backend/API

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/0ab7baa8-bbf9-4078-8405-377000190c0d">  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/b0c4c0d1-76ac-4e6d-89d1-3755cf82e3c0">  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/0996f7de-f1b2-4f2d-9afa-8c343ad87091">  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/028fc3f4-e589-40ed-afd8-9e3165985e87">  


また、アプリケーションはテナント内に複数作成することができます。例えば作ろうとしているサービスをiOSアプリ、Androidアプリ、Webアプリで展開しようと思っている場合、3つのアプリケーションを用意します。  

<img src="https://github.com/emuzcode/study_auth0/assets/84742299/ef0049d2-a44f-46c2-b47a-70258f46f91e" width="800px">  

> コネクション （Connection） 

コネクションは簡単に言うと「ログインする方法」です。例えば「メールアドレス/パスワードでログインする」「Twitterでログインする」「Googleでログインする」などといった感じです。  
テナント内に以下の種類のコネクションを複数作成することができます。  

| 種類 | 説明 | 例 |
| :---- | :---- | :---- |
| Database Connection	 | Auth0または自身のデータベースに認証情報を保存する | メールアドレス/パスワード |
| Social Login | ソーシャルアカウントを使ってログインする | Google, Twitter, LINEなど |
| Passwordless System | ワンタイムコードを使ってログインする | 電話番号またはメールアドレス |

コネクションは、アプリケーション単位で有効/無効を設定します。例えばiOSアプリとAndroidアプリはTwitterログインとLINEログインを有効にし、管理用のWebアプリではSAMLのみを有効にするといったような構成が可能です。  

<img src="https://github.com/emuzcode/study_auth0/assets/84742299/6c4ed78c-4b44-4540-8e2c-c0cdeafcb80c" width="800px">  


### では実際に手を動かしていきましょう！！

# Lv.1 環境構築

1
```
git clone https://github.com/emuzcode/study_auth0.git
```

2
```
docker-compose build --no-cache
```

3
```
docker-compose run web rails db:create
```

4
```
docker-compose run web rails db:migrate
```

5
```
docker-compose up
```


以下URLにアクセスしサーバーが立ち上がればOK
```
http://localhost:3000
```

# Lv.2 他人のコードを読めるようになる！

## 簡単ログイン実装（確認のみ）

確認ができたら一旦落としましょう. Ctrl+C の後に 
```
docker-compose down 
```

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/77ad649d-95d3-4f00-bd87-ad10016989fb">  


# Lv.3 外部APIの世界へ！

## Auth0アカウントを作成する

1. Auth0 Quickstartページ

```
https://auth0.com/docs
```


2. サインアップをする


<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2de02a5c-5fe3-45a0-a864-78100a90ec62">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/0268772f-b4a9-4e51-94ed-809f86e9037c">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/d6bb4a2e-8060-4996-a611-e5d2fb8314d1">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/7fa381bd-0306-4ba9-a915-d99a0bc1ff30">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/1a28524e-9034-4f13-b887-a1fec6ab9e34">   

#### アカウント作成完了  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/4190e6f4-ba0c-4a31-b9a4-7474026613bf">   

#### 準備  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/65c3379b-ca5a-494e-a16d-621eac3e31a1">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/c75956e2-73cb-4491-a78a-817f36a149ac">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/f9f8a568-9567-4f3a-bc09-b24d096cba9d">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2b7ed0ca-b907-4a98-9189-d45dacb38df9">   

ルートディレクトリから以下のコマンドを実行  
```
touch .env
```

コピペしてください  
```
AUTH0_DOMAIN=""
AUTH0_CILENT_ID=""
AUTH0_CLIENT_SECRET=""
```

""の中に値を入れていきましょう  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2d6c58c2-808e-4055-9e61-779f5e5cac5d">  

次にAuth0の設定をしていきます  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/1d173a9e-4c5c-4c69-a0d7-08beb7e284ca">  

Allowed Callback URLs  
```
http://localhost:3000/auth/auth0/callback
```

Allowed Logout URLs  
```
http://localhost:3000
```

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/3e94a6bc-5cea-4820-8bce-86645358ea06">  




## 2種類のAuth0ログイン実装
1. [omniauth-auth0](https://rubygems.org/gems/omniauth-auth0) gemについて（ユニバーサルログイン実装）


>OmniAuth gemは、Web アプリケーションのマルチプロバイダー認証を標準化するライブラリです。 強力かつ柔軟で、できる限り最小限の処理を行うように作成されました。

簡単にいうと、簡単にユニバーサルログインを実装できる便利なgemです！

2. [auth0](https://rubygems.org/gems/auth0) gemについて

>Auth0 ManagementAPI用の Rubyツールキット(CallbackサーバからAuth0テナントの情報を取得・管理などのカスタマイズ系)

簡単にいうと、Auth0のManagementAPIは、ユーザのCRUD操作やアプリケーションの画面設定、Auth0全体の設定を行うためのツールです！

# Lv.４ Auth0 - ユニバーサルログインを実装しよう!

## omniauth-auth0　gemについて

参考
```
https://auth0.com/docs/quickstart/webapp/rails/01-login
```

１ ルートディレクトリから以下のコマンドを実行
```
touch ./config/initializers/auth0.rb
```
2 以下をコピペ
```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV['AUTH0_CILENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
```

3  ルートディレクトリからDockerを立ち上げます

```
docker-compose up
```


4 ルートディレクトリから以下のコマンドを実行
```
docker-compose exec web rails generate controller auth0 callback failure logout --skip-assets --skip-helper --skip-routes --skip-template-engine
```

5
```
class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    # ログを見てみましょう！
    p auth_info['credentials']['id_token']
    redirect_to root_path
  end

  def failure
    p request.params['message']
    redirect_to login_path
  end

  def logout
    request_params = {
      returnTo: login_url,
      client_id: ENV['AUTH_CLIENT_ID']
    }
    URI::HTTPS.build(host: ENV['AUTH_DOMAIN'], path: '/v2/logout', query: request_params.to_query).to_s
  end
end

```

6 ./config/routes.rb

```
#Auth0
get '/auth/auth0/callback' => 'auth0#callback'
get '/auth/failure' => 'auth0#failure'
get '/auth/logout' => 'auth0#logout'
```

7 app/views/main/home.html.erb
```
<h1>Auth0接続確認</h1>
<%= button_to 'Login', '/auth/auth0', method: :post, data: { turbo: false } %>
```

では　[http://localhost:3000/](http://localhost:3000/) 

から確認してみましょう。　　先ほどの「Auth0接続確認」のボタンを押して、以下の画面が表示されたら成功です。  

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/e7d8db04-5e91-4923-80e3-cc4416e452b3">  

では次にサインアップまで移動してみましょう。  
ホーム画面が最後に表示されれば一旦ログインは完了です。

ここまでの遷移の流れ：  
ホーム画面　→ Auth0ログイン画面　→ ホーム画面

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/018a6f99-c45f-4c95-b37e-8ca1dd51fd5f">  


ここからユーザがちゃんと作成されたかわかります。
  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/ddedf34e-1681-4a6d-a85e-72a504f99694">  

では↑のユーザを一旦削除してから、既存のログイン機能に組み込んでViewからではなくControllerから先ほどのユニバーサル画面を表示してみましょう。

app/controllers/sessions_controller.rb
```
def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    #redirect_to root_path
    redirect_post('/auth/auth0', params: { prompt: 'login' },
      options: { method: :post, authenticity_token: 'auto' })
  else
    redirect_to login_path
  end
end
```

# Lv.5 Auth0のManagementAPIを使ってユーザ情報を取得してみよう！

## auth0　gemについて

APIを叩く準備をしましょう！  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/8185b5b4-57a2-4a83-9cd9-ce638a9ac1d7">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/af8b3d44-f518-4260-a0af-8446433ea19f">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/b3ea884d-6b9b-455c-a3a0-a1fe35c40ffc">   

<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/bad52a34-b951-46e1-a930-2f1b3ca4ea57">   

app/controllers/sessions_controller.rb
```
class SessionsController < ApplicationController
  require 'auth0'
  require 'uri'
  require 'cgi'
  require 'net/http'
  require 'openssl'

  #ログインページ
  def new
  end

  #ログイン処理
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    # ここから Auth0 API を叩く
    domain = ENV['AUTH0_DOMAIN']
    client_id = ENV['AUTH0_CLIENT_ID']
    client_secret = ENV['AUTH0_CLIENT_SECRET']
    # get access token
    url = URI("https://#{domain}/oauth/token")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/x-www-form-urlencoded'
    request.body = "grant_type=client_credentials&client_id=#{client_id}"
    request.body << "&client_secret=#{client_secret}&audience=https://#{domain}/api/v2/"
    response = http.request(request)
    access_token = JSON.parse(response.read_body)["access_token"]
    client = Auth0Client.new(
      client_id: client_id,
      client_secret: client_secret,
      domain: domain,
      token: access_token,
      api_version: 2,
      timeout: 15
    )
    # auth0 gem のメソッド
    # https://www.rubydoc.info/gems/auth0/Auth0/Api/V2/Users#create_user-instance_method
    options = {fields: "email", include_fields: true}
    result = client.users_by_email(user.email, options)
    p result # ログを見てみましょう

    if user.email == result[0]['email'] #ここでRailsDBとAuth0DBの両方の値を確認してます。
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        #redirect_to root_path
        #redirect_post('/auth/auth0', params: { prompt: 'login' }, options: { method: :post, authenticity_token: 'auto' })
        p "ログイン成功"
        redirect_to root_path
      end
    else
      p "ログイン失敗"
      redirect_to login_path
    end 
  end
  
  #ログアウト処理
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end

```

では先ほどサインアップしたアカウントでもう一度ログインをしてみましょう
＊ここを開くとAuth0に登録されているユーザがみれます  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/98c0efc9-c634-44f9-87d2-f8c8f13fd7f3">  

では、やってみましょう  
<img width="800px" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/7ec689e3-f6c8-4e6b-bc40-c039b83e04a9">  

ログも一緒に見てみましょう。  
先ほどのAuth0のログイン画面（ユニバーサルログイン画面）は出てこなかったはずです。　　

# Lv.99 Auth0 - Embedded Login(ユニバーサルログインを表示しない)を実装しよう!

こちらの記事を紹介。  
Centralized Universal Login vs. Embedded Login
[https://auth0.com/docs/authenticate/login/universal-vs-embedded-login](https://auth0.com/docs/authenticate/login/universal-vs-embedded-login)

いかがでしたでしょうか。  
先ほどのAuth0のログイン画面（ユニバーサルログイン画面）は出てこなかったはずです。  



## 参考URL

ID管理分野でOktaによるAuth0の買収が完了、両サービスは今後も継続　　
https://it.impress.co.jp/articles/-/21450　　

Auth0(オースゼロ)とは？口コミや評判からメリット・デメリットを解説　　
https://locked.jp/blog/what-is-auth0/

Auth0の基本構成を図で理解する #Auth0JP  
https://dev.classmethod.jp/articles/auth0-architecture/

ただひたすらに、開発者のために。Auth0創業者が語る「認証・認可の未来」
https://zine.qiita.com/event/202302-okta/
