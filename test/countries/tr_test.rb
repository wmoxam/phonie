require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Turkey
class TRTest < Phonie::TestCase
  def test_local
    parse_test('+902122927759',  '90', '212',  '2927759', 'Turkey', false)
  end

  def test_mobile
    parse_test('+905333364565', '90', '533', '3364565', 'Turkey', true)
  end
end
