require 'forwardable'
require 'yaml'

module Phonie
  class Country
    extend Forwardable

    attr_reader :name, :country_code, :char_2_code, :iso_3166_code, :parser
    
    def initialize(params)
      @name          = params[:name]
      @country_code  = params[:country_code]
      @char_2_code   = params[:char_2_code]
      @iso_3166_code = params[:iso_3166_code]
      @parser        = Phonie::Parser.new(params)
      @national_dialing_prefix = params[:national_dialing_prefix]
    end

    def_delegators :parser, :is_mobile?, :possible_valid_number?,
	                    :is_valid_number?, :parse

    def self.all
      @@all ||= begin
        YAML.load_file(Phonie.configuration.data_file_path).collect do |country_params|
	  Country.new(country_params)
        end.select {|country| country.valid? }
      end
    end

    def self.all_by_phone_code
      @@all_by_phone_code ||= all.inject(Hash.new){|h, c| (h[c.country_code] ||= []) << c; h }
    end

    def self.all_by_country_code
      @@all_by_country_name ||=  Hash[*all.map{|c| [c.iso_3166_code.downcase, c] }.flatten]
    end

    def self.all_by_name
      @@all_by_name ||= Hash[*all.map{|c| [c.name.downcase, c] }.flatten]
    end

    def self.find_all_by_phone_code(code)
      all_by_phone_code[code] || []
    end

    def self.find_by_country_code(code)
      all_by_country_code[code.downcase] if code
    end

    def self.find_by_name(name)
      all_by_name[name.downcase] if name
    end

    # detect country from the passed phone number
    def self.detect(phone_number, default_country_code, default_area_code)
      # use the default_country_code to try for a quick match
      country = find_all_by_phone_code(default_country_code).find do |c|
        c.possible_valid_number?(phone_number, default_area_code)
      end

      # then search all for a full match
      country || all.find {|country| country.is_valid_number?(phone_number) }
    end

    def to_s
      name
    end

    def national_dialing_prefix
      return nil if @national_dialing_prefix == "None"

      @national_dialing_prefix
    end

    def valid?
      !!(name && parser.valid?)
    end
  end
end
