require "rest_client"
require "json"
require 'yaml'
class RubygemApi

  $config = YAML.load_file("config/rubygem.yml")[ENV['RACK_ENV']]

  API_KEY = $config['api_key']

  API_URL = $config['api_url']
  class << self

    def find(gem, params={})
      get "#{API_URL}/gems/#{gem}.json" 
    end

    def web_hooks
      get "#{API_URL}/web_hooks.json", :authorization => API_KEY
    end

    def add_web_hook(gem, callback_url)
      post "#{API_URL}/web_hooks.json", {:gem_name => gem, :url => callback_url}, :authorization => API_KEY
    end

    def remove_web_hook(gem, callback_url)
      delete "#{API_URL}/web_hooks/remove", {:gem_name => gem, :url => callback_url}, :authorization => API_KEY
    end

    def get(url, params={})
      parse(RestClient.get url, params)
    end

    def post(url, params={}, headers={})
      RestClient.post url, params, headers
    end

    def delete(url, params={}, headers={})
      RestClient.delete url, params, headers
    end

    def parse(json)
      JSON.parse(json)
    end

  end



end
