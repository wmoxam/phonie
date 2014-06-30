require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Brazil
class BRTest < Phonie::TestCase
  def test_local
    parse_test('+559112345678', '55', "91", '12345678', 'Brazil', false)
    #parse_failure('+5591123456789') # only mobile numebrs can be 11 digits
  end

  def test_mobile
    parse_test('553161234567', '55', '31', '61234567', 'Brazil', true)
    parse_test('5512612345678', '55', '12', '612345678', 'Brazil', true)
  end
end
