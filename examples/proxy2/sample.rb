require 'thread'

class Tutu
  attr_accessor :c
  attr_reader :semaphore, :t

  def initialize
    @c = 0
    @t = 0
    @semaphore = Mutex.new
  end

  @@instance = Tutu.new

  def self.instance
    @@instance
  end

  def increment
    semaphore.synchronize do
      @c = @c + 1
      @t = @t + 1
    end
  end

  def decrement
    semaphore.synchronize do
      @c = @c - 1
    end
  end

  private_class_method :new
end

t = Thread.new('tutu') do
  log = Logger.getLogger('Registry')
  loop do
    log.info "NB : #{Tutu.instance.c} (#{Tutu.instance.t})"
    sleep 10
  end
end

before :request do
  log.info "REQUEST  : #{message.method} #{message.requestURI}"
end

before :response do
  log.info "RESPONSE : #{message.status} #{message.request && message.request.requestURI}"
end

invite 'sip:(:number)@(:domain).*' do
  Tutu.instance.increment
  #log.info "NB : #{Tutu.instance.c}"
  proxy "sip:#{params[:number]}@#{params[:domain]}", {:record_route => true}
end

bye do
  Tutu.instance.decrement
  #log.info "NB : #{Tutu.instance.c} (#{Tutu.instance.t})"
end

request do
end

response do
end
