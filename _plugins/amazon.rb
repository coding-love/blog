# amazon.rb - amazon affiliate links for jekyll
# assumes that you have a configuration variable called 'amazon_associate_id' with your associate id

# usage: {{ asin | amazon_product_href }} 
# returns url of a product

# usage: {{ asin | amazon_image_href: 'M' }}
# returns image of the product, size argument can be S, M, or L, default M

# usage: {{ asin | amazon_product: 'A Product' }}
# returns an html link to a product

# usage: {{ asin | amazon_image: 'M' }}
# returns an html IMG of the product

module Jekyll
  module Filters
    def amazon_product_href(asin)
      "http://amazon.com/exec/obidos/ASIN/#{asin}/#{@context.registers[:site].config['amazon_associate_id']}"
    end

    def amazon_image_href(asin, size)
      "http://ws.assoc-amazon.com/widgets/q?_encoding=UTF8&ASIN=#{asin}&Format=_#{size ? size : 'M'}L110_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=#{@context.registers[:site].config['amazon_associate_id']}"
    end

    def amazon_product(asin, text)
      asin ? "<a href=\"#{amazon_product_href(asin)}\">#{text}</a>" : text
      
    end

    def amazon_image(asin, size)
      "<img src=\"#{amazon_image_href(asin, size)}\" />"
    end

    def amazon_search(text)
      "<iframe src=\"https://rcm-eu.amazon-adsystem.com/e/cm?t=cmart_blog-21&o=3&p=32&l=st1&mode=books-de&search=#{text}&fc1=000000&lt1=_blank&lc1=3366FF&bg1=FFFFFF&f=ifr\" 
      marginwidth=\"0\" marginheight=\"0\" width=\"180\" height=\"450\" border=\"0\" frameborder=\"0\" style=\"border:none;\" scrolling=\"no\"></iframe>"
    end

  end
end


Liquid::Template.register_filter(Jekyll::Filters)