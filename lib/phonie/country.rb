module Phonie
  class Country < Struct.new(:name, :country_code, :char_2_code, :char_3_code, :area_code, :local_number_format, :mobile_format, :full_number_length, :number_format)
    def self.load
      data_file = File.join(File.dirname(__FILE__), 'data', 'phone_countries.yml')

      all = []
      YAML.load(File.read(data_file)).each_pair do |key, c|
        next unless c[:area_code] && c[:local_number_format]
        all << Country.new(c[:name], c[:country_code], c[:char_2_code], c[:char_3_code], c[:area_code], c[:local_number_format], c[:mobile_format], c[:full_number_length], c[:number_format])
      end
      all
    end

    COUNTRIES = self.load
    COUNTRIES_BY_PHONE_CODE   = COUNTRIES.inject(Hash.new){|h, c| (h[c.country_code] ||= []) << c; h }
    COUNTRIES_BY_COUNTRY_CODE = Hash[*COUNTRIES.map{|c| [c.char_3_code.downcase, c] }.flatten]
    COUNTRIES_BY_NAME         = Hash[*COUNTRIES.map{|c| [c.name.downcase, c] }.flatten]

    def self.find_all_by_phone_code(code)
      COUNTRIES_BY_PHONE_CODE[code] || []
    end

    def self.find_by_country_code(code)
      COUNTRIES_BY_COUNTRY_CODE[code.downcase] if code
    end

    def self.find_by_name(name)
      COUNTRIES_BY_NAME[name.downcase] if name
    end

    # detect country from the string entered
    def self.detect(string, default_country_code, default_area_code)
      # use the default_country_code to try for a quick match
      country = find_all_by_phone_code(default_country_code).find do |country|
        country.matches_full_number?(string) || country.matches_local_number?(string, default_area_code)
      end

      # then search all for a full match
      country || COUNTRIES.find {|country| country.matches_full_number?(string) }
    end

    def to_s
      name
    end

    def is_mobile?(number)
      return true if mobile_format.nil?
      number =~ mobile_number_regex ? true : false
    end

    def matches_local_number?(string, default_area_code)
      (string =~ area_code_number_regex && string =~ number_format_regex) ||
      (string =~ number_regex && default_area_code =~ area_code_regex)
    end

    def matches_full_number?(string)
      string =~ full_number_regex && string =~ number_format_regex
    end

    def number_parts(number, default_area_code)
      number_part = if default_area_code
        number.match(number_regex)
        $1
      else
        nil
      end

      if number_part.nil?
        matches = number.match(area_code_number_regex)
        area_part = $1
        number_part = matches.to_a.last
      end

      if number_part.nil?
        matches = number.match(full_number_regex)
        country_part, area_part = $1, $2
        number_part = matches.to_a.last
      end

      area_part ||= default_area_code

      raise "Could not determine area code" if area_part.nil?
      raise "Could not determine number" if number_part.nil?

      {:number => number_part, :area_code => area_part, :country_code => country_code, :country => self}
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
