require 'cucumber'
require 'capybara/cucumber'

module Pretender
  module Rails
    module CucumberHelper
      def stub(method, route, response)
        Pretender.server.stub(method, route, response)
      end
    end
  end
end

World(Pretender::Rails::CucumberHelper)

After do
  Pretender.server.shutdown(page)
end
