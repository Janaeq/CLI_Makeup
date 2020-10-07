# going to keep track of makeup
# turn responses into objects
# save all makeup created

class Makeup
    attr_accessor :name, :brand, :price, :colors, :description, :website, :rating

    @@all = []

    def initialize(name:, brand:, price:, description:, website:, rating:)
        @name = name
        @brand = brand 
        @price = price
        @colors = []
        @description = description
        @website = website
        @rating = rating
        @@all << self
        
    end

    def self.all
        @@all
    end
end