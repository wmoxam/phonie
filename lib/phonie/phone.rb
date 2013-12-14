# An object representing a phone number.
#
# The phone number is recorded in 3 separate parts:
# * country_code - e.g. '385', '386'
# * area_code - e.g. '91', '47'
# * number - e.g. '5125486', '451588'
#
# All parts are mandatory, but country code and area code can be set for all phone numbers using
#   Phonie.configuration.default_country_code
#   Phonie.configuration.default_area_code
#

module Phonie
  class Phone
    EXTENSION = /[ ]*(ext|ex|x|xt|#|:)+[^0-9]*\(*([-0-9]{1,})\)*#?$/i

    attr_reader :configuration, :country_code, :area_code, :errors, :number, :extension, :country

    def initialize(*hash_or_args)
      if hash_or_args.first.is_a?(Hash)
        hash_or_args = hash_or_args.first
        keys = {:configuration => :configuration, :country => :country, :number => :number, :area_code => :area_code, :country_code => :country_code, :extension => :extension}
      else
        keys = {:number => 0, :area_code => 1, :country_code => 2, :extension => 3, :country => 4, :configuration => 5}
      end

      @configuration = hash_or_args[ keys[:configuration] ] || Phonie.configuration
      @number       = hash_or_args[ keys[:number] ]
      @area_code    = hash_or_args[ keys[:area_code] ] || configuration.default_area_code
      @country_code = hash_or_args[ keys[:country_code] ] || configuration.default_country_code
      @extension    = hash_or_args[ keys[:extension] ]
      @country      = hash_or_args[ keys[:country] ]
      @errors = {}
    end

    def self.parse!(string, options = {})
      phone_number = parse(string, options)
      raise ArgumentError.new("#{string} is not a valid phone number") unless phone_number && phone_number.valid?
      phone_number
    end

    # create a new phone number by parsing a string
    # the format of the string is detect automatically (from FORMATS)
    def self.parse(string, options = {})
      return if string.nil?

      options[:country_code] ||= Phonie.configuration.default_country_code
      options[:area_code]    ||= Phonie.configuration.default_area_code

      extension = extract_extension(string)
      normalized = normalize(string)

      return unless country = Country.detect(normalized, options[:country_code], options[:area_code])
      parts = country.parse(normalized, options[:area_code])
      parts[:country] = country
      parts[:country_code] = country.country_code
      parts[:extension] = extension
      new(parts)
    end

    # is this string a valid phone number?
    def self.valid?(string, options = {})
      pn = parse(string, options)
      pn && pn.valid?
    end

    def self.is_mobile?(string, options = {})
      pn = parse(string, options)
      pn && pn.is_mobile?
    end

    def area_code_long
      "0" + area_code if area_code
    end

    # For many countries it's not apparent from the number
    # Will return false positives rather than false negatives.
    def is_mobile?
      country.is_mobile? "#{area_code}#{number}"
    end

    # first n characters of :number
    def number1
      number[0...configuration.n1_length]
    end

    # everything left from number after the first n characters (see number1)
    def number2
      n2_length = number.size - configuration.n1_length
      number[-n2_length, n2_length]
    end

    def format(fmt)
      Formatter.new(format: fmt, phone_number: self).to_s
    end

    # the default format is "+%c%a%n"
    def to_s
      format(:default)
    end

    # does this number belong to the default country code?
    def has_default_country_code?
      country_code == configuration.default_country_code
    end

    # does this number belong to the default area code?
    def has_default_area_code?
      area_code == configuration.default_area_code
    end

    def valid?
      validate
      errors.empty?
    end

    # comparison of 2 phone objects
    def ==(other)
      methods = [:country_code, :area_code, :number, :extension]
      methods.all? { |method| other.respond_to?(method) && send(method) == other.send(method) }
    end

    private

    def validate
      [:country_code, :area_code, :number].each do |field|
	errors[field] = ["can't be blank"] if send(field).to_s == ''
      end
    end

    # split string into hash with keys :country_code, :area_code and :number
    def self.split_to_parts(string, options = {})
      country = Country.detect(string, options[:country_code], options[:area_code])
      country && country.parse(string, options[:area_code])
    end

    # fix string so it's easier to parse, remove extra characters etc.
    def self.normalize(string_with_number)
      string_with_number.sub(EXTENSION, '').gsub(/\(0\)|[^0-9+]/, '').gsub(/^00/, '+')
    end

    # pull off anything that look like an extension
    def self.extract_extension(string)
      return unless string && string.match(EXTENSION)
      Regexp.last_match[2]
    end
  end
end
