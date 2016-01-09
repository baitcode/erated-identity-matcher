require 'net/http'

module Fetcher

  class Configurable

    def initialize(config)
      super()
      @config = config
    end

    def get_user(user_id)
      raise NotImplementedError.new('Method not implemented')
    end

    def get_shop(shop_id)
      raise NotImplementedError.new('Method not implemented')
    end

    def find_shops_by_keywords(keywords)
      raise NotImplementedError.new('Method not implemented')
    end

  end

end
