# encoding: utf-8

# This monkeypatch is needed to ensure the X-Frame-Options header is
# never set by rack-protection.
module Rack
  module Protection
    class FrameOptions < Base
      def call(env)
        status, headers, body = @app.call(env)
        [status, headers, body]
      end
    end
  end
end
