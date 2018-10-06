require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Macedonia
class MKTest < Phonie::TestCase
  def test_local
    parse_test('+38921234567', '389', '2', '1234567', 'Macedonia, the Former Yugoslav Republic Of', false)
    parse_test('+38931234567', '389', '31', '234567', 'Macedonia, the Former Yugoslav Republic Of', false)
  end

  def test_mobile
    parse_test('+38971234567', '389', '7', '1234567', 'Macedonia, the Former Yugoslav Republic Of', true)
  end
end
