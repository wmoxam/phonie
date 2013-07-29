require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Iraq
class IQTest < Phonie::TestCase
  def test_local
    parse_test('+9642301948190', '964', '23', '01948190', 'Iraq', false)
  end

  def test_mobile
    parse_test('+9647901948190', '964', '79', '01948190', 'Iraq', true)
  end
end

