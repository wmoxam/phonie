require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Montenegro
class METest < Phonie::TestCase
  def test_local
    parse_test('+38220123456',  '382', '20',  '123456', 'Montenegro', false)
  end

  def test_mobile
    parse_test('+38261234567', '382', '6', '1234567', 'Montenegro', true)
  end
end
