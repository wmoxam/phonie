require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Japan
class JPTest < Phonie::TestCase
  def test_local
    parse_test('+81473558326',  '81', '47',  '3558326', 'Japan', false)
  end

  def test_mobile
    parse_test('+818052806993',  '81', '80',  '52806993', 'Japan', true)
  end
end
