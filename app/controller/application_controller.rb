require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'

class ApplicationController < Sinatra::Base
  helpers WillPaginate::Sinatra::Helpers

  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set :public_folder => 'public'
    set :views => 'app/views'
    enable :sessions
    set :session_secret => 'nine-lives cat'

    Encoding.default_external = 'UTF-8'
  end

  not_found do
    erb :'/errors/404', locals: {message: "404 Not Found - #{request.url}"}
  end

  before '/manage/*' do
    pass if logged_in? and User.find(current_user.id)

    halt 403, '你登录了么？'
  end

  get '/' do
    if logged_in?
      erb :dashboard, locals: {username: current_user.username}
    else
      erb :welcome
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      begin
        User.find(session[:user_id])
      rescue
        session.destroy
        halt 500, '用户不存在或已被删除'
      end
    end

    def get_username_by_id(id)
      begin
        User.find(id).username
      rescue
        '用户不存在'
      end
    end

    def user_exist?(id)
      begin
        !!User.find(id)
      rescue
        false
      end
    end
  end
end