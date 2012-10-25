class I18nInspector::FileFinder

  def initialize(search_dir)
    @search_dir = search_dir
  end

  def files
    Dir[File.join(@search_dir, '**/*.rb')] + Dir[File.join(@search_dir, '**/*.erb')]
  end
end