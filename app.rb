require 'sinatra/base'

module IoT
  class App < Sinatra::Base

    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
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
