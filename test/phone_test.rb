require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class PhoneTest < Phonie::TestCase

  def test_is_mobile
    assert Phonie::Phone.is_mobile?("918124452900")
  end

  def test_is_default_country?
    Phonie.configuration.default_country_code = '1'

    assert Phonie::Phone.is_default_country?("18124452900")
  end

  def test_number_without_country_code_initialize
    pn = Phonie::Phone.new '5125486', '91'
    assert !pn.valid?
    assert_equal ["can't be blank"], pn.errors[:country_code]
  end

  def test_number_without_area_code_initialize
    Phonie.configuration.default_country_code = '1'

    pn = Phonie::Phone.new '451588'
    assert !pn.valid?
    assert_equal ["can't be blank"], pn.errors[:area_code]
  end

  def test_number_with_default_area_code_initialize
    Phonie.configuration.default_country_code = '385'
    Phonie.configuration.default_area_code = '47'

    pn = Phonie::Phone.new '451588'
    assert pn.number == '451588'
    assert pn.area_code == '47'
    assert pn.country_code == '385'
  end

  def test_number_with_default_country_code_initialize
    Phonie.configuration.default_country_code = '386'

    pn = Phonie::Phone.new '5125486', '91'
    assert pn.number == '5125486'
    assert pn.area_code == '91'
    assert pn.country_code == '386'
  end

  def test_number_with_country_code_initialize
    Phonie.configuration.default_country_code = '387'

    pn = Phonie::Phone.new '5125486', '91', '385'
    assert pn.number == '5125486'
    assert pn.area_code == '91'
    assert pn.country_code == '385'
  end

  def test_parse_empty
    assert_equal nil, Phonie::Phone.parse('')
    assert_equal nil, Phonie::Phone.parse(nil)
  end

  def test_parse_short_without_special_characters_without_country
    assert_nil Phonie::Phone.parse "0915125486"

    assert_raise ArgumentError do
      Phonie::Phone.parse! "0915125486"
    end
  end

  def test_parse_short_with_special_characters_without_country
    assert_nil Phonie::Phone.parse "091/512-5486"

    assert_raise ArgumentError do
      Phonie::Phone.parse! "091/512-5486"
    end
  end

  def test_to_s
    pn = Phonie::Phone.new '5125486', '91', '385'
    assert pn.to_s == '+385915125486'
  end

  def test_to_s_without_country_code
    Phonie.configuration.default_country_code = '385'
    pn = Phonie::Phone.new '5125486', '91'
    assert pn.format("0%a%n") == '0915125486'
  end

  def test_format_special_with_country_code
    pn = Phonie::Phone.new '5125486', '91', '385'
    assert pn.format("+ %c (%a) %n") == '+ 385 (91) 5125486'
  end

  def test_format_special_without_country_code
    Phonie.configuration.default_country_code = '385'
    pn = Phonie::Phone.new '5125486', '91'
    assert_equal '091/512-5486', pn.format("%A/%f-%l")
  end

  def test_format_with_symbol_specifier
    pn = Phonie::Phone.new '5125486', '91', '385'
    assert_equal '+385 (0) 91 512 5486', pn.format(:europe)
  end

  def test_format_with_custom_symbol_specifier
    Phonie.configuration.add_custom_named_format :internal, 'ext.%x'
    pn = Phonie::Phone.new '5125486', '91', '385', '1234'
    assert_equal 'ext.1234', pn.format(:internal)
  end

  def test_valid
    assert Phonie::Phone.valid?('915125486', :country_code => '385')
    assert Phonie::Phone.valid?('385915125486')
  end

  def test_doesnt_validate
    assert !Phonie::Phone.valid?('asdas')
    assert !Phonie::Phone.valid?('38591512548678')
  end

  def test_comparison_true
    pn1 = Phonie::Phone.new '5125486', '91', '385'
    pn2 = Phonie::Phone.new '5125486', '91', '385'
    assert pn1 == pn2
  end

  def test_comparison_false
    pn1 = Phonie::Phone.new '5125486', '91', '385'
    pn2 = Phonie::Phone.new '1234567', '91', '385'
    assert pn1 != pn2
  end

  def test_parse_number_without_international_code
    assert_equal nil, Phonie::Phone.parse("90123456")
    assert_equal "+4790123456", Phonie::Phone.parse("90123456", :country_code => '47').format(:default)
    assert_equal "+4790123456", Phonie::Phone.parse("90123456", :country_code => '47', :area_code => '').format(:default)
  end

end
