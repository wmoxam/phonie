require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## GIBRALTAR
class GITest < Phonie::TestCase
  def test_local
    parse_test('35020012345','350', '2001', '2345', 'Gibraltar', false)
  end

  def test_mobile
    parse_test('35054018411', '350', '54', '018411', 'Gibraltar', true)
  end
end
