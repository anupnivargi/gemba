require "sinatra"
require File.join(File.dirname(__FILE__), 'lib', 'rubygem_api')

class Server < Sinatra::Base

  set :logging, true

  get "/" do
    @hooks = RubygemApi.web_hooks
    erb :index
  end

  get "/gems/:name" do
    RubygemApi.find(params[:name])
  end

  post "/" do
    RubygemApi.add_web_hook(params[:gem_name], params[:callback_url])
    redirect "/"
  end

  get "/callback" do
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts params
    status 200
  end





end
