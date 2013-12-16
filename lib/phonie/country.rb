require 'yaml'

module Phonie
  class Country
    attr_reader :name, :country_code, :char_2_code, :iso_3166_code, :area_code,
	    :local_number_format, :mobile_format, :full_number_length,
	    :number_format 
    
    def initialize(params)
      @name = params[:name]
      @country_code = params[:country_code]
      @char_2_code = params[:char_2_code]
      @iso_3166_code = params[:iso_3166_code]
      @area_code = params[:area_code]
      @local_number_format = params[:local_number_format]
      @mobile_format = params[:mobile_format]
      @full_number_length = params[:full_number_length]
      @number_format = params[:number_format]
      @national_dialing_prefix = params[:national_dialing_prefix]
    end

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

    # detect country from the string entered
    def self.detect(string, default_country_code, default_area_code)
      # use the default_country_code to try for a quick match
      country = find_all_by_phone_code(default_country_code).find do |country|
        country.matches_full_number?(string) ||
          country.matches_local_number_with_area_code?(string) ||
          country.matches_local_number?(string, default_area_code)
      end

      # then search all for a full match
      country || all.find {|country| country.matches_full_number?(string) }
    end

    def to_s
      name
    end

    def is_mobile?(number)
      return true if mobile_format.nil?
      number =~ mobile_number_regex ? true : false
    end

    # true if string contains country_code + area_code + local_number
    def matches_full_number?(string)
      string =~ full_number_regex && string =~ number_format_regex
    end

    # true if string contains area_code + local_number
    def matches_local_number_with_area_code?(string)
      string =~ area_code_number_regex && string =~ number_format_regex
    end

    # true if string contains only the local_number, but the default_area_code is valid
    def matches_local_number?(string, default_area_code)
      string =~ number_regex && default_area_code =~ area_code_regex
    end

    def parse(number, default_area_code)
      if md = number.match(full_number_regex)
        {:area_code => md[2], :number => md[-1]}
      elsif md = number.match(area_code_number_regex)
        {:area_code => md[1], :number => md[-1]}
      elsif md = number.match(number_regex)
        {:area_code => default_area_code, :number => md[1]}
      else
        {}
      end
    end

    def national_dialing_prefix
      return nil if @national_dialing_prefix == "None"

      @national_dialing_prefix
    end

    def valid?
      !!(name && area_code && local_number_format && number_format)
    end

    private

    def number_format_regex
      @number_format_regex ||= Regexp.new("^[+0]?(#{country_code})?(#{number_format})$")
    end

    def full_number_regex
      @full_number_regex ||= Regexp.new("^[+]?(#{country_code})(#{area_code})(#{local_number_format})$")
    end

    def area_code_number_regex
      @area_code_number_regex ||= Regexp.new("^0?(#{area_code})(#{local_number_format})$")
    end

    def area_code_regex
      @area_code_regex ||= Regexp.new("^0?(#{area_code})$")
    end

    def mobile_number_regex
      @mobile_number_regex ||= Regexp.new("^(#{mobile_format})$")
    end

    def number_regex
      @number_regex ||= Regexp.new("^(#{local_number_format})$")
    end
  end
end
