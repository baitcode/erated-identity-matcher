require_relative './fetcher/base'
require_relative './fetcher/models'
require_relative './fetcher/for_dawanda'
require_relative './fetcher/for_etsy'
require_relative './fetcher/registry'

module Fetcher

  def self.get(type)
    return Fetcher::Registry.instance.get(type)
  end

end
