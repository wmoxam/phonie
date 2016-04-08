require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Guatemala
class PETest < Phonie::TestCase
  def test_local
    parse_test('+5112345678', '51', "1", '2345678', 'Peru', false)
    parse_test('+5143234567', '51', "43", '234567', 'Peru', false)
  end

  def test_mobile
    parse_test('+5192345678', '51', '9', '2345678', 'Peru', true)
  end
end
