require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Taiwan
class TWTest < Phonie::TestCase
  def test_local
    parse_test('+886423194678', '886', '4', '23194678', 'Taiwan, Province Of China', false)
  end

  def test_mobile
    parse_test('+886952475345', '886', '9', '52475345', 'Taiwan, Province Of China', true)
  end
end
