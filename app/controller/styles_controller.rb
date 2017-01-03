require 'sass'

class StylesController < ApplicationController
  get '/global.css' do
    scss :'styles/global'
  end
end