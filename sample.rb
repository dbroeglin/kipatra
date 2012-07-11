begin
  load 'sample_sipatra_app.rb'
rescue Exception => e
  puts "Load Error : #{e.inspect}"
end

class S < Kipatra::Cipango::SipServlet
  class Log
    def method_missing(*args)
      puts args.join " "
    end
  end

  def doRequest(req)
    invoke req, :do_request
  end

  def doResponse(req)
    invoke req, :do_response
  end

  private

  def invoke(msg, method_name)
    log = Log.new
    app = Sipatra::Application::new
    session = msg.session
    app.set_bindings session.servlet_context, session.servlet_context.getAttribute(Kipatra::Cipango::SipServlet::SIP_FACTORY), session, msg, log
    app.send method_name
  end
end

S.new
