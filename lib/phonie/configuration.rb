require 'singleton'

module Phonie
  class Configuration
    include Singleton

    attr_accessor :default_area_code, :default_country_code, :n1_length
 
    def initialize
      @n1_length = 3
    end
  end
end
