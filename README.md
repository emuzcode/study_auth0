## 5/20 Auth0 ハンズオン用

### 概要

1. 統合認証の基本
2. Auth0とは 
3. 環境構築
4. 簡単ログイン実装
5. Auth0アカウントを作成する
6. 2種類のAuth0ログイン実装
7. omniauth-auth0　gem　について
8. auth0　gem　について

### 統合認証の基本
### Auth0とは
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

### 簡単ログイン実装

テストユーザー:
```email
test_user@test.com
```

```password
Pass1234@
```

### Auth0アカウントを作成する

### 2種類のAuth0ログイン実装
1. [omniauth-auth0](https://rubygems.org/gems/omniauth-auth0) gemについて
2. [auth0](https://rubygems.org/gems/auth0) gemについて
