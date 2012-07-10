require 'kipatra/cipango'

module Kipatra
  class Server
    include Cipango

    def initialize(app_base)
      @app_base = app_base
    end

    def start
      @server = Cipango::Server.new
      udp = UdpConnector.new

      @server.connector_manager.connectors = [udp]

      app_context = SipAppContext.new
      app_context.context_path = '/'
      app_context.war = @app_base

      handler = SipContextHandlerCollection.new
      handler.add_handler app_context

      @server.application_router = DefaultApplicationRouter.new
      @server.handler = handler

      @server.start
    end

    def join
      @server.join
    end
  end
end
