require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'active_model'

require 'phonie/railties/validator'
class SomeModel < Struct.new(:phone_number)
  include ActiveModel::Validations
  validates :phone_number, phone: true
end

class SomeOtherModel < Struct.new(:phone_number)
  include ActiveModel::Validations
  validates :phone_number, phone: true, allow_blank: true
end

class PhoneValidatorTest < Phonie::TestCase
  def test_blank_phone
    assert SomeModel.new(nil).invalid?
    assert SomeModel.new('').invalid?
    assert SomeOtherModel.new(nil).valid?
    assert SomeOtherModel.new('').valid?
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
end
