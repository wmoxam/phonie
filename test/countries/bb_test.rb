require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## UAE
class BBTest < Phonie::TestCase
  def test_local
    parse_test('+12462330517',  '1', '246',  '2330517', 'Barbados')
    parse_test('+12462330517',  '1', '246',  '2330517', 'Barbados')
    parse_test('+12462330517',  '1', '246',  '2330517', 'Barbados')
  end
end
