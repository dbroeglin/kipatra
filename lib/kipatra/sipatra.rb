require 'sipatra'
require 'logger'
#require 'sipatra/log4j-1.2.17.jar'
#include_class 'org.apache.log4j.Logger'
#
#if File.exists?('log4j.properties')
#  include_class 'org.apache.log4j.PropertyConfigurator'
#  PropertyConfigurator.configure(File.join(File.expand_path(Dir.pwd), 'log4j.properties'))
#else
#  include_class 'org.apache.log4j.BasicConfigurator'
#  BasicConfigurator.configure
#end


module Kipatra
  class SipatraServlet < Kipatra::Cipango::SipServlet
    def doRequest(req)
      invoke req, :do_request
    end

    def doResponse(req)
      invoke req, :do_response
    end

    private

    def invoke(msg, method_name)
      begin
        log = Logger.new(STDOUT)
        app = Sipatra::Application::new
        session = msg.session
        app.set_bindings session.servlet_context, session.servlet_context.getAttribute(Kipatra::Cipango::SipServlet::SIP_FACTORY), session, msg, log
        app.send method_name
      rescue => e
        # TODO XXX
        puts "SIPATRA EXCEPTION: #{e}\n#{e.backtrace.join("\n")}"

      end
    end
  end
end
