## 5/20 Auth0 ハンズオン用

### 概要

1. 統合認証の基本
2. Auth0とは 
3. 環境構築
4. 簡単ログイン実装
5. Auth0アカウントを作成する
6. 2種類のAuth0ログイン実装
7. omniauth-auth0 gem について
8. auth0 gem について

### 統合認証の基本

統合認証とは、社内のイントラネットやクラウドサービスなど複数のシステムを利用する際に、適正ユーザーが適正なシステムにアクセスするため、**ユーザーの認証やIDの管理などを統合的に行うための仕組み**のことをいいます。

つまり**システムにログインするときに必要になる認証情報を一元化して管理・監視すること**です。この統合認証に必要なシステムのことを「**統合認証基盤**」と呼びます。

なぜこの「**統合認証基盤**」が必要なのか

1. 利便性の向上

統合認証にはSSO（シングルサインオン）の機能がついています。一度の認証で異なるサービスやシステムを利用できることはユーザーにとって便利です。さらにID管理システムを利用すれば、システム管理者も手間をかけずにID・パスワードの変更や管理を行えます。

2. セキュリティの向上

ファイヤーウォールなどのマルウェア対策や、暗号化などのハッキング対策は、外部からの攻撃を想定したものです。しかし、これらは**内部の人間による侵入には効果を発揮しません。ログ監視システムやワンタイムパスワード、特権ID管理によって内部の人間による侵入を防げます。**

また、1つのシステム基盤にまとめて管理することに不安を感じるかもしれません。しかし、**現状として多くのビジネスパーソンが同一のIDとパスワードを使いまわしていること、1つのシステムさえ保守すれば良いことを考えると、セキュリティの面でもメリットがある**といえます。

この統合認証は、ユーザー認証を総合的に行うもので細分化するといくつかの種類に分かれます。
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/3a4ce997-29e2-4f3a-b6b9-ada1a38d13fe" width="320px">

- ID管理（アイデンティティ管理）
ID管理ツールを利用することで、IDを一元化して管理できます。変更が必要になった時でも1つのデータを書き換えれば済むので、非常に便利です。

- SSO（シングルサインオン）
SSOは、ユーザー認証を一度終えればさまざまなサービスにアクセス可能になるシステムのことで、クラウドサービスの普及に伴って利用する機会が増えてきました。

- ワンタイムパスワード
ワンタイムパスワードは時間が経つとパスワードが無効になるため、強い影響力を持ったシステムを固定のパスワードよりも安全に運用できます。

- 特権ID管理
ワンタイムパスワードと似た考えですが、システム管理において高い権限を付与されたIDのことを特権IDといいます。特権IDの管理を怠ると重大な障害につながる可能性があります。

- ログ監視
インターネットの使用履歴を監視し、異常を検知するのがログ監視です。


*IDaaSとの関連*

統合認証とよく似た考えで、IDaaSというものがあります。IDaaSは、Identity as a Serviceの略で、IDなどログイン情報の管理をクラウドで行えるようにしたサービスを指しています。しかしIDaaSという概念では、ログ監視などID管理以上のセキュリティを想定していません。ここに両者の違いがあります。

### Auth0とは

Auth0 Inc.は2013年に米国Microsoftに在籍していたメンバーを中心に創業した会社で、Washington州Bellevueに本社があります。創業メンバーはEugenio Pace(CEO), Matias Woloski(CTO)　などMicrosoftに在籍していたメンバーのほか、Node.jsの認証フレームワークである"Passport"の開発者であった Jered Hanson, AT&T, Amazon.com, 国防総省での勤務経験のある Eugen Koganも創業メンバーです。

Auth0 統合認証プラットフォーム

Auth0はWebアプリやモバイル、APIなどに対して認証・認可のサービスをクラウドで提供している、いわゆるIDaaS (Identity as a Service)ベンダーです。企業がもつWebアプリケーションやAPI, Native Mobile Appなどでユーザー認証や認可、セキュリティを組み込みたいけれでも実装が難しい・・・という方にオススメのソリューションを提供しています。

既存の統合認証プロダクトと何が違うのか

- Web APP, Mobile Native AppやWeb API、Single Page Applicationに対応
- 多要素認証(MFA)に対応
- Passwordless認証に対応

豊富なサンプルソース

アプリケーションとAuth0間で使用される標準プロトコルは、最新で軽くて利用や統合がしやすいOpenID ConnectやOAuth2.0です。Auth0は主だったプラットフォーム (.NET, Java, PHP, Python, node, iOS, など)向けのSDKを提供していますが、Auth0 SDKを使用することは必須ではありません。認証・認可用にRESTfulなAuthentication APIを公開しており、HTTPリクエストを送信することができればAuth0と連携することが可能です。Native, SPA, Web/App Server, CLIなど約80種類のフレームワークに対するサンプルプロジェクトをgithubに公開しており、これを利用することで簡単に既存アプリケーションをAuth0と連携することができます。(主だったものはAuth0の ドキュメント ページや管理ダッシュボードのApplicationページから構成方法も含めてアクセス可能です)。Auth0はその他にもWS-FederationやSAMLと言った一般的なFederation Protocolにも対応しており、ADFSや外部IdPとAuth0に対応させたアプリケーションに対してはSAML SPとして、SAML対応のSaaSアプリケーションにはSAML IdPとして簡単に連携することができます。

