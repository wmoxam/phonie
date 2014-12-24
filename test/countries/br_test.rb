require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Brazil
class BRTest < Phonie::TestCase

  def test_local
    parse_test('+55 91 12345678', '55', "91", '12345678', 'Brazil', false)
  end

  def test_sao_paulo
    parse_test('+55 11 12345678', '55', "11", '12345678', 'Brazil', false)
  end

  def test_minas_gerais
    parse_test('+55 35 12345678', '55', "35", '12345678', 'Brazil', false)
  end

  def test_area_with_zero
    parse_test('+55 35 12345678', '55', "35", '12345678', 'Brazil', false)
  end

  def test_paid_toll
    parse_test('+55 0300 12 345 67', '55', "0300", '1234567', 'Brazil', false)
  end

  def test_donation_service
    parse_test('+55 0500 12 345 67', '55', "0500", '1234567', 'Brazil', false)
  end

  def test_toll_free
    parse_test('+55 0800 12 345 67', '55', "0800", '1234567', 'Brazil', false)
  end

  def test_paid_service
    parse_test('+55 0900 123 4567', '55', "0900", '1234567', 'Brazil', false)
  end

  #
  # Parse should fail
  #
  def test_area_validation_min
    parse_failure('+55 10 1234 5678') # no area '10'
  end

  def test_area_cant_have_9
    parse_failure('55 31 95101 4567')
  end

  def test_only_mobile_has_11_digits
    parse_failure('+5591123456789') # only mobile numebrs can be 11 digits
  end

  #
  # Mobile
  #
  def test_mobile
    parse_test('+55 91 9786 5678', '55', "91", '97865678', 'Brazil', true)
  end

  def test_mobile_low_range
    parse_test('55 11 6101 4567', '55', '11', '61014567', 'Brazil', true)
  end

  def test_mobile_high_range
    parse_test('55 35 9991 4567', '55', '35', '99914567', 'Brazil', true)
  end

  def test_mobile_with_9
    parse_test('55 12 98765 5678', '55', '12', '987655678', 'Brazil', true)
  end
end
