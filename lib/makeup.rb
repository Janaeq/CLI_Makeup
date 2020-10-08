# going to keep track of makeup
# turn responses into objects
# save all makeup created

class Makeup
    attr_accessor :name, :brand, :price, :colors, :description, :website, :rating, :product

    @@all = []

    def initialize(name:, brand:, price:, description:, website:, rating:, product:)
        @name = name
        @brand = brand 
        @price = price
        @colors = []
        @description = description
        @website = website
        @rating = rating
        @product = product
        @@all << self
        
    end

    def self.all
        @@all
    end

    def self.find_by_product(product)
        @@all.select {|m| m.product == product}
        
    end
end