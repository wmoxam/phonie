require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Fiji
class CUTest < Phonie::TestCase
  def test_local
    parse_test('+5378346100',  '53', '7',  '8346100', 'Cuba', false)
  end

  def test_mobile
    parse_test('+5353478134', '53', '5', '3478134', 'Cuba', true)
  end

end
