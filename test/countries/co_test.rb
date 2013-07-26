require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Colombia
class COTest < Phonie::TestCase
  def test_local
    parse_test('+5768724057', '57', '6', '8724057', 'Colombia', false)
  end

  def test_mobile
    parse_test('+573004885879', '57', '300', '4885879', 'Colombia', true)
    parse_test('+573132335285', '57', '313', '2335285', 'Colombia', true)
  end
end
