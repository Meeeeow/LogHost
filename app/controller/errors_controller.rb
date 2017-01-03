class ErrorsController < Sinatra::Base
  configure do
    set :views => 'app/views'
  end

  error 400..499 do
    type = %w[application/json text/html]
    if request.preferred_type(type) == 'application/json'
      if body.empty?
        {message: '我也不知道发生了什么...', code: status}.to_json
      else
        {message: body.join, code: status}.to_json
      end
    else
      if body.empty?
        erb :'/errors/4xx', locals: {message: '我也不知道发生了什么...', code: status}
      else
        erb :'/errors/4xx', locals: {message: body.join, code: status}
      end
    end
  end

  error 418 do
    erb :'/errors/418', locals: {message: body.join}
  end

  error 500..599 do
    type = %w[application/json text/html]

    if request.preferred_type(type) == 'application/json'
      if body.empty?
        {message: '服务器上发生了一些不可描述的事...', code: status}.to_json
      else
        {message: body.join, code: status}.to_json
      end
    else
      if body.empty?
        erb :'/errors/5xx', locals: {message: '服务器上发生了一些不可描述的事...', code: status}
      else
        erb :'/errors/5xx', locals: {message: body.join, code: status}
      end
    end
  end
end