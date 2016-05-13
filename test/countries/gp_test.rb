require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Guadeloupe
class GPTest < Phonie::TestCase
  def test_local
    parse_test('+590590878888', '590', '590', '878888', 'Guadeloupe', false)
  end

  def test_mobile
    parse_test('+590690638764', '590', '690', '638764', 'Guadeloupe', true)
  end

end
