I18n.load_path += Dir.glob( File.expand_path('../locales/*.{rb,yml}', __FILE__) )

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    object.errors.add(attribute, :invalid_phone_number) unless Phonie::Phone.valid?(value)
  end
end
