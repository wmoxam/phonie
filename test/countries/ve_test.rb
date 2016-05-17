require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Venezuela
class VETest < Phonie::TestCase
  def test_local
    parse_test('+582742662406', '58', '274', '2662406', 'Venezuela, Bolivarian Republic of', false)
  end

  def test_mobile
    parse_test('+584141809033', '58', '414', '1809033', 'Venezuela, Bolivarian Republic of', true)
  end

end
