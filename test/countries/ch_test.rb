require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Switzerland
class CHTest < Phonie::TestCase

  def test_local
    parse_test('+41213459020', '41', '21', '3459020', 'Switzerland', false)
  end

end

