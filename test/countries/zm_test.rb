require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Zambia
class ZMTest < Phonie::TestCase

  def test_mobile
    parse_test('+260 966 123456', '260', '966', '123456',"Zambia",true)
  end

  def test_locale
    parse_test('+260 218 123456', '260', '218', '123456',"Zambia",false)
  end

end
