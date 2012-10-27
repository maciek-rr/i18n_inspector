require 'spec_helper'

describe I18nInspector do

  it "instantiates" do
    klass.new("", "").should be_a(klass)
  end
  
  it "returns undefined keys" do
    ii = klass.new("", "")
    ii.should_receive(:found_keys).and_return([:test_key])
    ii.should_receive(:defined_keys).and_return([])
    ii.undefined_keys.should eq([:test_key])
  end
  
  it "returns unused keys" do
    ii = klass.new("", "")
    ii.should_receive(:defined_keys).and_return([:test_key])
    ii.should_receive(:found_keys).and_return([])
    ii.unused_keys.should eq([:test_key])
  end
  
  it "returns defined keys" do
    ii = klass.new("", "")
    ii.should_receive(:dictionary_keys_from_file).and_return([:test_key ])
    ii.defined_keys.should eq([:test_key])
  end
  
end