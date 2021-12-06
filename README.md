
### Create a dir for your project
```shell
mkdir blog_sinatra
cd blog_sinatra
```

### Create Gemfile
```shell
touch Gemfile
```

```Gemfile
#Gemfile
source "http://rubygems.org"

gem "sinatra-activerecord"
gem "rake"
gem "sqlite3"
```

### Run bundle update for fetch the dependencies
```shell
bundle update
```


### Create Rakefile
```shell
touch Rakefile
```
```Rakefile
#Rakefile

require "sinatra/activerecord"
require "sinatra/activerecord/rake"
require "./app"
```

### Create your app file
```shell
touch app.rb
```
```app.rb
# app.rb
require "sinatra"
require "sinatra/activerecord"
```

### Create database config
```shell
mkdir config
touch config/database.yml
```
```database.yml
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000
```


### Run bundle exec rake db:create
```shell
bundle exec rake db:create
```

### Run bundle exec rake db:create_migration NAME=create_posts
```shell
bundle exec rake db:create_migration NAME=create_posts
```
then something like ```db/migrate/20211204124204_create_posts.rb``` will be created.

### Running bundle exec rake -T you can see all commands available for rake
```shell
bundle exec rake -T
```

### Change the migration with create_table
```db/migrate/20211204124204_create_posts.rb
class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.timestamps null: false
    end
  end
end
```

### Running bundle exec rake db:migrate for creating the table posts
```shell
bundle exec rake db:migrate
```

### Adding database config to the app.rb
The set database_file must stay before 'require "sinatra/activerecord"'
```app.rb
# app.rb
require "sinatra"
set :database_file, "config/database.yml"
require "sinatra/activerecord"
```

### Creating models.rb
```shell
touch models.rb
```

```models.rb
#models.rb
class Post < ActiveRecord::Base
end
```
### Change the app for requiring the models.rb file
```app.rb
# app.rb
require "sinatra"
set :database_file, "config/database.yml"
require "sinatra/activerecord"
require "./models.rb"
```

### Change the app for connecting to development database
```app.rb
# app.rb
require "sinatra"
set :database_file, "config/database.yml"
require "sinatra/activerecord"
require "./models.rb"
set :database, {:adapter =>'sqlite3', :database=>'db/development.sqlite3'}
```

### Now you can try irb for creating and get the Posts
```shell
irb
require "./app"
# Creating the Post
Post.create(title:"Hello World", body:"It's a pleasure seeing you're here!!!")
# Getting all the Posts
Post.all
```

### TODO add some examples using ActiveRecord


### Install gems for sinatra
```shell
gem install thin puma reel http webrick
```

### Adding the root route at app.rb
```app.rb
# app.rb
require "sinatra"
set :database_file, "config/database.yml"
require "sinatra/activerecord"
require "./models.rb"
set :database, {:adapter =>'sqlite3', :database=>'db/development.sqlite3'}

get "/" do
	erb :index
end
```

### Creating the view file for root page
```shell
mkdir views
touch views/index.erb
```

```views/index.erb
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Sinatra Blog</title>
</head>
<body>
 <h1>Hello world</h1>
</body>
</html>
```

### ERB tags
```
<% Ruby code -- inline with output %>
<%= Ruby expression -- replace with result %>
<%# comment -- ignored -- useful in testing %>
```