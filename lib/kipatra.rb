require 'kipatra/cipango'

module Kipatra
  class Server
    include Cipango

    def initialize(opts)
      @war, @app_file, @sipatra, @tcp, @udp = opts[:war], opts[:app_file], opts[:sipatra], opts[:tcp], opts[:udp]
      # useless
      unless @war || @app_file
        raise ArgumentError, "Either :war or :app_file must be defined"
      end
    end

    def start
      @server = Cipango::Server.new

      @server.connector_manager.connectors = manage_connectors

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

    def manage_connectors
      conns = []

      @udp.each do |args|
        conn = UdpConnector.new
        conn.host, conn.port = args[:host], args[:port]
        conns << conn
      end

      @tcp.each do |args|
        conn = TcpConnector.new
        conn.host, conn.port = args[:host], args[:port]
        conns << conn
      end

      conns
    end

    def sip_app
      ctxt = nil
      if @war
        ctxt = SipAppContext.new
        ctxt.context_path = '/'
        ctxt.war = @war
      elsif @sipatra
        ctxt = SipAppContext.new('/', '/')
        proc = Proc.new {}
        servlet = eval(File.read(File.expand_path(File.join(File.dirname(__FILE__), '../lib/sipatra_app.rb'))), proc.binding, 'lib/sipatra_app.rb')
        ctxt.add_sip_servlet SipServletHolder::new(servlet)
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
