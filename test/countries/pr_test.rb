require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Puerto Rico
class PRTest < Phonie::TestCase
  def test_local
    parse_test('+1 787 555 5555', '1', '787', '5555555', 'Puerto Rico')
  end
end
