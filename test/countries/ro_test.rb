require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Romania
class ROTest < Phonie::TestCase
  def test_local
    parse_test('+40255123456',  '40', '255',  '123456', 'Romania', false)
  end
  
  def test_mobile
    parse_test('+40712345678', '40', '7', '12345678', 'Romania', true)
  end
end
