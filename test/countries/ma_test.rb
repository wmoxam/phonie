require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Morocco
class MOTest < Phonie::TestCase
  def test_local
    parse_test('+212 520123456', '212', '520',  '123456', 'Morocco', false)
    parse_test('+212 538901234', '212', '53890',  '1234', 'Morocco', false)
  end

  def test_mobile
    parse_test('+212 610123456',  '212', '610', '123456', 'Morocco', true)
    parse_test('+212 668680069', '212', '668', '680069', 'Morocco', true)
  end
end
