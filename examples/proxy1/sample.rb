before :request do
  log.info "REQUEST  : #{message.method} #{message.requestURI}"
end

before :response do
  log.info "RESPONSE : #{message.status} #{message.request && message.request.requestURI}"
end

invite 'sip:(:number)@(:domain).*' do
  proxy "sip:#{params[:number]}@#{params[:domain]}", {:record_route => true}
end

request do
end

response do
end
