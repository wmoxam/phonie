require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Malaysia
class FJTest < Phonie::TestCase
  def test_local
    parse_test('+6793254153',  '679', '3',  '254153', 'Fiji', false)
  end

  def test_mobile
    parse_test('+6799356584', '679', '9', '356584', 'Fiji', true)
    parse_test('+6798380406', '679', '8', '380406', 'Fiji', true)
  end

end
