require 'singleton'

module Phonie
  class Configuration
    include Singleton

    attr_accessor :data_file_path, :default_area_code, :default_country_code, :n1_length

    def initialize
      @data_file_path = File.join(File.dirname(__FILE__), 'data', 'phone_countries.yml')
      @n1_length = 3
      @named_formats = {}
    end

    def add_custom_named_format(name, format_string)
      @named_formats[name.to_sym] = format_string
    end

    def custom_named_formats
      @named_formats
    end
  end

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    Configuration.instance
  end
end