<img src="https://github.com/emuzcode/study_auth0/assets/84742299/45ab7968-3c82-4e39-945d-51caf08aeb78" width="1440px">
<img src="https://github.com/emuzcode/study_auth0/assets/84742299/e6237314-8bd2-4d37-8908-ab2c5f3712a9" width="1440px">

連携するプラットフォームを選択すると、管理画面からサンプルプログラムのダウンロードや実際にサンプルプログラムを使って認証を行うまでに必要な手順や定義が表示されます。開発者は画面に表示された手順に従うだけで簡単にAuth0での認証サービスを利用することができます。

### 環境構築

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
docker-compose up
```


以下URLにアクセスしサーバーが立ち上がればOK
```
http://localhost:3000
```

### 簡単ログイン実装（済みなので確認）

```
docker-compose exec rails db:migrate:reset
```

確認ができたら一旦落としましょう. Ctrl+C の後に 
```
docker-compose down 
```

### Auth0アカウントを作成する

1. Auth0 Quickstartページ

```
https://auth0.com/docs
```


2. サインアップをする


<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2de02a5c-5fe3-45a0-a864-78100a90ec62">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/0268772f-b4a9-4e51-94ed-809f86e9037c">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/d6bb4a2e-8060-4996-a611-e5d2fb8314d1">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/7fa381bd-0306-4ba9-a915-d99a0bc1ff30">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/1a28524e-9034-4f13-b887-a1fec6ab9e34">

アカウント作成完了
<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/4190e6f4-ba0c-4a31-b9a4-7474026613bf">

準備
<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/65c3379b-ca5a-494e-a16d-621eac3e31a1">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/c75956e2-73cb-4491-a78a-817f36a149ac">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/f9f8a568-9567-4f3a-bc09-b24d096cba9d">

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2b7ed0ca-b907-4a98-9189-d45dacb38df9">

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

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/2d6c58c2-808e-4055-9e61-779f5e5cac5d">

次にAuth0の設定をしていきます

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/1d173a9e-4c5c-4c69-a0d7-08beb7e284ca">

Allowed Callback URLs
```
http://localhost:3000/auth/auth0/callback
```

Allowed Logout URLs
```
http://localhost:3000
```

<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/3e94a6bc-5cea-4820-8bce-86645358ea06">



### 2種類のAuth0ログイン実装
1. [omniauth-auth0](https://rubygems.org/gems/omniauth-auth0) gemについて

OmniAuth は、Web アプリケーションのマルチプロバイダー認証を標準化するライブラリです。 強力かつ柔軟で、できる限り最小限の処理を行うように作成されました。

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

では　http://localhost:3000/　から確認してみましょう
この画面が表示されたら成功です。
<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/e7d8db04-5e91-4923-80e3-cc4416e452b3">

試しにサインアップしてみましょう。
ホーム画面が最後に表示されれば一旦ログインは完了です。

遷移の流れ：
ホーム画面　→ Auth0ログイン画面　→ ホーム画面

ここからユーザがちゃんと作成されたかわかります。
<img width="1440" alt="image" src="https://github.com/emuzcode/study_auth0/assets/84742299/ddedf34e-1681-4a6d-a85e-72a504f99694">

では既存のログイン機能に組み込んでみましょう

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



2. [auth0](https://rubygems.org/gems/auth0) gemについて

app/controllers/users_controller.rb
```
class UsersController < ApplicationController
  require 'auth0'
  require 'uri'
  require 'cgi'
  require 'net/http'
  require 'openssl'

  skip_before_action :verify_authenticity_token

  #新規登録ページ
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #@user.auth0_id = "仮のpassword"

    # ここから Auth0 API を叩く
    domain = ENV[AUTH0_DOMAIN]
    client_id = ENV[AUTH0_CLIENT_ID]
    client_secret = ENV[AUTH0_CLIENT_SECRET]
    
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

    @client = Auth0Client.new(
      client_id: client_id,
      client_secret: client_secret,
      domain: domain,
      token: access_token,
      api_version: 2,
      timeout: 15
    )
    
    result = signup_to_auth0(user.email, user.password)
    user.auth0_id = result['user_id']
    if @user.save
      redirect_to login_path
    else
      redirect_to signup_path
    end
  end

  def signup_to_auth0(email, password)
    connection = "Username-Password-Authentication"
    options = {email: email, password: password, email_verified: false}
    @client.create_user connection, options
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end

```

Auth0 API 用の Ruby ツールキット
