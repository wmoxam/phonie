require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Fiji
class UGTest < Phonie::TestCase
  def test_local
    parse_test('+256423779423',  '256', '423',  '779423', 'Uganda', false)
  end

  def test_mobile
    parse_test('+256700167639', '256', '70', '0167639', 'Uganda', true)
  end

end
