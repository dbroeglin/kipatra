require 'spec_helper'

describe Kipatra::SipatraServlet do
  it { should respond_to :doRequest }
  it { should respond_to :doResponse }
end
