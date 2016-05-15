# Formats the phone number.
#
# if the method argument is a String, it is used as a format string, with the following fields being interpolated:
#
# * %c - country_code (385)
# * %a - area_code (91)
# * %A - area_code with leading zero (091)
# * %n - number (5125486)
# * %f - first n1_length characters of number (configured through Phone.n1_length), default is 3 (512)
# * %l - last characters of number (5486)
# * %x - entire extension
#
# if the method argument is a Symbol, it is used as a lookup key for a format String in Phone.named_formats
#   pn.format(:europe)
module Phonie
  class Formatter
    attr_reader :format, :phone_number

    def initialize(params)
      @phone_number = params[:phone_number]

      format = params[:format]
      @format = if format.respond_to?(:gsub)
        format
      else
        self.class.named_formats[format]
      end

      raise ArgumentError.new("No valid format provided") if @format.nil?
      raise ArgumentError.new("No valid phone number provided") if @phone_number.nil?
    end

    def self.named_formats
      default_named_formats.merge(Phonie.configuration.custom_named_formats)
    end

    def to_s
      pn = phone_number

      format.gsub("%c", pn.country_code.to_s).
        gsub("%a", pn.area_code.to_s).
        gsub("%A", pn.area_code_long.to_s).
        gsub("%n", pn.number.to_s).
        gsub("%f", pn.number1.to_s).
        gsub("%l", pn.number2.to_s).
        gsub("%x", pn.extension.to_s).
        gsub("%X", pn.extension_with_prefix.to_s)
    end

    private

    def self.default_named_formats
      {
        default: "+%c%a%n",
        default_with_extension: "+%c%a%nx%x",
        europe: '+%c (0) %a %f %l',
        us: "(%a) %f-%l"
      }
    end
  end
end
