require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Singapore
class SGTest < Phonie::TestCase
  def test_local
    parse_test('+6568801234',  '65', '6',  '8801234', 'Singapore', false)
  end

  def test_mobile
    parse_test('+6591233132',  '65', '9',  '1233132', 'Singapore', true)
  end
end

