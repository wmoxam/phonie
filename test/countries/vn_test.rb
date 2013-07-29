require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Viet Nam
class VNTest < Phonie::TestCase
  def test_local
    parse_test('+84701208230', '84', '70', '1208230', 'Viet Nam', false)
  end

  def test_mobile
    parse_test('+84909208230', '84', '90', '9208230', 'Viet Nam', true)
  end
end

