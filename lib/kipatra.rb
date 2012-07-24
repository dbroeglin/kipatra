require 'kipatra/cipango'
require 'kipatra/sipatra'

module Kipatra
  class Server
    include Cipango

    def initialize(opts)
      @war, @app_file, @tcp, @udp = opts[:war], opts[:app_file], opts[:tcp], opts[:udp]
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

      if @udp.empty? and @tcp.empty?
        @udp = [{:host => '0.0.0.0', :port => 5060}]
      end

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
      else
        ctxt = SipAppContext.new('/', '.')
        proc = Proc.new {}
        begin
          load @app_file
        rescue Exception => e
          raise "Sipatra Load Error : #{e.inspect}\n#{e.backtrace.join("\n")}"
        end
        ctxt.add_sip_servlet SipServletHolder.new(SipatraServlet.new)
      end

      ctxt
    end
  end
end
