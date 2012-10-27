require 'spec_helper'

describe I18nInspector::KeyExtractor do
  it "initializes" do
    instance_with_proper_classes.should be_a(klass)
  end
  
  it "extracts keys from string" do
    instance_with_proper_classes.
      from_string("t(:key)", __FILE__).
      should eq(['key'])
  end
  
  it "extracts keys from file" do
    # t(:weird_test), shouldn't really extract from comments
    instance_with_proper_classes.
      from_files([__FILE__]).
      should eq(['weird_test'])
  end
  
  it "delegates key extraction to extractor_backend_class" do
    test_string = 'foo'
    extractor_backend = I18nInspector::ExtractorBackend::Regexp.new
    I18nInspector::ExtractorBackend::Regexp.should_receive(:new).
      and_return(extractor_backend)
    extractor_backend.should_receive(:extract_from_string).
      with(test_string).and_return([])
    instance_with_proper_classes.from_string(test_string, '').should 
      eq([])
  end
  
  it "delegates generating scope to scope_generator_class" do
    test_string = 't(:foo)'
    scope_generator = I18nInspector::ScopeGenerator::Rails.new
    I18nInspector::ScopeGenerator::Rails.should_receive(:new).
      and_return(scope_generator)
    scope_generator.should_receive(:full_key).with("foo", __FILE__).
      and_return("foo")
    instance_with_proper_classes.from_string(test_string, __FILE__).
      should eq(["foo"])
  end

  protected
  
  def instance_with_proper_classes
    klass.new(I18nInspector::ExtractorBackend::Regexp,
      I18nInspector::ScopeGenerator::Rails)
  end
end
