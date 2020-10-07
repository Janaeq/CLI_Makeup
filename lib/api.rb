# handle all of our api requests

class API

    def self.fetch_makeup(product)
        url = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=#{product}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        makeup = JSON.parse(response) #array of hashes
        makeup.each do |m| # m is the hash being iterated over
            a = Makeup.new(name: m["name"], brand: m["brand"], price: m["price"])
            # tags: m["tag_list"].join(", ")
            m["product_colors"].each do |color|
                a.colors << color["colour_name"]
               
            end
                # arr = []
                # arr.push(color["colour_name"])
                # arr
            
            

            #brand, tag list, product colors(color name) "This product comes in the following colors" Also maybe price. If it's free puts "What a steal!" lol. Maybe also ratings. puts "Other people rated this product a #{interpolate}".
            # maybe yes requested by user display product color names, price, ratings
            
        end
        # 
    end
end