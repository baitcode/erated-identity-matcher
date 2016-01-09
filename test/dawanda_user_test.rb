require 'test_helper'


class DawandaUserTest < Minitest::Test

  def test_check_if_user_is_correctly_fetched
    fetcher = Fetcher.get(:dawanda)
    user = fetcher.get_user('KOKOworld')
  end

end