require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'faker'

set :bind, '0.0.0.0'

# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Question
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :question, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Question.auto_upgrade!

get '/' do
  @q_list = Question.all.reverse
  erb :index
end

get '/ask' do
  name = params["id"]
  if (name == "my_id")
    name = Faker::Name.name
  end
  Question.create(
  :name => name,
  :question => params["question"]    
)
  redirect to '/'
end
