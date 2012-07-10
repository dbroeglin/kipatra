require 'java'
%w(
cipango-dar-2.0.0.jar
cipango-deploy-2.0.0.jar
cipango-server-2.0.0.jar
jetty-continuation-7.2.2.v20101205.jar
jetty-http-7.2.2.v20101205.jar
jetty-io-7.2.2.v20101205.jar
jetty-security-7.2.2.v20101205.jar
jetty-server-7.2.2.v20101205.jar
jetty-servlet-7.2.2.v20101205.jar
jetty-util-7.2.2.v20101205.jar
jetty-webapp-7.2.2.v20101205.jar
jetty-xml-7.2.2.v20101205.jar
servlet-api-2.5.jar
sip-api-1.1.jar
).each {|name| require "kipatra/cipango/#{name}" }

module Kipatra
  module Cipango
    java_import "org.cipango.server.bio.UdpConnector"
    java_import "org.cipango.server.bio.TcpConnector"
    java_import "org.cipango.server.Server"
    java_import "org.cipango.server.handler.SipContextHandlerCollection"
    java_import "org.cipango.sipapp.SipAppContext"
    java_import "org.cipango.dar.DefaultApplicationRouter"


    java_import "org.cipango.servlet.SipServletHolder"
    java_import "javax.servlet.sip.SipServlet"
    java_import "org.cipango.server.log.FileMessageLog"

    java_import "org.cipango.servlet.SipServletHolder"
  end
end

