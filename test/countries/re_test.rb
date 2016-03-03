require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Reunion Island
class RETest < Phonie::TestCase
  def test_local
    parse_test('+262 269 112345',  '262', '269',  '112345', 'Reunion', false)
    parse_test('+262 262 123456',  '262', '262',  '123456', 'Reunion', false)
    parse_test('+262 269 612345',  '262', '269',  '612345', 'Reunion', false)
  end

  def test_mobile
    parse_test('+262 692 123456', '262', '692',  '123456', 'Reunion', true)
    parse_test('+262 693 123456', '262', '693',  '123456', 'Reunion', true)
  end
end
