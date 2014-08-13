require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Hong Kong
class HKTest < Phonie::TestCase
  def test_local
    parse_test('+85225555555', '852', '2', '5555555', 'Hong Kong', false)
  end

  def test_mobile
    parse_test('+85265555555', '852', '6', '5555555', 'Hong Kong', true)
  end
end

