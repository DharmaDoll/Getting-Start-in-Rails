## todo..
- describe sample Schemafile
- describe basic application(routes.rb ... and so on)
  - https://iij.github.io/bootcamp/server-app/rails/#rails%E3%83%95%E3%82%9A%E3%83%AD%E3%82%B7%E3%82%99%E3%82%A7%E3%82%AF%E3%83%88%E3%81%AE%E4%BD%9C%E6%88%90
- https://guides.rubyonrails.org/getting_started.html#setting-the-application-home-page

# Build container
```sh
docker-compose build --no-cache
```
# Run container
```sh
#docker run -it --name rails getting-start-in-rails_web:latest bash
docker-compose up -d
```
# Create rails application
```sh
docker-compose exec web rails new .
docker-compose exec web rails s -p 3000 -b '0.0.0.0'
# https://qiita.com/mihooo24/items/250128057e108812a304
```
visit to http://localhot:3000

# Login to container　(or `docker-compose exec web` command)
```sh
docker exec -it rails_web bash
```
## Generate application
```sh
# Create endpoint
rails generate controller Welcome index
  create  app/controllers/welcome_controller.rb
  route  get 'welcome/index'
  create    app/views/welcome/index.html.erb
  create    test/controllers/welcome_controller_test.rb
  create    app/helpers/welcome_helper.rb
# Use scaffold
rails generate scaffold idea name:string desc:text
rails db:migrate RAILS_ENV=development
```
Visit to http://localhost:3000/ideas
## Application management by rake
```sh
rake --tasks
rake stats
rake --tasks
rake stats
rails routes
rails c # Type more commands..
```

# Generate and Migrate DB
```sh
rails g model Post title:string content:text
# https://qiita.com/ichihara-development/items/9e9a8454178947eb519d
rails db:create
rails db:migrate:status
```
## Use ridgepole
https://system.blog.uuum.jp/entry/2018/11/16/110000  
Ridgepole では Schemafile というファイルに Ruby DSL でテーブル定義を書き、 `ridgepole --apply` コマンドでそれをデータベースに反映します。
- Ridgepole は Schemafile に書かれたテーブル定義を、実際の DB に接続して DB 上のテーブル定義と比較します。もし Schemafile に書かれた定義と DB上の定義に差分があれば、その差分だけが ALTER TABLE文となって、DBに適用されます。
- ridgepoleはデフォルトでSchemafileがプロジェクトのルートパスにあるものとして動作する
```sh
rails db:create RAILS_ENV=development
cat > Schemafile <<EOF
create_table "machine_event_development_histories", force: true do |t|
    t.integer "machine_event_id", null: false
    t.string "development_user_name", null: false
    t.string "development_type", null: false
    t.timestamps
  end
add_index "machine_event_development_histories", ["created_at"], name: "machine_event_development_histories_from_created_at", using: "btree"
EOF
ridgepole --config ./config/database.yml --file ./Schemafile --apply
```
## DB managemant
```sh
cat myapp/config/database.yml
```

<!-- # Create application
```
root@21a7e94491af:/myapp# rails new .
root@21a7e94491af:/myapp# bundle exec rails s -p 3000 -b '0.0.0.0' &
``` -->