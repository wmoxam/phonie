require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Panama
class PATest < Phonie::TestCase
  def test_local
    parse_test('+50741869702', '507', '4', '1869702', 'Panama', false)
  end

  def test_mobile
    parse_test('+50767677540', '507', '6', '7677540', 'Panama', true)
  end
end
