require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Mauritius 
class MUTest < Phonie::TestCase
  def test_local
    parse_test('+2304037000',  '230', '403',  '7000', 'Mauritius', false)
  end

  def test_mobile
    parse_test('+2304217000',  '230', '421',  '7000', 'Mauritius', true)
    parse_test('+2304227000',  '230', '422',  '7000', 'Mauritius', true)
    parse_test('+2304237000',  '230', '423',  '7000', 'Mauritius', true)
    parse_test('+2304287000',  '230', '428',  '7000', 'Mauritius', true)
    parse_test('+2304297000',  '230', '429',  '7000', 'Mauritius', true)
    parse_test('+2304907000',  '230', '490',  '7000', 'Mauritius', true)
    parse_test('+2302507000',  '230', '250',  '7000', 'Mauritius', true)
    parse_test('+2307017000',  '230', '701',  '7000', 'Mauritius', true)
    parse_test('+2308707000',  '230', '870',  '7000', 'Mauritius', true)
    parse_test('+2309007000',  '230', '900',  '7000', 'Mauritius', true)
  end
end 
