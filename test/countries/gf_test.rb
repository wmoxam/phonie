require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## French Guiana
class GFTest < Phonie::TestCase
  def test_local
    parse_test('+5945941234', '594', '594', '1234', 'French Guiana', false)
  end

  def test_mobile
    parse_test('+5946941234', '594', '694', '1234', 'French Guiana', true)
  end
end



