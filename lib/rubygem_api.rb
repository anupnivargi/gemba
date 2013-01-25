require "rest_client"
require "json"
class RubygemApi

  API_KEY = "3847514a6e50ae989c5a933f49b0aa49"

  BASE_URL = "https://rubygems.org"

  API_URL = "#{BASE_URL}/api/v1"

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
      delete "#{API}/web_hooks/remove", {:gem_name => gem, :url => callback_url}, :authorization => API_KEY
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
