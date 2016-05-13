require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Mali
class TZTest < Phonie::TestCase
  def test_local
    parse_test('+255262390044', '255', '26', '2390044', 'Tanzania, United Republic of', false)
  end

  def test_mobile
    parse_test('+255673596267', '255', '67', '3596267', 'Tanzania, United Republic of', true)
    parse_test('+255777375744', '255', '77', '7375744', 'Tanzania, United Republic of', true)
  end
end
