class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      erb :'users/signup', locals: {message: '你已经登陆了!'}
    end
  end

  post '/signup' do
    if params.values.any? {|value| value == ''} or User.find_by(:username => params[:username])
      erb :'users/signup', locals: {message: '嗯...可能是你递交了空的表单数据，或是用户名已存在'}
    else
      code = InviteCode.find_by(:code => params[:invite_code])

      if not code.nil? and code.used_by.nil?
        user = User.create(
            :username => params[:username],
            :password => params[:password]
        )

        InviteCode.find_by(:code => params[:invite_code]).update(:used_by => user.id)

        session[:user_id] = user.id

        erb :dashboard, locals: {message: '欢迎来到异次元世界', username: user.username}
      else
        erb :'users/signup', locals: {message: '钥匙不对。'}
      end

    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/'
    else
      erb :'users/login', locals: {message: '请不要尝试用奇奇怪的的东西登陆...'}
    end
  end

  get '/logout' do
    session.destroy
    redirect to '/'
  end

  get '/manage/users' do
    erb :'manage/users', locals: {users: User.all}
  end

  get '/manage/users/edit/:id' do
    begin
      erb :'/manage/edit_profile', locals: {user: User.find(params[:id])}
    rescue
      halt 500, '目标用户不存在'
    end
  end

  post '/manage/users/edit/:id' do
    begin
      user = User.find(params[:id])
      if params[:username]
        user.update(:username => params[:username])
      end
      if params[:new_password]
        user.update(:password => params[:new_password])
      end

      redirect to '/manage/users'

      rescue
        halt 500, '目标用户不存在'
    end
  end

  get '/manage/users/delete/:id' do
    id = params[:id].to_i

    halt 403, '你不能删除初始用户' if id == 1
    halt 403, '你不能删除自己' if id == current_user.id

    User.delete(id)
    InviteCode.find_by(:used_by => id).delete

    if request.xhr?
      {
          code: 200,
          message: "用户ID:#{params[:id]} 删除成功"
      }.to_json
    else
      redirect to '/manage/users'
    end
  end


end