require "i18n_inspector/version"
require "syck"

class I18nInspector
  autoload :DictParser, 'i18n_inspector/dict_parser'
  autoload :KeyExtractor, 'i18n_inspector/key_extractor'
  autoload :FileFinder, 'i18n_inspector/file_finder'
  autoload :Config, 'i18n_inspector/config'
  module DictHashTraverser
    autoload :Recursive, 'i18n_inspector/dict_hash_traverser/recursive'
  end
  module ScopeGenerator
    autoload :Rails, 'i18n_inspector/scope_generator/rails'
  end
  module ExtractorBackend
    autoload :Regexp, 'i18n_inspector/extractor_backend/regexp'
  end

  attr_reader :config
  
  def initialize(search_dir, dict_file, config=Config.new)
    @search_dir = search_dir
    @dict_file = dict_file
    @config = config
  end
  
  def undefined_keys
    found_keys - defined_keys
  end
  
  def unused_keys
    defined_keys - found_keys
  end
  
  def defined_keys
    dictionary_keys
  end
  
  protected
  
  def files
    @files ||= files_in_search_dir
  end
  
  def files_in_search_dir
    @file_finder ||= file_finder.new(@search_dir)
    @file_finder.files
  end
  
  def file_finder
    config.file_finder
  end
  
  def dictionary_keys
    @dictionary_keys ||= dictionary_keys_from_file
  end
  
  def dictionary_keys_from_file
    dp = DictParser.new(@dict_file, config.dict_hash_traverser, config.yml_parser)
    dp.full_keys
  end
  
  def found_keys
    @found_keys ||= keys_from_files
  end
  
  def keys_from_files
    ke = KeyExtractor.new(config.extractor_backend, config.scope_generator)
    ke.from_files(files)
  end
  
end
