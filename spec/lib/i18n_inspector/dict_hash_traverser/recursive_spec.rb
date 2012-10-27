require 'spec_helper'

describe I18nInspector::DictHashTraverser::Recursive do
  
  it "instantiates" do
    klass.new({}).should be_a(klass)
  end
  
  it "returns full keys" do
    r = klass.new({:en => {:foo => {:bar => 'test'}}})
    r.full_keys.should eq(['en.foo.bar'])
  end

  it "returns empty array" do
    r = klass.new({})
    r.full_keys.should eq([])
  end  
end