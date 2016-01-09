module EIMatcher

  class Config

    def etsy_keystring=(keystring)
      @etsy_keystring = keystring
    end

    def etsy_keystring
      @etsy_keystring || '94wjlxol6j7s3ndm7bwmub7r'
    end

    def etsy_shared_secret=(secret)
      @etsy_shared_secret = secret
    end

    def etsy_shared_secret
      @etsy_shared_secret || '2wcvpa5rf6'
    end

  end

end
