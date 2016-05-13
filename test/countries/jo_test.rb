require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Jordan
class JOTest < Phonie::TestCase
  def test_local
    parse_test('+96265522796',  '962', '6',  '5522796', 'Jordan', false)
  end

  def test_mobile
    parse_test('+962796899550', '962', '796', '899550', 'Jordan', true)
  end

end
