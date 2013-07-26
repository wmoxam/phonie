require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Comoros
class KMTest < Phonie::TestCase
  def test_local
    parse_test('+2697679833',  '269', '767',  '9833', 'Comoros')
  end
end

