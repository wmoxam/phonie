require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Iceland
class ISTest < Phonie::TestCase
  def test_local
    parse_test('+354421 1234', '354', '421',  '1234', 'Iceland', false)
  end

  def test_mobile
    parse_test('+354621 1234', '354', '621',  '1234', 'Iceland', true)
  end
end

