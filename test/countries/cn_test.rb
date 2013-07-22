require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## China
class CNTest < Phonie::TestCase
  def test_local
    parse_test('+863721234567', '86', '372', '1234567', 'China', false)
  end

  def test_mobile
    parse_test('8613123456789', '86', '13', '123456789', 'China', true)
  end
end
