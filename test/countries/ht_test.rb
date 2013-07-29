require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Haiti
class HTTest < Phonie::TestCase
  def test_local
    parse_test('+509 22 45 3300', '509', '22',  '453300', 'Haiti', false)
  end

  def test_mobile
    parse_test('+509 36 63 1234', '509', '36',  '631234', 'Haiti', true)
  end
end

