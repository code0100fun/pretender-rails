module Pretender
  module Rails
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, env = @app.call(env)
        if headers['Content-Type'].to_s.include?("text/html")
          body = Pretender.server.inject(env.body)
          headers['Content-Length'] = Rack::Utils.bytesize(body.to_s).to_s
          return [status, headers, [body]]
        end

        [status, headers, env]
      end
    end
  end
end
