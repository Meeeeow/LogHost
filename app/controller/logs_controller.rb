class LogsController < ApplicationController
  get '/manage/logs' do
    erb :'/manage/logs', locals: {logs: Log.paginate(:page => params[:page], :per_page => 10).order('id DESC')}
  end

  options '/log/create' do
    headers \
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Headers' => 'Content-Type'
  end

  post '/log/create' do
    headers 'Access-Control-Allow-Origin' => '*'

    request.body.rewind
    begin
      req = JSON.parse(request.body.read)
    end

    halt 400, '上传的数据格式不正确' unless req
    halt 400, '数据不完整' unless ['username', 'uid', 'content'].all? { |k| req.key? k }

    begin
      log = Log.create(
          :created_by => req['username'],
          :created_by_uid => req['uid'],
          :description => req['description'] || nil,
          :content => req['content']
      )
    rescue => error
      halt 500, "日志创建失败 #{error}"
    end


    {
        code: 200,
        message: "Log ID: #{log.id}"
    }.to_json
  end

  get '/manage/logs/delete/:id' do
    begin
      Log.delete(params[:id])
    rescue => error
      halt 500, "删除日志失败： #{error}"
    end

    if request.xhr?
      {
          code: 200,
          message: 'Success'
      }.to_json
    else
      redirect to '/manage/logs'
    end
  end

  get '/manage/logs/view/:id' do
    begin
      erb :'/manage/view_log', locals: {log: Log.find(params[:id])}
    rescue
      halt 500, '日志不存在'
    end
  end

  get '/manage/logs/resolve/:id' do
    halt 418, '功能暂未实现'
  end
end