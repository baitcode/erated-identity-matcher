
module Fetcher

  class Model

    def initialize(params)
      params.each { |key, value|
        self.send("#{key}=", value)
      }
    end

  end

  class User < Model
    attr_accessor 'url'
    attr_accessor 'username'
    attr_accessor 'first_name'
    attr_accessor 'last_name'
    attr_accessor 'about'
    attr_accessor 'photos'
    attr_accessor 'city'
    attr_accessor 'shops'
  end

  class Shop < Model
    attr_accessor 'url'
    attr_accessor 'name'
    attr_accessor 'photo'
    attr_accessor 'goods'
  end

  class Good < Model
    attr_accessor 'url'
    attr_accessor 'title'
    attr_accessor 'tags'
    attr_accessor 'images'
  end


end