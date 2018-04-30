require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'active_model'
require 'phonie/railties/validator'

I18n.enforce_available_locales = false

class SomeModel < Struct.new(:phone_number)
  include ActiveModel::Validations
  validates :phone_number, phone: true
end

class SomeOtherModel < Struct.new(:phone_number)
  include ActiveModel::Validations
  validates :phone_number, phone: true, allow_blank: true
end

class SomeMobileModel < Struct.new(:mobile_number)
  include ActiveModel::Validations
  validates :mobile_number, mobile_phone: true, allow_blank: true
end

class SomeCountryModel < Struct.new(:mobile_number)
  include ActiveModel::Validations
  validates :mobile_number, default_country_phone: true, allow_blank: true
end

class PhoneValidatorTest < Phonie::TestCase
  def test_blank_phone
    assert SomeModel.new(nil).invalid?
    assert SomeModel.new('').invalid?
    assert SomeOtherModel.new(nil).valid?
    assert SomeOtherModel.new('').valid?
    assert SomeCountryModel.new(nil).valid?
    assert SomeCountryModel.new('').valid?
  end

  def test_valid_model
    model = SomeModel.new('+1 251 123 4567')
    assert model.valid?
  end

  def test_valid_number_with_extension
    model = SomeModel.new('+1 251 123 4567 ex 1234')
    assert model.valid?
  end

  def test_invalid_model
    model = SomeModel.new('+1 251 123 456')
    assert model.invalid?

    assert !model.errors[:phone_number].empty?
  end

  def test_mobile_validator
    valid = SomeMobileModel.new('+886952475345')
    invalid = SomeMobileModel.new('+886423194678')

    assert valid.valid?
    assert invalid.invalid?
  end

  def test_country_validator
    Phonie.configuration.default_country_code = '1'

    puts "DEFAULT: #{Phonie.configuration.default_country_code}"

    valid = SomeCountryModel.new('+1 251 123 4567')
    invalid = SomeCountryModel.new('+2 251 123 4567')

    assert valid.valid?
    assert invalid.invalid?
  end
end
