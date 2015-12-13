require 'sinatra/base'
require 'slim'

module IoT
  class Web < Sinatra::Base

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
      Slim::Engine.set_default_options pretty: true
    end

    get '/' do
      slim :index
    end

    get '/index.js' do
      coffee :index
    end

    post '/' do
    end

  end
end
