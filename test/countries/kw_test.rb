require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Kuwait
class KWTest < Phonie::TestCase
  def test_local
    parse_test('+96521234567', '965', '2', '1234567', 'Kuwait', false)
  end

  def test_mobile
    parse_test('+96551234567', '965', '5', '1234567', 'Kuwait', true)
    parse_test('+96561234567', '965', '6', '1234567', 'Kuwait', true)
    parse_test('+96591234567', '965', '9', '1234567', 'Kuwait', true)
  end
end

