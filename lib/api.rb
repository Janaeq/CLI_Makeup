class API

    def self.fetch_makeup(product)
        url = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=#{product}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        makeup = JSON.parse(response) #array of hashes
        makeup.each do |m| # m is the hash being iterated over
            a = Makeup.new(name: m["name"], brand: m["brand"], price: m["price"], description: m["description"], website: m["product_link"], rating: m["rating"], product: m["product_type"])
            m["product_colors"].each do |color|
                a.colors << color["colour_name"]
            end
        end

    end

    # def self.get_details(brand) #maybe instead of doing this, we can find those products by brand
    #     binding.pry
    # end
end