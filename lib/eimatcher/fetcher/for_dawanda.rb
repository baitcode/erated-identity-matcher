require 'nokogiri'
require 'net/http'
require 'uri'

module Fetcher

  class ForDawanda < Fetcher::Configurable

    def request(urlstring)
      uri = URI.parse(urlstring)
      response = Net::HTTP.get_response(uri)
      Nokogiri::HTML(response.body)
    end

    def find_shops_by_keywords(keywords, min_price, max_price, page=1)

      url = 'http://en.dawanda.com/search'

      doc = self.request("#{url}?q=#{keywords.join('+')}&page=#{page}&sort_by=relevance&view_type=shops&price[min]=#{min_price-10}&price[min]=#{max_price+10}")

      highest_page_number = 0
      doc.css('.pagination.extended a').each do |page_link|
        page_number = page_link.text.to_i
        if page_number > highest_page_number
          highest_page_number = page_number
        end
      end

      while page < highest_page_number
        doc.css('.shops-list .shop').each do |element|
          shop_button_element = element.css('button').first
          if shop_button_element
            shop_id = shop_button_element['data-shop-subdomain']
            yield self.get_shop(shop_id)
          end
        end
        page += 1
        doc = self.request("#{url}?q=#{keywords.join('+')}&page=#{page}&sort_by=relevance&view_type=shops&price[min]=#{min_price-10}&price[min]=#{max_price+10}")
      end
    end

    def get_shop(shop_id, page=1)
      doc = self.request("http://en.dawanda.com/shop/#{shop_id}?page=#{page}&sort_by=newest_products")
      name = doc.css('#main article > header > .description > .title').text.strip

      goods = []
      doc.css('.product-list .products').each do |element|
        goods_picture = element.css('.product-pic > img').first
        pic = goods_picture['src']
        title = goods_picture['alt']
        goods.push(
          Fetcher::Good.new(
            title: title,
            tags: [],
            images: [pic]
          )
        )
      end

      Fetcher::Shop.new(
        name: name,
        photo: [],
        goods: []
      )
    end

    def get_user(user_id)
      doc = self.request("http://en.dawanda.com/user/#{user_id}")

      username = user_id
      doc.css('#content > .left.sidebar_left > h3 > a').each do |element|
        username = element.text.strip
      end

      about = ''
      doc.css('#content > .right.main > p').each do |element|
        about = element.text.strip
      end

      photo = ''
      doc.css('#user_header_inner > div > center > a > img').each do |element|
        photo = element['src'].strip
      end

      city = ''

      doc.css('#user_header_inner > div > div').each do |element|
        if element.text.downcase.include? 'location'
          city, _ = element.text.strip.split(',').each { |e| e.strip! }
        end
      end

      shops = []
      doc.css('#content > .right.main > .fancy_box').each do |element|
        element.css('.fancy_box_bar').each do |bar_element|
          if bar_element.text.downcase.include? 'my shop'
            shop_link_element = bar_element.css('.fancy_box_title.right > a')
            shop_id = shop_link_element.first['href'].strip.split('/')[-1]
            shops.push(
                self.get_shop(shop_id)
            )
          end
        end
      end

      Fetcher::User.new(
          username: username,
          first_name: '',
          last_name: '',
          about: about,
          photos: [photo],
          city: city,
          shops: shops
      )
    end
  end

end

