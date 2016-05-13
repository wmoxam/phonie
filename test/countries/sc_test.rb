require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Seychelles
class SCTest < Phonie::TestCase
  def test_local
    parse_test('+2487985442', '248', '7', '985442', 'Seychelles', false)
  end

  def test_mobile
    parse_test('+2482729609', '248', '2', '729609', 'Seychelles', true)
  end

end
