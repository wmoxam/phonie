require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Korea, Republic of 
class KRTest < Phonie::TestCase
  def test_local
    parse_test('+8223123456',  '82', '2',  '3123456', 'Korea, Republic of', false)
    parse_test('+82333123456', '82', '33', '3123456', 'Korea, Republic of', false)
    parse_test('+82643123456', '82', '64', '3123456', 'Korea, Republic of', false)
  end

  def test_mobile
    parse_test('+82103123456', '82', '10', '3123456', 'Korea, Republic of', true)
    parse_test('+82193123456', '82', '19', '3123456', 'Korea, Republic of', true)
  end
end 
