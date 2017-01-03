class InviteCodeController < ApplicationController
  get '/manage/invite_code' do
    erb :'/manage/invite_code', locals: {invite_codes: InviteCode.all}
  end

  post '/manage/invite_code/generate' do
    params[:generate_amount].to_i.times do
      code = (0...15).map { ('a'..'z').to_a[rand(26)] }.join
      puts "Generated Code #{code}"
      redo if InviteCode.find_by :code => code
      InviteCode.create :code => code
    end

    redirect to '/manage/invite_code'
  end

  get '/manage/invite_code/delete/:id' do
    InviteCode.delete(params[:id])

    if request.xhr?
      {
          code: 200,
          message: "邀请码ID: #{params[:id]}已删除"
      }.to_json
    else
      redirect to '/manage/invite_code'
    end
  end
end