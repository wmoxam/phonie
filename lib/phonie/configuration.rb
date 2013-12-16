require 'singleton'

module Phonie
  class Configuration
    include Singleton

    attr_accessor :data_file_path, :default_area_code, :default_country_code, :n1_length
 
    def initialize
      @data_file_path = File.join(File.dirname(__FILE__), 'data', 'phone_countries.yml')
      @n1_length = 3
    end
  end

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    Configuration.instance
  end
end
