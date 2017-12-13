require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'faker'
require './model.rb' #MVC 분리 (DB 모델)

set :bind, '0.0.0.0'

enable :sessions #앱에서 세션 활용할거임.

get '/' do
  @q_list = Question.all.reverse
  erb :index
end

get '/ask' do
  Question.create(
  :name => params["id"],
  :content => params["question"]
)
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )
  redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
end

get '/login' do
  erb :login
end

# 로그인?
# 1. 로그인 하려고 하는 사람이 우리 회원인지 검사
#   -User 데이터베이스에 있는 사람인지 확인
#   - 로그인 하려는 사람이 제출한 email이 UserDB에 있나 확인
# 2. 만약에 있으면 비밀번호 체크
# => 제출된 비번과 db 비번이 같나?
#   2-1. 만약에 맞으면
#   => 로그인 시킨다.
#   2-2. 틀리면
#   => 다시 비번 치라 한다.
# 3. 없으면
# => 회원가입 페이지로 보낸다.
get '/login_session' do
  # get은 pKey 기반으로 검색
  # all이 조건기반 검색함.
  # DataMapper 사용법 검색 ㄱ
  # all로 검색하면 배열로 결과가 나옴
  # []달기 귀찮으니까 first, last 를 쓰자
  @message = ""
  if User.first(:email => params["email"])
      if User.first(:email => params["email"]).password == params["password"]
        session[:email] = params["email"]
        #session은 해시로 동작.
        #{:email => "asd@qasd.com"}
        @message ="로그인이 되었음."
      else
        @message ="비번 틀렸다"
      end
  else
      @message = "해당 이메일의 유저가 없음"
  end

  erb :login_session
end

get '/logout' do
  session.clear
  redirect to '/'
end
