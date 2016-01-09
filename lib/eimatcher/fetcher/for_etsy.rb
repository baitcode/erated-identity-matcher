require 'etsy'

module Fetcher

  class ForEtsy < Fetcher::Configurable

    def get_user(user_id)
      Etsy.api_key = @config.etsy_keystring
      Etsy.api_secret = @config.etsy_shared_secret

      etsy_user = Etsy.user(user_id)

      user = Fetcher::User.new(
          username: user_id,
          first_name: etsy_user.profile.first_name,
          last_name: etsy_user.profile.last_name,
          about: etsy_user.profile.bio,
          photos: [etsy_user.profile.image],
          city: etsy_user.profile.city,
          shops: []
      )

      etsy_user.shops.map do |etsy_shop|
        shop = Fetcher::Shop.new(
            name: etsy_shop.name,
            photo: etsy_shop.image_url,
            goods: []
        )
        etsy_shop.listings.map do |listing|
          good = Fetcher::Good.new(
              title: listing.title,
              tags: listing.tags,
              images: listing.images.map {|e| e.full}
          )

          shop.goods.push(good)

        end

        user.shops.push(shop)
      end

      user
    end

    def get_shop(shop_id)
      raise NotImplementedError.new('Method not implemented')
    end

    def find_shops_by_keywords(keywords, min_price, max_price)
      raise NotImplementedError.new('Method not implemented')
    end

  end

end
