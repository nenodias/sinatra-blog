# app.rb
require "sinatra"
set :database_file, "config/database.yml"
require "sinatra/activerecord"
require "./models.rb"
set :database, {:adapter =>'sqlite3', :database=>'db/development.sqlite3'}

get "/" do
	erb :index
end