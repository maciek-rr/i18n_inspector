require 'spec_helper'

describe I18nInspector::DictParser do
  
  it "initializes" do
    klass.new("anyfile", traverser_class, yml_parser_class).should be_a(klass)
  end
  
  it "delegates to traverser_class" do
    obj = traverser_class.new
    obj.should_receive(:full_keys).and_return([])    
    traverser_class.should_receive(:new).and_return(obj)
    dp = klass.new("anyfile", traverser_class, yml_parser_class)
    dp.full_keys.should eq([])
  end
  
  it "uses yml_parser_class" do
    obj = traverser_class.new
    obj.should_receive(:full_keys).and_return([])
    traverser_class.should_receive(:new).and_return(obj)
    yml_parser_class.should_receive(:load_file).and_return({})
    dp = klass.new("anyfile", traverser_class, yml_parser_class)
    dp.full_keys.should eq([])
  end
  
  protected
  
  def traverser_class
    @traverser_class ||= Class.new(Object)
  end

  def yml_parser_class
    @yml_parser_class ||= Class.new(Object) do
      def self.load_file(*args) {}; end
    end
  end
end