module Phonie
  # Parser is responsible for parsing and verifying phone numbers
  class Parser
    attr_reader :area_code, :country_code, :local_number_format, :mobile_format, :number_format

    # Creates a new phone number parser based on a hash of +params+
    # The +params+ hash requires
    # * area_code
    # * country_code - a number representing the International Subscriber Dialling code
    # * local_number_format - a regex describing a local phone number (minus country and area code)
    # * number_format - a regex describing a valid phone number
    # * mobile_format (optional) - a regex describing a mobile phone number
    def initialize(params)
      @area_code           = params[:area_code]
      @country_code        = params[:country_code]
      @local_number_format = params[:local_number_format]
      @mobile_format       = params[:mobile_format]
      @number_format       = params[:number_format]
    end

    # Test if a phone +number+ might be for a mobile phone
    # Can produce false positives, and some countries have
    # portable numbers between landlines and mobile phones
    # in which case this will always be true
    def is_mobile?(number)
      return true if mobile_format.nil?
      number =~ mobile_number_regex ? true : false
    end

    # Test if +phone_number+ is valid
    def is_valid_number?(phone_number)
      matches_full_number?(phone_number)
    end

    # Parse a pass phone +number+ returning it's area_code & number as a
    # hash if valid.
    # Optionally a +default_area_code+ may be passed in order to
    # allow parsing local number numbers for a known area code
    def parse(number, default_area_code = nil)
      parse_full_match(number) ||
      parse_area_code_match(number) ||
      parse_with_default(number, default_area_code) ||
      {}
    end

    # Test if a phone number could possibly be valid by testing
    # if it's matches a number without a country code, and optionally
    # testing for a local number against a default_area_code
    def possible_valid_number?(phone_number, default_area_code = nil)
      matches_full_number?(phone_number) ||
      matches_local_number_with_area_code?(phone_number) ||
      matches_local_number?(phone_number, default_area_code)
    end

    # Test that a parser is valid and is capable of parsing phone numbers
    def valid?
      !!(country_code && area_code && local_number_format && number_format)
    end

    private

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

    def parse_full_match(number)
      match = number.match(full_number_regex)
      return nil unless match

      { area_code: match[2],
        number:    match[-1] }
    end

    def parse_area_code_match(number)
      match = number.match(area_code_number_regex)
      return nil unless match

      { area_code: match[1],
        number:    match[-1] }
    end

    def parse_with_default(number, default_area_code)
      match = number.match(number_regex)
      return nil unless match

      { area_code: default_area_code,
        number:    match[1] }
    end

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
