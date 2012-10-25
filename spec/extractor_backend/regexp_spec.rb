require 'spec_helper'
require 't_call_variations'

describe I18nInspector::ExtractorBackend::Regexp do
  extend TCallVariations
  
  t_call_variations('test.key').each do |call_variation|
    it "parses string key #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test.key'])
    end
  end

  t_call_variations(:test_sym).each do |call_variation|
    it "parses symbol key #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test_sym'])
    end 
  end
  
  t_call_variations('test.key', :scope => [:test, :scope]).each do |call_variation|
    it "parses string key with scope param #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test.scope.test.key'])
    end
  end

  t_call_variations(:test_sym, :scope => [:test, :scope]).each do |call_variation|
    it "parses symbol key with scope param #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test.scope.test_sym'])
    end
  end

  t_call_variations(:test_sym, :scope => 'test.scope').each do |call_variation|
    it "parses symbol key with scope param #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test.scope.test_sym'])
    end
  end

  t_call_variations(:test_sym, :scope => 'test').each do |call_variation|
    it "parses symbol key with scope param #{call_variation}" do
      r = klass.new
      r.extract_from_string(call_variation).should eq(['test.test_sym'])
    end
  end  
end