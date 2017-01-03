class OptionsController < ApplicationController
  get '/manage/options' do
    erb :'manage/options'
  end

  get '/manage/options/drop_all_log' do
    Log.delete_all

    redirect to '/manage/options'
  end
end