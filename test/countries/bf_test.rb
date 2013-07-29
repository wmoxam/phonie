require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Burkina Faso
class BFTest < Phonie::TestCase
  def test_local
    parse_test('+22620491705', '226', '20', '491705', 'Burkina Faso', false)
  end

  def test_mobile
    parse_test('+22678101705', '226', '78', '101705', 'Burkina Faso', true)
  end
end


