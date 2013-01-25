require "sinatra"
require File.join(File.dirname(__FILE__), 'lib', 'rubygem_api')

class Server < Sinatra::Base

  configure  :production do 
    enable :logging
  end

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
    logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    logger.info params
    params.to_s
  end





end
