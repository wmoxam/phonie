require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Poland
class PLTest < Phonie::TestCase
  def test_local
    parse_test('+48 225109999',  '48', '22',  '5109999', 'Poland', false)
  end

  def test_mobile
    parse_test('+48 600 887 057', '48', '60', '0887057', 'Poland', true)
    parse_test('+48 660 923 990', '48', '66', '0923990', 'Poland', true)
    parse_test('+48 884 001 872', '48', '88', '4001872', 'Poland', true)
    parse_test('+48 536 809 829', '48', '53', '6809829', 'Poland', true)
  end
end


