require 'active_model/naming'
require 'active_model/translation'
require 'active_model/validations'

# An object representing a phone number.
#
# The phone number is recorded in 3 separate parts:
# * country_code - e.g. '385', '386'
# * area_code - e.g. '91', '47'
# * number - e.g. '5125486', '451588'
#
# All parts are mandatory, but country code and area code can be set for all phone numbers using
#   Phone.default_country_code
#   Phone.default_area_code
#
module Phonie
  class Phone
    EXTENSION = /[ ]*(ext|ex|x|xt|#|:)+[^0-9]*\(*([-0-9]{1,})\)*#?$/i

    attr_accessor :country_code, :area_code, :number, :extension, :country

    cattr_accessor :default_country_code
    cattr_accessor :default_area_code
    cattr_accessor :named_formats

    # length of first number part (using multi number format)
    cattr_accessor :n1_length
    # default length of first number part
    @@n1_length = 3

    @@named_formats = {
      :default => "+%c%a%n",
      :default_with_extension => "+%c%a%nx%x",
      :europe => '+%c (0) %a %f %l',
      :us => "(%a) %f-%l"
    }

    include ActiveModel::Validations
    validates :country_code, :presence => true
    validates :area_code, :presence => true
    validates :number, :presence => true

    def initialize(*hash_or_args)
      if hash_or_args.first.is_a?(Hash)
        hash_or_args = hash_or_args.first
        keys = {:country => :country, :number => :number, :area_code => :area_code, :country_code => :country_code, :extension => :extension}
      else
        keys = {:number => 0, :area_code => 1, :country_code => 2, :extension => 3, :country => 4}
      end

      self.number       = hash_or_args[ keys[:number] ]
      self.area_code    = hash_or_args[ keys[:area_code] ] || self.default_area_code
      self.country_code = hash_or_args[ keys[:country_code] ] || self.default_country_code
      self.extension    = hash_or_args[ keys[:extension] ]
      self.country      = hash_or_args[ keys[:country] ]
    end

    def self.parse!(string, options = {})
      pn = parse(string, options)
      raise ArgumentError.new("#{string} is not a valid phone number") unless pn && pn.valid?
      pn
    end

    # create a new phone number by parsing a string
    # the format of the string is detect automatically (from FORMATS)
    def self.parse(string, options = {})
      return unless string.present?

      options[:country_code] ||= self.default_country_code
      options[:area_code]    ||= self.default_area_code

      Country.load

      extension = extract_extension(string)
      normalized = normalize(string)

      return unless parts = split_to_parts(normalized, options)
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
      number[0...self.class.n1_length]
    end

    # everything left from number after the first n characters (see number1)
    def number2
      n2_length = number.size - self.class.n1_length
      number[-n2_length, n2_length]
    end

    # Formats the phone number.
    #
    # if the method argument is a String, it is used as a format string, with the following fields being interpolated:
    #
    # * %c - country_code (385)
    # * %a - area_code (91)
    # * %A - area_code with leading zero (091)
    # * %n - number (5125486)
    # * %f - first @@n1_length characters of number (configured through Phone.n1_length), default is 3 (512)
    # * %l - last characters of number (5486)
    # * %x - entire extension
    #
    # if the method argument is a Symbol, it is used as a lookup key for a format String in Phone.named_formats
    #   pn.format(:europe)
    def format(fmt)
      if fmt.is_a?(Symbol)
        raise ArgumentError.new("The format #{fmt} doesn't exist") unless named_formats.has_key?(fmt)
        format_number named_formats[fmt]
      else
        format_number(fmt)
      end
    end

    # the default format is "+%c%a%n"
    def to_s
      format(:default)
    end

    # does this number belong to the default country code?
    def has_default_country_code?
      country_code == self.class.default_country_code
    end

    # does this number belong to the default area code?
    def has_default_area_code?
      area_code == self.class.default_area_code
    end

    # comparison of 2 phone objects
    def ==(other)
      methods = [:country_code, :area_code, :number, :extension]
      methods.all? { |method| other.respond_to?(method) && send(method) == other.send(method) }
    end

    private

    # split string into hash with keys :country_code, :area_code and :number
    def self.split_to_parts(string, options = {})
      country = Country.detect(string, options[:country_code], options[:area_code])
      country && country.number_parts(string, options[:area_code])
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

    def format_number(fmt)
      fmt.gsub("%c", country_code || "").
        gsub("%a", area_code || "").
        gsub("%A", area_code_long || "").
        gsub("%n", number || "").
        gsub("%f", number1 || "").
        gsub("%l", number2 || "").
        gsub("%x", extension || "")
    end
  end
end
