$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'

require 'test/unit'
require 'phonie'

def parse_test(raw, country_code, area_code, number, country_name = nil, is_mobile = nil)
  pn = Phonie::Phone.parse!(raw)
  assert_equal pn.country_code, country_code
  assert_equal pn.area_code, area_code
  assert_equal pn.number, number
  if country_name
    assert_equal pn.country.name, country_name
  end

  unless is_mobile.nil?
    text = pn.is_mobile? ? :mobile : :local
    assert_equal is_mobile ? :mobile : :local, text
  end
end

def parse_failure(raw)
  pn = Phonie::Phone.parse!(raw)
  assert_equal pn, nil
end

class Phonie::TestCase < Test::Unit::TestCase

  def setup
    Phonie.configure do |config|
      config.default_country_code = nil
      config.default_area_code = nil
    end
  end

  def default_test
    klass = self.class.to_s
    ancestors = (self.class.ancestors - [self.class]).collect { |ancestor| ancestor.to_s }
    super unless klass =~ /TestCase/ or ancestors.first =~ /TestCase/
  end
end
