require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Trinidad and Tobago
class TTTest < Phonie::TestCase
  def test_local
    parse_test('+18681234567',  '1', '868',  '1234567', 'Trinidad and Tobago')
  end

  def test_long_with_default_country_code
    Phonie.configuration.default_country_code = '1'
    parse_test('8689735100', '1', '868', '9735100', 'Trinidad and Tobago')
  end

  def test_short_with_default_country_code_and_area_code
    Phonie.configuration.default_country_code = '1'
    Phonie.configuration.default_area_code = '868'
    parse_test('9735100', '1', '868', '9735100', 'Trinidad and Tobago')
  end
end
