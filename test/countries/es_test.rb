require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Spain
class ESTest < Phonie::TestCase
  def test_local
    parse_test('+34985204499',  '34', '985',  '204499', 'Spain', false)
    parse_test('+34902107303',  '34', '902',  '107303', 'Spain', false)
    parse_test('+34985892398',  '34', '985',  '892398', 'Spain', false)
  end

  def test_mobile
    parse_test('+34644161452', '34', '6', '44161452', 'Spain', true)
    parse_test('+34635399976', '34', '6', '35399976', 'Spain', true)
  end
end
