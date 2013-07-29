require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Cambodia
class KHTest < Phonie::TestCase
  def test_local
    parse_test('+85535849285', '855', '35',  '849285', 'Cambodia', false)
  end

  def test_mobile
    parse_test('+85588325969', '855', '88', '325969', 'Cambodia', true)
  end
end
