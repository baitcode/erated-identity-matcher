require_relative './eimatcher/version'
require_relative './eimatcher/fetcher'
require_relative './eimatcher/config'

module EIMatcher
  @config = Config.new

  Fetcher::Registry.instance.register(:dawanda, Fetcher::ForDawanda.new(@config))
  Fetcher::Registry.instance.register(:etsy, Fetcher::ForEtsy.new(@config))


  def match(from, to, user_id)
    user = Fetcher.get(from).get_user(user_id)

    user.shops.each do |shop|
      some_goods = shop.goods[0..10]

      found = 0

      some_goods.each do |good|

      end


      Fetcher.get(to).find_shops_by_keywords()
    end



  end

end
