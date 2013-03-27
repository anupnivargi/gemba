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

  #{"name":"sinatra","downloads":6496566,"version":"1.4.2","version_downloads":52536,"platform":"ruby","authors":"Blake Mizerany, Ryan Tomayko, Simon Rozet, Konstantin Haase","info":"Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort.","project_uri":"http://rubygems.org/gems/sinatra","gem_uri":"http://rubygems.org/gems/sinatra-1.4.2.gem","homepage_uri":"http://www.sinatrarb.com/","wiki_uri":"","documentation_uri":"http://www.sinatrarb.com","mailing_list_uri":"http://groups.google.com/group/sinatrarb/topics","source_code_uri":"http://github.com/sinatra/sinatra","bug_tracker_uri":"http://github.com/sinatra/sinatra/issues","dependencies":{"development":[],"runtime":[{"name":"rack","requirements":">= 1.5.2, ~> 1.5"},{"name":"rack-protection","requirements":"~> 1.4"},{"name":"tilt","requirements":">= 1.3.4, ~> 1.3"}]}}
  post "/callback" do
    status 200
  end
end
