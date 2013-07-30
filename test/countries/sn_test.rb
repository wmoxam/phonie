

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Senegal
class SNTest < Phonie::TestCase
  def test_local
    parse_test('+221336416455', '221', '33', '6416455', 'Senegal', false)
  end

  def test_mobile
    parse_test('+221786416455', '221', '7', '86416455', 'Senegal', true)
  end
end
