require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class CountryTest < Phonie::TestCase
  def test_find_by_country_name
    country = Phonie::Country.find_by_name('canada')
    assert_equal "Canada", country.name

    country = Phonie::Country.find_by_name('Canada')
    assert_equal "Canada", country.name

    assert_nil  Phonie::Country.find_by_name(nil)
    assert_nil  Phonie::Country.find_by_country_code(nil)
    assert_equal [],  Phonie::Country.find_all_by_phone_code(nil)
  end

  def test_find_by_country_code
    country = Phonie::Country.find_by_country_code('NO')
    assert_equal "Norway", country.name
  end

  def test_find_all_by_phone_code
    countries = Phonie::Country.find_all_by_phone_code('47')
    assert_equal 1, countries.length
    assert_equal "Norway", countries.first.name
  end

  def test_extra
    country = Phonie::Country.find_by_name('Canada')
    assert_equal 'Canada', country.extra[:name]
    assert_equal '011', country.extra[:international_dialing_prefix]
  end
end
