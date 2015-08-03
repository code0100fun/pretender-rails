module Pretender
  def self.server
    @_server ||= ::Pretender::Rails::Server.new
  end

  module Rails
    class Server
      Stub = Struct.new(:method, :route, :response)
      attr_accessor :session

      def inject(body)
        unless stubs.empty?
          head_pos = body.index('</head>')
          body.insert(head_pos, scripts) if head_pos
        end
        body
      end

      def shutdown(page)
        stubs.clear
        page.execute_script('typeof(server) !== "undefined" && server.shutdown();')
      end

      def stub(method, route, response)
        stub = Stub.new(method, route, response)
        stubs.unshift stub
        stub
      end

      private

      def stubs
        @_stubs ||= []
      end

      def routes
        stubs.map do |stub|
          "this.#{stub.method}('#{stub.route}', function(request) { return #{stub.response.to_json}; });"
        end.join("\n")
      end

      def load_script(path)
        open(path).read
      end

      def scripts
        [dependencies_script, server_script].join("\n")
      end

      def dependencies_script
        [javascript_include_tag('fake_xml_http_request.js'),
         javascript_include_tag('route-recognizer.js'),
         javascript_include_tag('pretender.js')].join("\n")
      end

      def javascript_include_tag(url)
        "<script src=\"/assets/#{url}\"></script>"
      end

      def server_script
        <<-JS
<script>
  var server = new Pretender(function(){
    #{routes}
    this.get('*any', this.passthrough);
    this.post('*any', this.passthrough);
    this.put('*any', this.passthrough);
    this.delete('*any', this.passthrough);
  });
</script>
        JS
      end
    end
  end
end
