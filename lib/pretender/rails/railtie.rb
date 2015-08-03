module Pretender
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "pretender.configure_rails_initialization" do
        ::Rails.application.middleware.use Pretender::Rails::Middleware
      end
    end
  end
end
