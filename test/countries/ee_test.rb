require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Estonia
class EETest < Phonie::TestCase
  def test_local
    parse_test('+3722123456', '372', '2', '123456', 'Estonia', false)
  end

  def test_mobile
    parse_test('+3725123456', '372', '5', '123456', 'Estonia', true)
    parse_test('+37251234567', '372', '5', '1234567', 'Estonia', true)
    parse_test('+37281123456', '372', '81', '123456', 'Estonia', true)
    parse_test('+37282123456', '372', '82', '123456', 'Estonia', true)
    parse_test('+37283123456', '372', '83', '123456', 'Estonia', true)
  end
end
