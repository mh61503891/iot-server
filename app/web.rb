require 'sinatra/base'
require 'tilt/coffee'
require 'tilt/sass'

module IoT
  class Web < Sinatra::Base

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
      require 'slim'
      Slim::Engine.set_default_options pretty: true
    end

    get '/' do
      slim :index
    end

    get '/index.js' do
      coffee :index
    end

    get '/index.css' do
      sass :index
    end

  end
end
