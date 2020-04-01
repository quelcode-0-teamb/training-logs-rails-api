FROM ruby:2.6.6-alpine3.11
#FROM 元となるイメージを指定

ENV APP_ROUTE=/training-logs-rails-api \
    RUNTIME_PACKAGES="linux-headers tzdata postgresql-dev postgresql less" \
    DEV_PACKAGES="build-base libxml2-dev libc-dev curl-dev make gcc g++" \
    LANG=en_US.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
# ENV 環境変数を設定
    # APP_ROUTE アプリのディレクトリ あとでワーキングディレクトリに指定
    # LANG デフォルトエンコーディングの設定
    # BUNDLE_JOBS bundle 並列処理数の設定
    # BUNDLE_RETRY ネットワークの接続またはGitリクエストの失敗時に、n回リトライ設定

WORKDIR $APP_ROUTE
# WORKDIR ワーキングディレクトリの指定

COPY Gemfile Gemfile.lock $APP_ROUTE/
# COPY コピーコマンド
    #ホストマシンのGemfile,Gemfile.lockをコンテナ内のアプリにコピーする

RUN apk update && \
    apk add --update --no-cache  $RUNTIME_PACKAGES && \
    apk add --update --virtual build-dependencies --no-cache $DEV_PACKAGES && \
    gem install --no-document bundler:2.1.4 && \
    bundle install && \
    rm -rf /usr/local/bundle/cache/* /usr/local/share/.cache/* /var/cache/* /tmp/* && \
    apk del build-dependencies
# RUN イメージビルドの際にコマンドを命令
# apk Alpine Linuxのパッケージマネージャ
    # apk update リポジトリ一覧を更新( リポジトリ追加・削除時には必ず実行する )
    # apk add インストール
      # --update インストール前にupdate実行 
      # --no-cache インストール後の不要なファイルを削除
      # --virtual インストールするパッケージをグルーピング グルーピングしたパッケージをまとめて削除
    # bundlerのインストール
    # bundle install
    # rm chacheファイルの消去
      # apk del パッケージdelete グルーピング

COPY . /$APP_ROUTE

COPY entrypoint.sh /usr/bin/
# ホストマシンのentrypoint.shをコンテナにコピー
RUN chmod +x /usr/bin/entrypoint.sh
# 実行権限の付与
ENTRYPOINT ["entrypoint.sh"]
# 起動するプロセスを指定
EXPOSE 3000
# 外部に公開するポートを指定

CMD ["rails", "server", "-p", "3000", "-b", '0.0.0.0']
# CMD コンテナ作成後に実行するコマンドを指定