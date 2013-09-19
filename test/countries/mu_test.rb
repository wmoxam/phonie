require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Mauritius
class MUTest < Phonie::TestCase
  def test_local
    parse_test('+23054037000',  '230', '5403',  '7000', 'Mauritius', false)
  end

  def test_mobile
    parse_test('+23054217000',  '230', '5421',  '7000', 'Mauritius', true)
    parse_test('+23054227000',  '230', '5422',  '7000', 'Mauritius', true)
    parse_test('+23054237000',  '230', '5423',  '7000', 'Mauritius', true)
    parse_test('+23054287000',  '230', '5428',  '7000', 'Mauritius', true)
    parse_test('+23054297000',  '230', '5429',  '7000', 'Mauritius', true)
    parse_test('+23054907000',  '230', '5490',  '7000', 'Mauritius', true)
    parse_test('+23052507000',  '230', '5250',  '7000', 'Mauritius', true)
    parse_test('+23057017000',  '230', '5701',  '7000', 'Mauritius', true)
    parse_test('+23058707000',  '230', '5870',  '7000', 'Mauritius', true)
    parse_test('+23059007000',  '230', '5900',  '7000', 'Mauritius', true)
  end
end
