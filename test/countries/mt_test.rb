require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Malta
class MTTest < Phonie::TestCase
  def test_local
    parse_test('+35622060250',  '356', '22',  '060250', 'Malta', false)
  end

  def test_mobile
    parse_test('+35677060250', '356', '77', '060250', 'Malta', true)
  end

end

