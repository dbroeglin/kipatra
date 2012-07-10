require 'kipatra/cipango'

module Kipatra
  class Server
    include Cipango

    def initialize(opts)
      @war, @app_file = opts[:war], opts[:app_file]
      unless @war || @app_file
        raise ArgumentError, "Either :war or :app_file must be defined"
      end
    end

    def start
      @server = Cipango::Server.new
      udp = UdpConnector.new

      @server.connector_manager.connectors = [udp]


      handler = SipContextHandlerCollection.new
      handler.add_handler sip_app

      @server.application_router = DefaultApplicationRouter.new
      @server.handler = handler

      @server.start
    end

    def join
      @server.join
    end

    private

    def sip_app
      ctxt = nil
      if @war
        ctxt = SipAppContext.new
        ctxt.context_path = '/'
        ctxt.war = @war
      else
        ctxt = SipAppContext.new('/', '/')
        proc = Proc.new {}
        servlet = eval(File.read(@app_file), proc.binding, @app_file)
        ctxt.add_sip_servlet SipServletHolder::new(servlet)
      end

      ctxt
    end
  end
end
