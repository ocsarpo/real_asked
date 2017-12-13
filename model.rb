# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/asked.db")

class Question
  include DataMapper::Resource #DataMapper 객체로 Question 클래스 정의
  property :id, Serial
  property :name, String
  property :content, Text
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :is_admin, Boolean, :default => false
  property :created_at, DateTime
end

DataMapper.finalize     #위 형태로 테이블 확실히 만들게

Question.auto_upgrade!
User.auto_upgrade!
