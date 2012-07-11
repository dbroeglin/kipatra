require 'sipatra'

invite 'sip:(:number)@(:domain).*' do
  proxy "sip:#{params[:number]}@#{params[:domain]}", {:record_route => true}
end

request do
end

response do
end
