require 'minitest/autorun'
require 'FontAwesomeScrapper'

class FontAwesomeScrapperTest < Minitest::Test
  def test_initilize
    scrapper = FontAwesomeScrapper.new

    assert_equal scrapper.class, FontAwesomeScrapper
  end

  def test_free_icons
    scrapper = FontAwesomeScrapper.new

    assert_equal scrapper.free_icons.class, Array
  end
end
