require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Indonesia
class IDTest < Phonie::TestCase
  def test_mobile
    parse_test('6281311122233', '62', '813', '11122233', "Indonesia", true)
  end

  def test_long_with_default_country_code
    Phonie.configuration.default_country_code = '62'
    parse_test('81311122233', '62', '813', '11122233')
  end

  def test_short_with_default_country_code_and_area_code
    Phonie.configuration.default_country_code = '62'
    Phonie.configuration.default_area_code = '813'
    parse_test('11122233', '62', '813', '11122233')
  end

  def test_lengths
    Phonie.configuration.default_country_code = '62'

    phone = Phonie::Phone.parse("81311122233")
    assert phone

    phone = Phonie::Phone.parse("813111222334")
    assert_nil phone
  end
end
