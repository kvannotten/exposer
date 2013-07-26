require 'spec_helper'

describe Exposer do
  it 'has a version number' do
    Exposer::VERSION.should_not be_nil
  end
  
  before :all do
    Exposer.get_host_details
    @response = Exposer.response
  end
  
  subject { @response }
  
  it { should have_key "host" }
  it { should have_key "port" }
  
  it "returns valid json" do
    expect { JSON.parse Exposer.response.to_json }.to_not raise_error
  end
  
  it "raises no error" do
    expect { Exposer.get_host_details }.to_not raise_error 
  end

end
