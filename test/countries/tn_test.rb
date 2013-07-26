require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

## Tunisia
class TNTest < Phonie::TestCase
  def test_local
    parse_test('+21672534819',  '216', '72',  '534819', 'Tunisia', false)
  end

  def test_mobile
    parse_test('+21621826805', '216', '21', '826805', 'Tunisia', true)
  end
end

