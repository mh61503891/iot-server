require 'faye/websocket'
require 'json'

module IoT
  class WebSocket

    def initialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      return @app.call(env) unless Faye::WebSocket.websocket?(env)

      ws = Faye::WebSocket.new(env, nil, ping: 15)

      ws.on :open do |event|
        p [:open, ws.object_id]
        @clients << ws
      end

      ws.on :message do |event|
        p [:message, event.data]
        @clients.each do |client|
          client.send event.data
        end
      end

      ws.on :close do |event|
        p [:close, ws.object_id, event.code]
        @clients.delete(ws)
        ws = nil
      end

      ws.rack_response
    end
  end
end
