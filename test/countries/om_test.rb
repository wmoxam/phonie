require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Morocco
class MOTest < Phonie::TestCase
  def test_local
    parse_test('+968 22123456',  '968', '22', '123456', 'Oman', false)
  end

  def test_mobile
    parse_test('+968 99012345',  '968', '990', '12345', 'Oman', true)
  end
end
