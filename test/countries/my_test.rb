require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Malaysia
class MYTest < Phonie::TestCase
  def test_local
    parse_test('+60392218081',  '60', '3',  '92218081', 'Malaysia', false)
  end

  def test_mobile
    parse_test('+60196681162', '60', '19', '6681162', 'Malaysia', true)
  end

end
