require 'spec_helper'

describe I18nInspector::ScopeGenerator::Rails do
  it "instantiates" do
    klass.new.should be_a(klass)
  end
  
  it "unfolds key" do
    klass.new.full_key(".bar", "/views/foo.erb").should eq("foo.bar")
  end
  
  it "doesn't unfold key" do
    klass.new.full_key("bar", "/views/foo.erb").should eq("bar")
  end
  
  it "doesn't unfold key" do
    klass.new.full_key(".bar", "/models/foo.rb").should eq("bar")
  end
  
  it "scope doesn't have underscore" do
    klass.new.full_key(".bar", "/views/_foo.erb").should eq("foo.bar")
  end
end