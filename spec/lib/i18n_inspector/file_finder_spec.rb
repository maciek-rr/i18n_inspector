require 'spec_helper'

describe I18nInspector::FileFinder do
  
  it "initializes" do
    klass.new("").should be_a(klass)
  end
  
  it "searches rb files" do
    klass.new(File.dirname(__FILE__)).files.
      grep(/file_finder_spec\.rb/).count.should eq(1)
  end

  it "searches erb files" do
    ff = klass.new("")
    Dir.should_receive(:"[]") { |file_mask|
      [/\.rb/, /\.erb/].map {|ext| file_mask =~ ext }.compact.should be_any
    }.exactly(2).times.and_return([])
    ff.files.should eq([])
  end
end