require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Mali
class MLTest < Phonie::TestCase
  def test_local
    parse_test('+22320203134', '223', '2020', '3134', 'Mali', false)
  end

  def test_mobile
    parse_test('+22366089000', '223', '660', '89000', 'Mali', true)
    parse_test('+22378458504', '223', '784', '58504', 'Mali', true)
  end
end
