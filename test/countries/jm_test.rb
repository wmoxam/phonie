require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Norway
class JMTest < Phonie::TestCase
  def test_local
    parse_test('+18769696268', '1', '876', '9696268', 'Jamaica', false)
  end

  def test_mobile
    parse_test('+18764884110', '1', '876', '4884110', 'Jamaica', true)
  end
end
