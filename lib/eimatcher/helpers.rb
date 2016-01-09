
module Singleton

  @@instance = self.new

  def self.instance
    @@instance
  end

end