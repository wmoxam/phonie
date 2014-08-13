require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Thailand
class THTest < Phonie::TestCase
  def test_local
    parse_test('+6622134567',  '66', '2',  '2134567', 'Thailand', false)
    parse_test('+6632734256',  '66', '32',  '734256', 'Thailand', false)
  end

  def test_mobile
    parse_test('+66940734567', '66', '94',  '0734567', 'Thailand', true)
    parse_test('+6687342563',  '66', '87',  '342563', 'Thailand', true)
  end
end
