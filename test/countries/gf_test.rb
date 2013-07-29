require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## French Guiana
class GFTest < Phonie::TestCase
  def test_local
    parse_test('+594594123456', '594', '594', '123456', 'French Guiana', false)
  end

  def test_mobile
    parse_test('+594694123456', '594', '694', '123456', 'French Guiana', true)
  end
end



