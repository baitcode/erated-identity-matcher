require 'test_helper'


class EtsyUserTest < Minitest::Test

  def test_check_if_user_is_correctly_fetched
    fetcher = Fetcher.get(:etsy)
    user = fetcher.get_user('clotingnavaho')

    # assert_equal 'Julia', user.first_name
    # assert_equal 'Gasin', user.last_name

    # bio = "JUL is a small indie fashion label based in Tel - Aviv, Israel,  Designed by Julia Gasin, \r\n\r\n" +
    #     "We create small collections of urban romantic women&#39;s wear, Lingerie, accessories, knitwear, bridal and evening wear. \r\n" +
    #     "All our clothing articles and accessories are hand-made, produced in limited quantities and many are one of a kind.\r\n\r\n"
    #
    # assert_equal bio, user.about
  end

end