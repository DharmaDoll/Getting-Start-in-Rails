FROM ruby:3.0.3

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq \
# パッケージのインストール
&& apt-get install -y nodejs npm vim iputils-ping net-tools sqlite3 \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn


# 作業ディレクトリの指定
WORKDIR /Getting-Start-in-Rails/myapp
COPY Gemfile /Getting-Start-in-Rails/myapp/
# COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
# RUN bundle exec rails new .

## Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
## Configure the main process to run when running the image
CMD ["tail", "-f", "/dev/null"]
# CMD ["rails", "server", "-b", "0.0.0.0"]
