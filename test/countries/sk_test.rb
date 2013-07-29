require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Slovakia
class SKTest < Phonie::TestCase
  def test_local
    parse_test('+421244637253', '421', '2', '44637253', 'Slovakia', false)
    parse_test('+421244637251', '421', '2', '44637251', 'Slovakia', false)
  end

  def test_mobile
    parse_test('+421944637251', '421', '9', '44637251', 'Slovakia', true)
  end
end

