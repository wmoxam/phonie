require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Nicaragua
class NITest < Phonie::TestCase
  def test_local
    parse_test('+50529800400', '505', '2', '9800400', 'Nicaragua', false)
  end

  def test_mobile
    parse_test('+50589800400', '505', '8', '9800400', 'Nicaragua', true)
  end
end




