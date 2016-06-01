require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Botswana
class BWTest < Phonie::TestCase
  def test_local
    parse_test('2673637777', '267', '36', '37777', 'Botswana', false)
  end

  def test_mobile
    parse_test('26775273692', '267', '75', '273692', 'Botswana', true)
  end
end
