
module Fetcher

  class Registry
    include Singleton

    def initialize()
      @fetchers = {}
    end

    def get(type)
      @fetchers[type]
    end

    def register(type, fetcher)
      @fetchers[type] = fetcher
    end
  end

end
