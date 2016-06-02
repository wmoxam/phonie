require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Mexico
class MXTest < Phonie::TestCase
  def test_local
    parse_test('+52 33 36159895', '52', '33',  '36159895','Mexico', false)
    parse_test('+52 686 3615989', '52', '686', '3615989', 'Mexico', false)
    parse_test('+52 482 1234567', '52', '482', '1234567', 'Mexico', false)
  end

  def test_mobile
    # Mobile phones have extra 1 in front
    parse_test('+52 1 55 12345678', '52', '155', '12345678', 'Mexico', true)
    parse_test('+52 1 444 1234567', '52', '1444', '1234567', 'Mexico', true)
    parse_test('+52 1 624 1234567', '52', '1624', '1234567', 'Mexico', true)
    parse_test('+52 1 967 1234567', '52', '1967', '1234567', 'Mexico', true)
    parse_test('+52 1 473 1234567 ', '52', '1473', '1234567', 'Mexico', true)
  end
end
