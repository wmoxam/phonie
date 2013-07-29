

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Senegal
class SNTest < Phonie::TestCase
  def test_local
    parse_test('+221776416455', '221', '7', '76416455', 'Senegal', false)
  end

  def test_mobile
    parse_test('+221876416455', '221', '8', '76416455', 'Senegal', true)
  end
end
