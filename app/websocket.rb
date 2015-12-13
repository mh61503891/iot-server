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

      ws.on :open do |_event|
        p [:open, ws.object_id]
        @clients << ws
        # ws.send({ you: ws.object_id }.to_json)
        @clients.each do |client|
          client.send({ count: @clients.size }.to_json)
        end
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
        @clients.each do |client|
          client.send({ count: @clients.size }.to_json)
        end
        ws = nil
      end

      ws.rack_response
    end
  end
end
