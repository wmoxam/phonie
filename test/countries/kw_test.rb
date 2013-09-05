require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Kuwait
class KWTest < Phonie::TestCase
  def test_local
    parse_test('+96566135555',  '965', '',  '66135555', 'Kuwait', false)
  end
end
